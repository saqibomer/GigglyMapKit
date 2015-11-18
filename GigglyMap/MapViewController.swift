//
//  ViewController.swift
//  GigglyMap
//
//  Created by Saqib Omer on 11/18/15.
//  Copyright © 2015 KaboomLab. All rights reserved.
//

/*********************** Important ***************************/

/*    Important: In your info.plist add key NSLocationWhenInUseUsageDescription and some description 
*/

import UIKit
import MapKit

class MapViewController: UIViewController {

    //Proeprties
    let gigglyMap = GigglyMap()
    var permissionStatus : Bool!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Request for user lcoation
        gigglyMap.requestForLocation()
        let status = gigglyMap.locPermissionsStatus()
        
        //If Location permission is granted. Load mapView
        if status {
            gigglyMap.loadMapView(mapView)
        }
        else {
            print("Show Error to get Location")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

