//
//  PlaceControllerLocation.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 11/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import CoreLocation

extension PlaceController: CLLocationManagerDelegate {
    
    func handleCurrentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard currentLocation == nil else { return }
        let newLocation = locations.last ?? nil
        
        currentLocation = newLocation
        locationManager.stopUpdatingLocation()
        
        latitude = Double(currentLocation.coordinate.latitude)
        longitude  = Double(currentLocation.coordinate.longitude)
        
        locationManager.delegate = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch(status ) {
            case .notDetermined, .restricted, .denied: break
            case .authorizedAlways, .authorizedWhenInUse:
                  manager.startUpdatingLocation()
                  break
            @unknown default: break
        }
    }
}
