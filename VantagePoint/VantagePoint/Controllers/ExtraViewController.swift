

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
        return view
    }()
    private let mapViewContainer: UIView = {
        let view = UIView(frame: .zero)
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
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        return image
    }()
    
    lazy var aMultiplier: CGFloat = {
        return (imageView.image?.size.width)! / (imageView.image?.size.height)!
    }()
    
    private let infoView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        return view
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
    
    private let weatherView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let drawerZone: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
        view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1 / 20, constant: 10).isActive = true
        return view
    }()
    private let drawerBar: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 30).isActive = true
        view.heightAnchor.constraint(equalToConstant: 5).isActive = true
        return view
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
        view.addSubview(infoView)
        view.addSubview(weatherView)
        
        addDrawerToMap()
        
        setupWeatherView()
        
        infoView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        
        infoView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10).isActive = true
        infoView.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        infoView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        
        
        infoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
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
        //imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50, withIdentifier: "ivTopAnchor").isActive = true
        imageView.widthAnchor.constraint(equalToConstant: screenWidth / 1.5).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1 / aMultiplier).isActive = true
        imageView.bottomAnchor.constraint(equalTo: mapViewContainer.topAnchor, constant: -10).isActive = true
        mapViewContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 10).isActive = true
        
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(enlargeView))
        mapViewContainer.addGestureRecognizer(touchGesture)
        
        
        let touchGesture2 = UITapGestureRecognizer(target: self, action: #selector(goToImageVc))
        imageView.addGestureRecognizer(touchGesture2)
        
        
        //apViewContainer.heightAnchor.constraint(equalToConstant: (screenHeight - 30) / 2, withIdentifier: "heightAnchor").isActive = true
        
        self.centerConstraint = mapViewContainer.heightAnchor.constraint(equalToConstant: (screenHeight - 30) / 2)
        self.centerConstraint.isActive = true
        
        
    }
    var heightWeatherConstraint: NSLayoutConstraint!
    var bottomWeatherConstraint: NSLayoutConstraint!
    var topWeatherConstraint: NSLayoutConstraint!
    fileprivate func setupWeatherView() {
        
        
        weatherView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        weatherView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
        topWeatherConstraint = weatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        heightWeatherConstraint = weatherView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.5)
        bottomWeatherConstraint = weatherView.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -10)
        heightWeatherConstraint.isActive = true
        bottomWeatherConstraint.isActive = true
        
        let gst = UITapGestureRecognizer(target: self, action: #selector(openWeather))
        weatherView.addGestureRecognizer(gst)
        weatherView.isUserInteractionEnabled = true
    }
    
    var isShowingWeatherView: Bool = false
    
    @objc func openWeather(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            
            NSLayoutConstraint.deactivate([
                self.heightWeatherConstraint,
                self.bottomWeatherConstraint,
                self.topWeatherConstraint
            ])
            
//            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
//            let blurEffectView = UIVisualEffectView(effect: blurEffect)
//            blurEffectView.frame = weatherView.bounds
//            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            weatherView.addSubview(blurEffectView)
            if !isShowingWeatherView {
                

                weatherView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).withAlphaComponent(0.7)
                self.bottomWeatherConstraint = self.weatherView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 30)

                self.topWeatherConstraint = weatherView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10)

                self.topWeatherConstraint.isActive = true
            } else {
                //blurEffectView.removeFromSuperview()
                bottomWeatherConstraint = weatherView.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -10)
                weatherView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).withAlphaComponent(0.7)
                self.heightWeatherConstraint.isActive = true
            }
            NSLayoutConstraint.activate([self.bottomWeatherConstraint])
            
            isShowingWeatherView.toggle()
            
            UIView.animate(withDuration: 0.6) {
                
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func addDrawerToMap() {
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(detectPan(recognizer:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        //slidingView.addGestureRecognizer(panGesture)
        drawerZone.addGestureRecognizer(panGesture)
        drawerZone.addSubview(drawerBar)
        mapView.addSubview(drawerZone)
        drawerZone.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 0).isActive = true
        drawerZone.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
        drawerBar.centerXAnchor.constraint(equalTo: drawerZone.centerXAnchor).isActive = true
        drawerBar.centerYAnchor.constraint(equalTo: drawerZone.centerYAnchor).isActive = true
    }
    
    @objc func close(_ sender: UIButton) {
        print("print outside if: \(toggleHeight)")
        if toggleHeight {
            print(toggleHeight)
            
            toggleHeight.toggle()
            
            
            self.centerConstraint.constant = (screenHeight - 30) / 2
            
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
    
    @objc func goToImageVc(_ sender: UITapGestureRecognizer) {
        let vc2 = GesturesViewController()
        let vc = ImageDetailViewController()
        vc2.view.backgroundColor = .white
        
        navigationController?.pushViewController(vc2, animated: true)
        
        
    }
    @objc func enlargeView(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            
            if !toggleHeight {
                toggleHeight.toggle()
                
            }
            
            
            self.centerConstraint.constant = screenHeight - 100
            
            
            UIView.animate(withDuration: 0.5) {
                self.closeButton.isHidden = false
                super.view.layoutIfNeeded()
            }
        }
        print("touched map")
        print(closeButton.isUserInteractionEnabled)
        print(mapViewContainer.isUserInteractionEnabled)
    }
    
    var centerConstraint: NSLayoutConstraint!
    var startingConstant: CGFloat  = 0.0
    
    @objc func detectPan(recognizer: UIPanGestureRecognizer) {
        var shouldAnimate = false
        
        switch recognizer.state {
        case .began:
            self.startingConstant = self.centerConstraint.constant
        case .changed:
            let translation = recognizer.translation(in: self.view)
            self.centerConstraint.constant = self.startingConstant - translation.y
            print("speed : \(recognizer.velocity(in: self.view).y)")
        case .ended:
            
            let canMove = abs(self.centerConstraint.constant - self.startingConstant) > 50
            
            if  canMove {
                if (centerConstraint.constant < screenHeight) || (centerConstraint.constant > screenHeight / 2) {
                    shouldAnimate = true
                    if recognizer.velocity(in: self.view).y < 0 {
                        centerConstraint.constant = (screenHeight - 100)
                        
                    } else {
                        centerConstraint.constant = (screenHeight - 30) / 2
                    }
                } else {
                    centerConstraint.constant = startingConstant
                }
            } else {
                centerConstraint.constant = startingConstant
            }
            
        default:
            break
        }
        
        if shouldAnimate {
            UIView.animate(withDuration: 0.6) {
                
                shouldAnimate = false
                self.view.layoutIfNeeded()
            }
        }
       
        print("starting \(startingConstant)")
        print("center \(centerConstraint.constant)")
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
}
