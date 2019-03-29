//
//  CityBasedWeather.swift
//  Wendy - Weather
//
//  Created by SVOOMac on 2/26/19.
//  Copyright © 2019 varsha. All rights reserved.
//

import UIKit

protocol changeCityDelegate {
    func userEnteredNewCityName(cityNameText: String)
}


class CityBasedWeather: UIViewController {

    var delegate : changeCityDelegate?
    
    @IBOutlet weak var cityWeather: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func getWeather(_ sender: Any) {
        
        let cityName = cityWeather.text!
        print(cityName)
        delegate?.userEnteredNewCityName(cityNameText: cityName)
          self.dismiss(animated: true, completion: nil)
        }
        //delegate?.userEnteredNewCityName(city: cityName)
        //self.dismiss(animated: true, completion: nil)
        
        
        
        
    
    
    @IBAction func backButton(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
