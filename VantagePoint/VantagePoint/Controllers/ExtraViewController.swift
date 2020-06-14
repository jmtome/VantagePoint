

//
//  ExtraViewController.swift
//  VantagePoint
//
//  Created by Juan Manuel Tome on 13/06/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Contacts

let screenWidth  = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

class ExtraViewController: UIViewController {

    let mapView: MKMapView = {
        let view = MKMapView(frame: .zero)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
        //view.heightAnchor.constraint(equalToConstant: screenHeight / 2).isActive = true

        return view
    }()

    private let mapViewContainer: UIView = {
        let view = UIView(frame: .zero)
        //view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight/2)
        view.backgroundColor = UIColor.systemGray
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false

        view.widthAnchor.constraint(equalToConstant: screenWidth, withIdentifier: "widthAnchor").isActive = true

        return view
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = #imageLiteral(resourceName: "London").roundedImage
        image.contentMode = .scaleAspectFit
        image.widthAnchor.constraint(equalToConstant: screenHeight / 3, withIdentifier: "imageWidth").isActive = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private let closeButton: UIButton = {
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: .zero, size: smallSquare))
        button.setBackgroundImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 35).isActive = true
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
        button.isUserInteractionEnabled = true
        return button
        
    }()

    
    
    var toggleHeight: Bool = false
    
    var locations: [VPLocation] = [
        VPLocation(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Capital of england"),
        VPLocation(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Capital of Norway"),
        VPLocation(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Capital of France"),
        VPLocation(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Capital of Italy"),
        VPLocation(title: "Washington-DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Capital of USA"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let address = [CNPostalAddressStreetKey: "181 Piccadilly, St. James's", CNPostalAddressCityKey: "London", CNPostalAddressPostalCodeKey: "W1A 1ER", CNPostalAddressISOCountryCodeKey: "GB"]
        let place = MKPlacemark(coordinate: locations[0].coordinate, addressDictionary: address)
        mapView.addAnnotation(place)
        view.addSubview(imageView)
        view.addSubview(mapViewContainer)
        mapViewContainer.addSubview(mapView)
//
        
        mapView.topAnchor.constraint(equalTo: mapViewContainer.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: mapViewContainer.bottomAnchor).isActive = true
        mapView.leftAnchor.constraint(equalTo: mapViewContainer.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: mapViewContainer.rightAnchor).isActive = true
        
        mapViewContainer.addSubview(closeButton)
        closeButton.topAnchor.constraint(equalTo: mapViewContainer.topAnchor, constant: 25, withIdentifier: "closeBtnTop").isActive = true
        closeButton.leftAnchor.constraint(equalTo: mapViewContainer.leftAnchor, constant: 20, withIdentifier: "closeBtnLeft").isActive = true
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        closeButton.isHidden = true 
        
        mapView.bottomAnchor.constraint(equalTo: mapViewContainer.bottomAnchor, constant: 0, withIdentifier: "mvBottom").isActive = true
        mapView.topAnchor.constraint(equalTo: mapViewContainer.topAnchor, constant: 0, withIdentifier: "mvTop").isActive = true
        
        imageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10, withIdentifier: "leftAnchor").isActive = true
        imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50, withIdentifier: "ivTopAnchor").isActive = true
        
        mapViewContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 10).isActive = true
        
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(enlargeView))
        mapViewContainer.addGestureRecognizer(touchGesture)

        
        let touchGesture2 = UITapGestureRecognizer(target: self, action: #selector(enlargeView2))
        imageView.addGestureRecognizer(touchGesture2)
        
        
        mapViewContainer.heightAnchor.constraint(equalToConstant: (screenHeight - 30) / 2, withIdentifier: "heightAnchor").isActive = true
      
        
    }

    
    @objc func close(_ sender: UIButton) {
        print("print outside if: \(toggleHeight)")
        if toggleHeight {
            print(toggleHeight)
            
            toggleHeight.toggle()
            
            let c = mapViewContainer.constraint(withIdentifier: "heightAnchor")
            c?.isActive = false
            
            mapViewContainer.heightAnchor.constraint(equalToConstant: screenHeight/2, withIdentifier: "heightAnchor").isActive = true
            
             
            mapViewContainer.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.5) {
                self.closeButton.isHidden = true
                super.view.layoutIfNeeded()
                
            }
            
        }
        print("touched button")
        print(closeButton.isUserInteractionEnabled)
        print(mapViewContainer.isUserInteractionEnabled)
    }
    
    @objc func enlargeView2(_ sender: UITapGestureRecognizer) {

        let vc = ImageDetailViewController()
        vc.view.backgroundColor = .white
        //let navCon = UINavigationController(rootViewController: self)
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
        
        
        //if sender.state == .ended {
//            toggleHeight.toggle()
//
//            let c = imageView.constraint(withIdentifier: "imageWidth")
//            c?.isActive = false
//
//            imageView.widthAnchor.constraint(equalToConstant: toggleHeight ? screenHeight / 4 : screenHeight / 3, withIdentifier: "imageWidth").isActive = true
//            //mapViewContainer.isUserInteractionEnabled = true
//            UIView.animate(withDuration: 0.5) {
//                super.view.layoutIfNeeded()
//            }
//
//            UIViewPropertyAnimator(duration: 1.5, dampingRatio: 0.1) {
//                super.view.layoutIfNeeded()
//            }.startAnimation()
        // }
        
    }
    @objc func enlargeView(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            
            if !toggleHeight {
                toggleHeight.toggle()
                
            }
            //toggleHeight.toggle()
            //mapViewContainer.isUserInteractionEnabled = false
            //mapViewContainer.constraint(withIdentifier: "topAnchor")?.isActive = false
            let c = mapViewContainer.constraint(withIdentifier: "heightAnchor")
            
            c?.isActive = false
            mapViewContainer.heightAnchor.constraint(equalToConstant:screenHeight - 30, withIdentifier: "heightAnchor").isActive = true
            
            
//            UIViewPropertyAnimator(duration: 1.5, dampingRatio: 0.5) {
//                super.view.layoutIfNeeded()
//            }.startAnimation()
            UIView.animate(withDuration: 0.5) {
                self.closeButton.isHidden = false
                super.view.layoutIfNeeded()
            }
        }
        print("touched map")
        print(closeButton.isUserInteractionEnabled)
        print(mapViewContainer.isUserInteractionEnabled)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
