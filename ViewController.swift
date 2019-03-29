//
//  ViewController.swift
//  Wendy - Weather
//
//  Created by SVOOMac on 2/26/19.
//  Copyright © 2019 varsha. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate, changeCityDelegate{
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "019bb8596eea3ce5e4c6f7fb5ab98f65"

    @IBOutlet weak var faren: UISwitch!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var weatherimage: UIImageView!
    
   // @IBAction func arrowAction(_ sender: Any) {
    //    let signinView = self.storyboard?.instantiateViewController(withIdentifier: "CityBasedWeatherID") as! CityBasedWeather
     //    self.navigationController?.pushViewController(signinView, animated: true)
       // self.present(signinView, animated: true, completion: nil)
    //}
    
    let locationmanager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    let citybase = CityBasedWeather()
    

    
    
   // @IBAction func `switch`(_ sender: UISwitch) {
    //    if sender.isOn {
            
   //     }
  //  }
    

    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citybase.delegate = self;
        
        //TODO:Set up the location manager here.
        locationmanager.delegate = self
        locationmanager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationmanager.requestWhenInUseAuthorization()
        locationmanager.startUpdatingLocation()
        
        
        
    }
    
    
    
    
    
    
    //write updateweather method & networking happens in asynchronous method
    func getWeatherData(url : String, parameters : [String : String] ){
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess{
                print("Success! got weather data")
                
                let weatherJSON : JSON = JSON(response.result.value!)
                self.updatedWeatherData(json: weatherJSON)
        
                
            }
            else{
                print("Error \(String(describing: response.result.error))")
                self.city.text = "Connection failed"
            }
        }
        
    }
    
    //JSON Parsing and weather data update
    func updatedWeatherData(json : JSON){
        
        if let tempResult = json["main"]["temp"].double {
        weatherDataModel.temperature = Int(tempResult - 273.15 )
        weatherDataModel.city = json["name"].stringValue
        weatherDataModel.condition = json["weather"][0]["id"].intValue
        weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            
        updateUIWithWeatherData()
            
      }
        else{
            city.text = "weather unavailable"
        }
            
            
            
    }
    
    //update UI method
    
    func updateUIWithWeatherData() {
        city.text = weatherDataModel.city
        temp.text = "\(weatherDataModel.temperature)"
        weatherimage.image = UIImage(named: weatherDataModel.weatherIconName)
        
    }
    
    
    //locationManager Delegate method
    
    //write didUpdatelocation methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]  // to grab the last value locations.count-1
        
        if location.horizontalAccuracy > 0{
            locationmanager.stopUpdatingLocation()
            print("Location = \(location.coordinate.longitude), \(location.coordinate.latitude)")
            
            let longitude = String(location.coordinate.longitude)
            let latitude = String(location.coordinate.latitude)
            
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]   //lat & lon are got from the documentation in the weather website documentation
            
            getWeatherData(url : WEATHER_URL, parameters : params)
            
        }
        
        
        
    }
    
    
    //did fail error method
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        city.text = "location unavailable!"
    }
    
    
    
    
    //change city delegates
    func userEnteredNewCityName(cityNameText:String) {
        
        print(cityNameText)
        
        let params : [String : String] = ["q" : cityNameText , "appid" : APP_ID]
        
        getWeatherData(url: WEATHER_URL, parameters: params)
    
    }
    
    
    //user entered a new city delegate method here

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoCity" {
            
            let destinationVC = segue.destination as! CityBasedWeather
            
            
            destinationVC.delegate = self
  }
    
    
}

}
