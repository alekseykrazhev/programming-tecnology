//
//  WeatherGetterDelegate.swift
//  example7
//
//  Created by Кражевский Алексей И. on 6/7/22.
//

import Foundation

// MARK: WeatherGetterDelegate
// ===========================
// WeatherGetter should be used by a class or struct, and that class or struct
// should adopt this protocol and register itself as the delegate.
// The delegate's didGetWeather method is called if the weather data was
// acquired from OpenWeatherMap.org and successfully converted from JSON into
// a Swift dictionary.
// The delegate's didNotGetWeather method is called if either:
// - The weather was not acquired from OpenWeatherMap.org, or
// - The received weather data could not be converted from JSON into a dictionary.
protocol WeatherGetterDelegate {
  func didGetWeather(weather: Weather)
  func didNotGetWeather(error: NSError)
}


// MARK: WeatherGetter
// ===================

class WeatherGetter {
  
  private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
  private let openWeatherMapAPIKey = "7d78e4c21d045f5c6e9e7923ec662e3a"
 
  private var delegate: WeatherGetterDelegate
  
  
  // MARK: -
  
  init(delegate: WeatherGetterDelegate) {
    self.delegate = delegate
  }
  
  func getWeatherByCity(city: String) {
    let weatherRequestURL = NSURL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)")!
    getWeather(weatherRequestURL: weatherRequestURL)
  }
    
    func getWeatherByCoordinates(latitude: Double, longitude: Double) {
      let weatherRequestURL = NSURL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&lat=\(latitude)&lon=\(longitude)")!
        getWeather(weatherRequestURL: weatherRequestURL)
    }
    
  
  private func getWeather(weatherRequestURL: NSURL) {
    
    // This is a pretty simple networking task, so the shared session will do.
    let session = URLSession.shared
    
    // The data task retrieves the data.
    let dataTask = session.dataTask(with: weatherRequestURL as URL) {
        (data: Data?, response: URLResponse?, error: Error?) in
      if let networkError = error {
        // Case 1: Error
        // An error occurred while trying to get data from the server.
        self.delegate.didNotGetWeather(error: networkError as NSError)
      }
      else {
        // Case 2: Success
        // We got data from the server!
        do {
          // Try to convert that data into a Swift dictionary
            let weatherData = try JSONSerialization.jsonObject(
                with: data!,
                options: .mutableContainers) as! [String: AnyObject]

          // If we made it to this point, we've successfully converted the
          // JSON-formatted weather data into a Swift dictionary.
          // Let's now used that dictionary to initialize a Weather struct.
          let weather = Weather(weatherData: weatherData)
          
          // Now that we have the Weather struct, let's notify the view controller,
          // which will use it to display the weather to the user.
            self.delegate.didGetWeather(weather: weather)
        }
        catch let jsonError as NSError {
          // An error occurred while trying to convert the data into a Swift dictionary.
            self.delegate.didNotGetWeather(error: jsonError)
        }
      }
    }
    
    // The data task is set up...launch it!
    dataTask.resume()
  }
  
}
