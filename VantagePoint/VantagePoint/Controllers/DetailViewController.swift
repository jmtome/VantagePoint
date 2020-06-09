//
//  DetailViewController.swift
//  VantagePoint
//
//  Created by Juan Manuel Tome on 05/06/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


// MARK: - Delegate Protocol Prototypes
protocol DetailViewControllerDelegate: class {
    func detailViewController(_ vc: DetailViewController, didAddNewData data: VantagePoint)
    func detailViewController(_ vc: DetailViewController, didUpdateDataWith data: VantagePoint)
}


// MARK: - Main Class
class DetailViewController: UIViewController {
    
    // MARK: - Delegate
    weak var delegate: DetailViewControllerDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet var rightButton: UIButton!
    @IBOutlet var vpImage: UIImageView!
    @IBOutlet var placeTextField: UITextField!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var latitude: UITextField! {
        didSet { latitude?.addDoneCancelToolbar() }
    }
    @IBOutlet var longitude: UITextField! {
        didSet { longitude?.addDoneCancelToolbar() }
    }
    @IBOutlet var addPhotoButton: UIButton!
    
    
    // MARK: - Properties
    
    var editWasToggled = false
    var isButtonHidden = false
    var location = VPLocation(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "capital of england")
    
    var newPlace: VantagePoint?
    

    // MARK: - View Cycle Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let place = newPlace {
            vpImage.image = place.placeImage
            latitude.text = String(format: "%.2f", place.location.coordinate.latitude)
            longitude.text = String(format: "%.2f", place.location.coordinate.longitude)
            placeTextField.text = place.placeName
            print(latitude.text!)
            print(longitude.text!)
            location = place.location
            
        } else {
            //newplace wasnt passed and this is a new view
            latitude.text = String(format: "%.2f", location.coordinate.latitude)
            longitude.text = String(format: "%.2f", location.coordinate.longitude)
            if let location = newPlace?.location {
                self.location = location
            }
        }
        
        rightButton.isHidden = isButtonHidden
        navigationItem.rightBarButtonItem = editButtonItem
        
        if !isEditing && isButtonHidden {
            placeTextField.isEnabled = false
            latitude.isEnabled = false
            longitude.isEnabled = false
            addPhotoButton.isEnabled = false 
        }
        
        mapView.layer.masksToBounds = true
        mapView.layer.cornerRadius = 20
        rightButton.setTitle("Add", for: .normal)
        
        latitude.delegate = self
        longitude.delegate = self
        placeTextField.delegate = self
        rightButton.addTarget(self, action: #selector(addNew), for: .touchUpInside)
        
        mapView.delegate = self
        let center: CLLocationCoordinate2D = location.coordinate
        
        mapView.setCenter(center, animated: true)
        
        
        // Specify the scale (display area).
        let mySpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        let myRegion: MKCoordinateRegion = MKCoordinateRegion(center: center, span: mySpan)
        
        // Add region to MapView.
        mapView.region = myRegion
        
        let myLongPress: UILongPressGestureRecognizer = UILongPressGestureRecognizer()
        myLongPress.addTarget(self, action: #selector(recognizeLongPress(_:)))
        
        // Added UIGestureRecognizer to MapView.
        mapView.addGestureRecognizer(myLongPress)
        
        mapView.addAnnotation(location)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            if editWasToggled {
                newPlace?.placeName = placeTextField.text
                newPlace?.location = location
                newPlace?.placeImage = vpImage.image
                
                //newPlace = VantagePoint(placeName: placeTextField.text, location: location, placeImage: vpImage.image)
                self.delegate?.detailViewController(self, didUpdateDataWith: newPlace!)
            }
        }
    }
    

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        
        if editing {
            placeTextField.isEnabled = true
            latitude.isEnabled = true
            longitude.isEnabled = true
            editWasToggled = true
            addPhotoButton.isEnabled = true
            
        } else {
            placeTextField.isEnabled = false
            latitude.isEnabled = false
            longitude.isEnabled = false
            addPhotoButton.isEnabled = false
        }
    }
    
    // MARK: - Private Methods
    
    @objc private func addNew() {
        let newPoint = VantagePoint(placeName: placeTextField.text, location: location, placeImage: vpImage.image)
        
        self.dismiss(animated: true, completion: {
            self.delegate?.detailViewController(self, didAddNewData: newPoint)
        })
    }
    @IBAction private func addPhoto(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    // A method called when long press is detected.
    @objc private func recognizeLongPress(_ sender: UILongPressGestureRecognizer) {
        // Do not generate pins many times during long press.
        if sender.state != UIGestureRecognizer.State.began { return }
        
        // Get the coordinates of the point you pressed long.
        let location = sender.location(in: mapView)
        
        // Convert location to CLLocationCoordinate2D.
        let myCoordinate: CLLocationCoordinate2D = mapView.convert(location, toCoordinateFrom: mapView)
        
        // Generate pins.
        let myPin: VPLocation = VPLocation(title: "dropped", coordinate: myCoordinate, info: "some dropped info")
        
        // Added pins to MapView.
        mapView.addAnnotation(myPin)
    }
    
    
}

// MARK: - UIImagePickerControllerDelegate Conformance
extension DetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        
        //        let imageName = UUID().uuidString
        //        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        //
        //        if let jpegData = image.jpegData(compressionQuality: 0.8) {
        //            try? jpegData.write(to: imagePath)
        //        }
        picker.dismiss(animated: true, completion:{
            self.vpImage.image = image
        })
    }
    
    //    func getDocumentsDirectory() -> URL {
    //        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    //        let documentsDirectory = paths[0]
    //        return documentsDirectory
    //    }
    
}

// MARK: - UITextFieldDelegate Conformance
extension DetailViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 || textField.tag == 2 {
            textField.keyboardType = .decimalPad
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        mapView.removeAnnotations(mapView.annotations)
        if textField.tag == 1 {
            // should probably make a sanity check but since keyboard is only decimal i wont
            location.coordinate.latitude = Double(textField.text!) ?? 0.0
        }
        if textField.tag == 2 {
            location.coordinate.longitude = Double(textField.text!) ?? 0.0
        }
        mapView.addAnnotation(location)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}



// MARK: - MKMapViewDelegate Conformance
extension DetailViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is VPLocation else { return nil }
        let identifier = "VPLocation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.isDraggable = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            let btn2 = UIButton(type: .close)
            annotationView?.leftCalloutAccessoryView = btn2
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        
        if let annotation = view.annotation {
            location.coordinate = annotation.coordinate
            latitude.text = String(format: "%f",location.coordinate.latitude)
            longitude.text = String(format: "%f", location.coordinate.longitude)
        }
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.leftCalloutAccessoryView {
            mapView.removeAnnotation(view.annotation!)
            return
        }
        
        
        guard let vplocation = view.annotation as? VPLocation else { return }
        let placeName = String(format: "%f", vplocation.coordinate.latitude)
        let placeInfo = String(format: "%f", vplocation.coordinate.longitude)
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
