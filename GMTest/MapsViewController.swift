//
//  MapViewController.swift
//  GMTest
//
//  according to : https://developers.google.com/maps/documentation/ios-sdk/start?hl=en
//  Created by Alex Dontsov on 31.10.16.
//  Copyright © 2016 Kinect.Pro. All rights reserved.
//

import UIKit
import GoogleMaps

@objc
protocol MapsViewControllerDelegate {
    @objc optional func toggleMenu()
}

class MapsViewController: UIViewController {
    var delegate: MapsViewControllerDelegate?
    var mapView = GMSMapView()
    let marker = GMSMarker()
    
    var locationManager = CLLocationManager()
    var didFindMyLocation = false
    let defaultMapZoom : Float = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let camera = GMSCameraPosition()
       
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        marker.map = mapView
        mapView.isMyLocationEnabled = true
        
        self.view = mapView
        
    }
    
    // MARK: Button actions
    @IBAction func menuTapped(sender: AnyObject) {
        delegate?.toggleMenu?()
    }
    
}

extension MapsViewController: MenuViewControllerDelegate {
    func menuItemSelected(item: City) {
        delegate?.toggleMenu?()
        let camera = GMSCameraPosition.camera(withTarget: item.coordinates, zoom: defaultMapZoom)
        mapView.animate(to: camera)
        marker.title = item.title
        marker.position = item.coordinates
        mapView.selectedMarker = marker
    }
}

extension MapsViewController: CLLocationManagerDelegate {
  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude:(location?.coordinate.longitude)!, zoom:defaultMapZoom)
        mapView.animate(to: camera)
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
        
    }
}
