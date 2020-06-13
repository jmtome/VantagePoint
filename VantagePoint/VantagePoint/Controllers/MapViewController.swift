//
//  MapViewController.swift
//  VantagePoint
//
//  Created by Juan Manuel Tome on 11/06/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol MapViewControllerDelegate: class {
    func mapViewController(_ vc: MapViewController, didAddNewData data: VantagePoint)
    //func mapViewController(_ vc: MapViewController, didUpdateDataWith data: VantagePoint)
}

class MapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    var selectedPin: MKPlacemark? = nil
    weak var delegate: MapViewControllerDelegate? = nil
    
    let locationManager = CLLocationManager()
    var searchController: UISearchController? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        
        locationManagerSetup()
        mapView.delegate = self
        tableVCSetup()
        
        let searchBar = searchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search"
        navigationItem.titleView = searchController?.searchBar
        
        searchController?.hidesNavigationBarDuringPresentation = false
        searchController?.obscuresBackgroundDuringPresentation = true
        definesPresentationContext = true
        
//        searchController = UISearchController(searchResultsController: nil)
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = true
//        searchController.searchBar.placeholder = "Type here"
//        navigationItem.searchController = searchController
    }
    deinit {
        print("deallocated")
    }
    

    func tableVCSetup() {
        let locationSearchTable = storyboard!.instantiateViewController(identifier: "LocationSearchTable") as! LocationSearchTable
        locationSearchTable.mapView = mapView
        searchController = UISearchController(searchResultsController: locationSearchTable)
        searchController?.searchResultsUpdater = locationSearchTable
        locationSearchTable.handleMapSearchDelegate = self
    }
    
    
   

}

extension MapViewController: HandleMapSearch {
    func dropPinZoomIn(placemark: MKPlacemark) {
        selectedPin = placemark
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        
        if let city = placemark.locality, let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        // show the previously created annotation callout
        mapView.selectAnnotation(annotation, animated: true)
    }
    
    
}


extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let identifier = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            annotationView?.canShowCallout = true
            annotationView?.isDraggable = true
            annotationView?.pinTintColor = .orange
            
            let smallSquare = CGSize(width: 30, height: 30)
            let button = UIButton(frame: CGRect(origin: .zero, size: smallSquare))
            button.setBackgroundImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
            button.addTarget(self, action: #selector(addNewVP), for: .touchUpInside)
            
            //let btn = UIButton(type: .contactAdd)
        
            annotationView?.rightCalloutAccessoryView = button
            //let btn2 = UIButton(type: .close)
            //annotationView?.leftCalloutAccessoryView = btn2
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        
    }
    
    @objc private func addNewVP() {
        if let selectedPin = selectedPin {
            //print(selectedPin.name)
            
            //let mapItem = MKMapItem(placemark: selectedPin)
            
            let vc = storyboard?.instantiateViewController(identifier: "myModalView") as! DetailViewController
            vc.delegate = self
            
            vc.newPlace = VantagePoint(from: selectedPin, placeName: selectedPin.name ?? "noname", placeImage: #imageLiteral(resourceName: "placeholder"), isFavourite: false)
            //vc.newPlace = VantagePoint(from: mapItem, placeName: mapItem.placemark.title!, placeImage: #imageLiteral(resourceName: "Oslo"), isFavourite: false)
//            vc.modalPresentationStyle = .pageSheet
//            present(vc, animated: true)
            //vc.navigationItem.rightBarButtonItem = editButtonItem
            navigationController?.pushViewController(vc, animated: true)
            //let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            //mapItem.openInMaps(launchOptions: launchOptions)
        }
    }
}

extension MapViewController: DetailViewControllerDelegate {
    func detailViewController(_ vc: DetailViewController, didAddNewData data: VantagePoint) {
        self.delegate?.mapViewController(self, didAddNewData: data)
        
    }
    
    func detailViewController(_ vc: DetailViewController, didUpdateDataWith data: VantagePoint) {
        
    }
    
    
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManagerSetup() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error \(error)")
    }
    
}
