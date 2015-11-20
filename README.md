# GigglyMapKit
# Implementation of Mapkit using Swift 2.0
How to use.
* Add GigglyMap class in your project. 
* Create an instance of GigglyMap. Call requestForLocation(). 
* Get Status of location permission with locPermissionsStatus(). 
* Use MapKit View with loadMapView()

To search a place
* Add A search bar control and set its delegate. Than in UISearchBarDelegate's searchBarSearchButtonClicked method call gigglyMap.searchLocationByName(searchBar.text!, mapView: mapView)
