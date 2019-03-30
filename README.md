# Location-based-Weather-App-Using-Swift
Install pod 'SwiftyJSON' pod 'AlamoFire' pod 'SVGProgressHUD'

Import CoreLocation and add CLLocationManagerDelegate to ViewController 
Create Weather API in http://www.openweathermap.org 
Add the weather url and API in the project 
Update info.plist by adding privacy-location when in use usage description & privacy-location usage description 

Add the following XML code to info.plist by opening it in the source code mode:

<key>NSAppTransportSecurity</key>
   <key>NSExceptionDomains</key>
     <dict>
       <key>openweathermap.org</key>
       <dict>
          <key>NSIncludesSubdomains</key>
          <true/>
          <key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
          <true/>
        </dict>
      </dict>
    </dict>
