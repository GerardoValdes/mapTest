//
//  taskOneViewController.swift
//  mapTest
//
//  Created by Gerardo Valdes on 19/04/21.
//

import UIKit
import GoogleMaps

class TaskOneViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var usersArray = [User]()

    var tappedMarker : GMSMarker?
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! usersTableViewCell
        let user = usersArray[indexPath.row]
        cell.nameLabel.text = "\(user.name) \(user.lastname)"
        cell.followbutton.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
        cell.followbutton.tag = indexPath.row

        return cell
    }
    

    @IBOutlet weak var mapContainer: UIView!
    
    override func viewDidLayoutSubviews() {
        let camera = GMSCameraPosition.camera(withLatitude: 37.6554325, longitude: -121.8954451, zoom: 16.0)
        
        let mapView = GMSMapView.map(withFrame: self.mapContainer.frame, camera: camera)
        mapView.delegate = self
        
        self.mapContainer.addSubview(mapView)
        
        for user in usersArray {
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: user.latitude, longitude: user.longitude)
 
            //marker.icon = UIImage(named: "marker")
            
            let view = UINib(nibName: "mView", bundle: .main).instantiate(withOwner: nil, options: nil).first as! mView
            
            view.label.text = "\(user.name.first!)\(user.lastname.first!)"
            view.layer.cornerRadius = view.frame.size.width/2
            view.clipsToBounds = true
            
            marker.iconView = view
            marker.map = mapView

        }
    
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
    }
    
    
    @objc func connected(sender: UIButton){
        
        if sender.title(for: .normal) == "Follow"{
            sender.setTitle("Following", for: .normal)
            sender.backgroundColor = UIColor.lightGray
        } else {
            sender.setTitle("Follow", for: .normal)
            sender.backgroundColor = UIColor.black
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateMockInfo()

    }
    
    func generateMockInfo() {
        
        let userOne = User(name: "Gerardo", lastname: "Valdes", latitude: 37.6558147, longitude: -121.895724)
        let userTwo = User(name: "Ruby", lastname: "Delgado", latitude: 37.656722, longitude:
                            -121.8937143)
        let userThree = User(name: "Lebron", lastname: "James", latitude: 37.657802, longitude: -121.897711)

        usersArray = [userOne,userTwo,userThree]
        
    }
    
    

}
