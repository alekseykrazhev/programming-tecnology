//
//  WeatherGetter.swift
//  example7
//
//  Created by Кражевский Алексей И. on 6/7/22.
//

import Foundation

import Foundation

class WeatherGettera {
  
  private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
  private let openWeatherMapAPIKey = "7d78e4c21d045f5c6e9e7923ec662e3a"
  
  func getWeatherInfo(city: String) {
    
    // *** 1 ***
    let session = URLSession.shared

    // *** 2 ***
    let weatherRequestURL = URL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)")!
    
    // *** 3 ***
    let dataTask = session.dataTask(with: weatherRequestURL) {
        (data: Data?, response: URLResponse?, error: Error?) in
      // *** 4 ***
      if let error = error {
        // Case 1: Error
        // We got some kind of error while trying to get data from the server.
        print("Error:\n\(error)")
      }
      // *** 5 ***
      else {
        // Case 2: Success
        // We got a response from the server!
        do {
          // Try to convert that data into a Swift dictionary
            let weather = try JSONSerialization.jsonObject(
                with: data!,
                options: .mutableContainers) as! [String: AnyObject]

          // If we made it to this point, we've successfully converted the
          // JSON-formatted weather data into a Swift dictionary.
          // Let's print its contents to the debug console.
          print("Date and time: \(weather["dt"]!)")
          print("City: \(weather["name"]!)")
          
          print("Longitude: \(weather["coord"]!["lon"]!!)")
          print("Latitude: \(weather["coord"]!["lat"]!!)")
        /*
          print("Weather ID: \(weather["weather"]![0]!["id"]!!)")
          print("Weather main: \(weather["weather"]![0]!["main"]!!)")
          print("Weather description: \(weather["weather"]![0]!["description"]!!)")
          print("Weather icon ID: \(weather["weather"]![0]!["icon"]!!)")
        */
          print("Temperature: \(weather["main"]!["temp"]!!)")
          print("Humidity: \(weather["main"]!["humidity"]!!)")
          print("Pressure: \(weather["main"]!["pressure"]!!)")

          print("Cloud cover: \(weather["clouds"]!["all"]!!)")

          print("Wind direction: \(weather["wind"]!["deg"]!!) degrees")
          print("Wind speed: \(weather["wind"]!["speed"]!!)")

          print("Country: \(weather["sys"]!["country"]!!)")
          print("Sunrise: \(weather["sys"]!["sunrise"]!!)")
          print("Sunset: \(weather["sys"]!["sunset"]!!)")
        }
        catch let jsonError as NSError {
          // An error occurred while trying to convert the data into a Swift dictionary.
          print("JSON error description: \(jsonError.description)")
        }
      }
    }

    // *** 6 ***
    dataTask.resume()
  }
  
}
