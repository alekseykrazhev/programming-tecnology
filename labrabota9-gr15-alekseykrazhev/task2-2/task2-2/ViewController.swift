//
//  ViewController.swift
//  task2-2
//
//  Created by Кражевский Алексей И. on 6/9/22.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

let locationManager = CLLocationManager()
var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D (latitude: 0, longitude: 0)

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet var gestureRecognizer: UILongPressGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 2. setup locationManager
        task2_2.locationManager.delegate = self;
        task2_2.locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters;
        task2_2.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
                 
        // 3. setup mapView
        map.delegate = self
        map.showsUserLocation = true
        map.userTrackingMode = .follow
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     
        // 1. status is not determined
        if CLLocationManager.authorizationStatus() == .notDetermined {
            task2_2.locationManager.requestAlwaysAuthorization()
        }
        // 2. authorization were denied
        else if CLLocationManager.authorizationStatus() == .denied {
            print("Location services were previously denied. Please enable location services for this app in Settings.")
        }
        // 3. we do have authorization
        else if CLLocationManager.authorizationStatus() == .authorizedAlways {
            task2_2.locationManager.startUpdatingLocation()
        }
    }
    
    @IBAction func getDataClichked(_ sender: Any) {
        performSegue(withIdentifier: "toData", sender: self)
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toWeather", sender: self)
    }
    
    // 6. draw circle
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.strokeColor = UIColor.red
        circleRenderer.lineWidth = 1.0
        return circleRenderer
    }
    
    // 1. user enter region
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("enter \(region.identifier)")
    }
     
    // 2. user exit region
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("exit \(region.identifier)")
    }

    @IBAction func longPressHandle(_ sender: Any) {
        let touchPoint = gestureRecognizer.location(in: map)
        let newCoordinates = map.convert(touchPoint, toCoordinateFrom: map)
        let annotation = MKPointAnnotation()
        annotation.coordinate = newCoordinates
        task2_2.coordinate = newCoordinates
        map.addAnnotation(annotation)
    }
}


class NewViewController: UIViewController, UITextFieldDelegate, WeatherGetterDelegate, CLLocationManagerDelegate{

    var weather: WeatherGetter!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var coludCoverLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    func didGetWeather(weather: Weather) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.city
            self.weatherLabel.text = weather.weatherDescription
            self.temperatureLabel.text = "\(Int(round(weather.tempCelsius)))°"
            self.coludCoverLabel.text = "\(weather.cloudCover)%"
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
        print("didNotGetWeather error: \(error)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weather = WeatherGetter(delegate: self)
        
        // Do any additional setup after loading the view.
        
        // Initialize UI
        // -------------
        cityLabel.text = "simple weather"
        weatherLabel.text = ""
        temperatureLabel.text = ""
        coludCoverLabel.text = ""
        windLabel.text = ""
        rainLabel.text = ""
        humidityLabel.text = ""
        
        //getLocation()
        weather.getWeatherByCoordinates(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }

    func getLocation() {
        guard CLLocationManager.locationServicesEnabled() else {
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
              return
              
          case .notDetermined:
            task2_2.locationManager.requestWhenInUseAuthorization()
              
            default:
              print("Oops! Shouldn't have come this far.")
          }
          
          return
        }
        task2_2.locationManager.delegate = self
        task2_2.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        task2_2.locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            print("location:: (location)")
        }

    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
}

extension String {
  
  // A handy method for %-encoding strings containing spaces and other
  // characters that need to be converted for use in URLs.
  var urlEncoded: String {
    return self.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!
  }
    
}

class DataViewController: UIViewController{
    
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var routeField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //var city = City()
        descriptionField.text = "some text"
        routeField.text = "route"
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Cities", in: context)
        let newCity = NSManagedObject(entity: entity!, insertInto: context)
        
        newCity.setValue("Movilev", forKey: "city")
        newCity.setValue("some text", forKey: "info")
        newCity.setValue("some route", forKey: "route")
        
        do {
           try context.save()
          } catch {
           print("Failed saving")
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cities")
                //request.predicate = NSPredicate(format: "age = %@", "12")
                request.returnsObjectsAsFaults = false
                do {
                    let result = try context.fetch(request)
                    for data in result as! [NSManagedObject] {
                       print(data.value(forKey: "info") as! String)
                  }
                    
                } catch {
                    print("Failed")
                }
    }
}
