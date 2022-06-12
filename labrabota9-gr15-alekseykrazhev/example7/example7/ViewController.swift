//
//  ViewController.swift
//  example7
//
//  Created by Кражевский Алексей И. on 6/7/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITextFieldDelegate, WeatherGetterDelegate, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    @IBOutlet weak var getLocationWeatherButton: UIButton!
    
    func didGetWeather(weather: Weather) {
        // This method is called asynchronously, which means it won't execute in the main queue.
        // ALl UI code needs to execute in the main queue, which is why we're wrapping the code
        // that updates all the labels in a dispatch_async() call.
        DispatchQueue.main.async {
        self.cityLabel.text = weather.city
        self.weatherLabel.text = weather.weatherDescription
        self.temperatureLabel.text = "\(Int(round(weather.tempCelsius)))°"
        self.cloudCoverLabel.text = "\(weather.cloudCover)%"
        self.windLabel.text = "\(weather.windSpeed) m/s"
              
        if let rain = weather.rainfallInLast3Hours {
            self.rainLabel.text = "\(rain) mm"
        }
        else {
            self.rainLabel.text = "None"
        }
              
        self.humidityLabel.text = "\(weather.humidity)%"
        }
    }
    
    func didNotGetWeather(error: NSError) {
        // This method is called asynchronously, which means it won't execute in the main queue.
            // ALl UI code needs to execute in the main queue, which is why we're wrapping the call
            // to showSimpleAlert(title:message:) in a dispatch_async() call.
        print("didNotGetWeather error: \(error)")
    }
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var cloudCoverLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var getCityWeatherButton: UIButton!
    
    var weather: WeatherGetter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        weather = WeatherGetter(delegate: self)
            
        // Initialize UI
        // -------------
        cityLabel.text = "simple weather"
        weatherLabel.text = ""
        temperatureLabel.text = ""
        cloudCoverLabel.text = ""
        windLabel.text = ""
        rainLabel.text = ""
        humidityLabel.text = ""
        cityTextField.text = ""
        cityTextField.placeholder = "Enter city name"
        cityTextField.delegate = self
        cityTextField.enablesReturnKeyAutomatically = true
        getCityWeatherButton.isEnabled = false
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      }
      
    
    @IBAction func getWeatherForCityButtonTapped(_ sender: Any) {
        guard let text = cityTextField.text, !text.isEmpty else {
              return
            }
        weather.getWeatherByCity(city: text)
        setWeatherButtonStates(state: true)
    }
    
    // MARK: - UITextFieldDelegate and related methods
      // -----------------------------------------------

      // Enable the "Get weather for the city above" button
      // if the city text field contains any text,
      // disable it otherwise.
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                     replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(
            in: range,
            with: string)
        getCityWeatherButton.isEnabled = prospectiveText.count > 0
        print("Count: \(prospectiveText.count)")
        return true
      }
    
    // Pressing the clear button on the text field (the x-in-a-circle button
      // on the right side of the field)
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // Even though pressing the clear button clears the text field,
        // this line is necessary. I'll explain in a later blog post.
        textField.text = ""
        
        getCityWeatherButton.isEnabled = false
        return true
      }
    
    // Pressing the return button on the keyboard should be like
      // pressing the "Get weather for the city above" button.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        getWeatherForCityButtonTapped(getCityWeatherButton!)
        return true
      }

    // location
    @IBAction func getCurrentLocationButtonPressed(_ sender: Any) {
        setWeatherButtonStates(state: false)
        getLocation()
    }
    
    func setWeatherButtonStates(state: Bool) {
        getLocationWeatherButton.isEnabled = state
        getCityWeatherButton.isEnabled = state
    }
    
    func getLocation() {
        guard CLLocationManager.locationServicesEnabled() else {
            getLocationWeatherButton.isEnabled = true
            return
        }
        
        let authStatus = CLLocationManager.authorizationStatus()
        guard authStatus == .authorizedWhenInUse else {
          switch authStatus {
          case .denied, .restricted:
              let alert = UIAlertController(
                title: "Location services for this app are disabled",
                message: "In order to get your current location, please open Settings for this app, choose \"Location\"  and set \"Allow location access\" to \"While Using the App\".",
                preferredStyle: .alert
              )
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let openSettingsAction = UIAlertAction(title: "Open Settings", style: .default) {
                action in
                if let url = NSURL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.openURL(url as URL)
                }
              }
              alert.addAction(cancelAction)
              alert.addAction(openSettingsAction)
            present(alert, animated: true, completion: nil)
            getLocationWeatherButton.isEnabled = true
              return
              
          case .notDetermined:
              locationManager.requestWhenInUseAuthorization()
              
            default:
              print("Oops! Shouldn't have come this far.")
          }
          
          return
        }
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      let newLocation = locations.last!
     weather.getWeatherByCoordinates(latitude: newLocation.coordinate.latitude,
                                      longitude: newLocation.coordinate.longitude)
    }

    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
      // This method is called asynchronously, which means it won't execute in the main queue.
      // All UI code needs to execute in the main queue, which is why we're wrapping the call
      // to showSimpleAlert(title:message:) in a dispatch_async() call.
      print("locationManager didFailWithError: \(error)")
    }
    
}

extension String {
  
  // A handy method for %-encoding strings containing spaces and other
  // characters that need to be converted for use in URLs.
  var urlEncoded: String {
    return self.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!
  }
    
}
