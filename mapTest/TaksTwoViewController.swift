//
//  TaksTwoViewController.swift
//  mapTest
//
//  Created by Gerardo Valdes on 19/04/21.
//

import UIKit
import GoogleMaps

class TaksTwoViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var containerView: UIView!
    
    var locationManager: CLLocationManager?
            
    override func viewDidLayoutSubviews() {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 16.0)
        
        let mapView = GMSMapView.map(withFrame: self.containerView.frame, camera: camera)
        self.containerView.addSubview(mapView)
        
        let marker = GMSMarker()
               marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
               marker.title = "Sydney"
               marker.snippet = "Australia"
        // style
        do {
              // Set the map style by passing the URL of the local file.
              if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
              } else {
                NSLog("Unable to find style.json")
              }
            } catch {
              NSLog("One or more of the map styles failed to load. \(error)")
            }
        
               marker.map = mapView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
    }

        
    func monitorRegionAtLocation(center: CLLocationCoordinate2D, identifier: String ) {
        // Make sure the devices supports region monitoring.
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            // Register the region.
            let maxDistance = self.locationManager!.maximumRegionMonitoringDistance
            let region = CLCircularRegion(center: center,
                 radius: maxDistance, identifier: identifier)
            region.notifyOnEntry = true
            region.notifyOnExit = false
       
            locationManager!.startMonitoring(for: region)
            
        }
        
    }
    
    
    func displayAlert(location: String) {
        
        let alert = UIAlertController(title: "Welcome", message: "You are entering the \(location)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
        
    }
    
}
