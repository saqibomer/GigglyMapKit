//
//  GigglyMap.swift
//  GigglyMap
//
//  Created by Saqib Omer on 11/18/15.
//  Copyright © 2015 KaboomLab. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit


class GigglyMap: NSObject, CLLocationManagerDelegate {
    
    //Properties
    internal var locPermission : Bool!
    private let locationManager = CLLocationManager()
    
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    
    
    // Methods
    
    //MARK: - Request permission for location
    
    func requestForLocation () {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    func locPermissionsStatus() ->Bool {
        
        
        let status = CLLocationManager.authorizationStatus()
        
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
        
            return true
        }
        else {
            return false
        }
        
        
    }
    
    func loadMapView(mapView : MKMapView) {
        var currentLocation = CLLocation!()
        currentLocation = locationManager.location
        
        let regionRadius: CLLocationDistance = 1000
        
        let annotation = MKPointAnnotation()
        
        if let loc = currentLocation {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(loc.coordinate,
                regionRadius * 2.0, regionRadius * 2.0)
            annotation.coordinate = loc.coordinate
            mapView.setRegion(coordinateRegion, animated: true)
            mapView.addAnnotation(annotation)
        }
    }
    
    func searchLocationByName (searchString : String, mapView : MKMapView) {
        print(searchString)
        
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = searchString
        localSearch = MKLocalSearch(request: localSearchRequest)
        
        localSearch.startWithCompletionHandler { (localSearchResponse, error: NSError?) -> Void in
            
            if localSearchResponse == nil {
                print("No Such Location Found")
                return
            }
            let regionRadius: CLLocationDistance = 1000
            let coords = CLLocationCoordinate2D(latitude: (localSearchResponse?.boundingRegion.center.latitude)!, longitude: (localSearchResponse?.boundingRegion.center.longitude)!)
            let coordRegion = MKCoordinateRegionMakeWithDistance(coords, regionRadius * 2.0, regionRadius * 2.0)

            self.pointAnnotation = MKPointAnnotation()
            self.pointAnnotation.title = searchString
            self.pointAnnotation.coordinate = coords
            
            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
            
            mapView.removeAnnotations(mapView.annotations) // Remove Prvious annotations
            mapView.setRegion(coordRegion, animated: true)
            mapView.addAnnotation(self.pinAnnotationView.annotation!)
            
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .AuthorizedWhenInUse {
            print("Granted")
//            currentLocation = manager.location
        }
        else if status == .Denied || status == .Restricted{
            print("Not Granted")
        }
        else if status == .NotDetermined {
            print("Not Determined")
        }
        else {
            print("Location Error")
        }
    }
}