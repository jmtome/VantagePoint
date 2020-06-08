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

protocol DetailViewControllerDelegate: class {
    func detailViewController(_ vc: DetailViewController, didAddNewData data: VantagePoint)
    func detailViewController(_ vc: DetailViewController, didUpdateDataWith data: VantagePoint, indexPath: IndexPath)
}

//func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

class DetailViewController: UIViewController, UITextFieldDelegate, MKMapViewDelegate {

    @IBOutlet weak var rightButton: UIButton!
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
    
    var editWasToggled = false
    var isButtonHidden = false
    weak var delegate: DetailViewControllerDelegate?
    
    var location = VPLocation(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "capital of england")

    var newPlace: VantagePoint?
    var passedIndexPath: IndexPath?
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            if editWasToggled {
                newPlace = VantagePoint(placeName: placeTextField.text, location: location, placeImage: vpImage.image)
                self.delegate?.detailViewController(self, didUpdateDataWith: newPlace!, indexPath: passedIndexPath!)
            }
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        if let place = newPlace {
//            vpImage.image = place.placeImage
//            latitude.text = String(format: "%.2f", place.location.coordinate.latitude)
//            longitude.text = String(format: "%.2f", place.location.coordinate.longitude)
//            placeTextField.text = place.placeName
//            print(latitude.text)
//            print(longitude.text)
//            location = place.location
//
//        } else {
//            //newplace wasnt passed and this is a new view
//            latitude.text = String(format: "%.2f", location.coordinate.latitude)
//            longitude.text = String(format: "%.2f", location.coordinate.longitude)
//            if let location = newPlace?.location {
//                self.location = location
//            }
//        }
//
//
//    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let place = newPlace {
            vpImage.image = place.placeImage
            latitude.text = String(format: "%.2f", place.location.coordinate.latitude)
            longitude.text = String(format: "%.2f", place.location.coordinate.longitude)
            placeTextField.text = place.placeName
            print(latitude.text)
            print(longitude.text)
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

        //vpImage.roundCornersForAspectFit(radius: 20)

        
        placeTextField.delegate = self
        rightButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        mapView.delegate = self
        let center: CLLocationCoordinate2D = location.coordinate
        
        //let center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)
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
        //var vcPlace = VPLocation(title: placeTextField.text!, coordinate: T##CLLocationCoordinate2D, info: T##String)
    }
    
    // En el estado que esta, me esta transfiriendo los datos de adonde se encuentra el drop pin,
    // cree un VPLocation londres, el cual uso para crear el VantagePoint cuando apreto el add, y las coordenadas
    // inicialmente son london, pero luego, si hago dragpin, se mueven ahi, y use el metodo delegado de mapview
    // para que le cambie las coordenadas a london y luego cuando apreto ADD, crea un nuevo VantagePoint
    // para el cual utiliza london de VPLocation, y lo envia, y por ende lo envia con las coordeandas de mapa, pero no
    // las coordeandas ingresadas por el usuario
    // luego muestro esas coordeandas y ese nombre en el tableview del comienzo.
    //
    
    
    
    
    // A method called when long press is detected.
    @objc private func recognizeLongPress(_ sender: UILongPressGestureRecognizer) {
        // Do not generate pins many times during long press.
        if sender.state != UIGestureRecognizer.State.began {
            return
            
        }
        
        // Get the coordinates of the point you pressed long.
        let location = sender.location(in: mapView)
        
        // Convert location to CLLocationCoordinate2D.
        let myCoordinate: CLLocationCoordinate2D = mapView.convert(location, toCoordinateFrom: mapView)
        
        // Generate pins.
        let myPin: VPLocation = VPLocation(title: "dropped", coordinate: myCoordinate, info: "some dropped info")
        
        // Set the coordinates.
        //myPin.coordinate = myCoordinate
        
        // Set the title.
        //myPin.title = "title"
        
        // Set subtitle.
        //myPin.subtitle = "subtitle"
        
        // Added pins to MapView.
        mapView.addAnnotation(myPin)
    }
    @objc func save() {
        //let doubleLat = Double(latitude.text!) ?? 10
        //let doubleLong = Double(longitude.text!) ?? 10
        
        //let location = VPLocation(title: placeTextField.text!, coordinate: CLLocationCoordinate2D(latitude: doubleLat, longitude: doubleLong), info: "someplace")
        
        
        let newPoint = VantagePoint(placeName: placeTextField.text, location: location, placeImage: vpImage.image)
        
        
        
        self.dismiss(animated: true, completion:{
            self.delegate?.detailViewController(self, didAddNewData: newPoint)
        
        })
        
        
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
    
    
    @objc func addVP() {
        print("pepe")
    }

    
    
    
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
        
        print("moved thingy")
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
    
    
    @IBAction func addPhoto(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
        
    }
    
}

extension DetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }

//        let imageName = UUID().uuidString
//        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
//
//        if let jpegData = image.jpegData(compressionQuality: 0.8) {
//            try? jpegData.write(to: imagePath)
//        }


        vpImage.image = image
//        newPlace = VantagePoint(placeName: "unknown", location: london, placeImage: image)

        
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
}
extension UITextField {
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()

        self.inputAccessoryView = toolbar
    }

    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
}
