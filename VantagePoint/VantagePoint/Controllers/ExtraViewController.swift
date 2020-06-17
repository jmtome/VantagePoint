

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

//let screenWidth = UIScreen.main.nativeBounds.width
//let screenHeight = UIScreen.main.nativeBounds.height

class ExtraViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
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
    
    private let nameTextField: UITextField = {
        //let sampleTextField =  UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        let sampleTextField = UITextField(frame: .zero)
        sampleTextField.placeholder = "Enter text here"
//        sampleTextField.font = UIFont.systemFont(ofSize: 15)
        sampleTextField.font = UIFont.systemFont(ofSize: 40, weight: .light)
        sampleTextField.borderStyle = UITextField.BorderStyle.none
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.done
        sampleTextField.textAlignment = .center
        //sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        sampleTextField.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        sampleTextField.text = "London"
        sampleTextField.translatesAutoresizingMaskIntoConstraints = false
        return sampleTextField
    }()
    
    private let infoTextField: UITextView = {
            let infoTextField = UITextView(frame: .zero)
            //infoTextField.placeholder = "Info"
    //        infoTextField.font = UIFont.systemFont(ofSize: 15)
            infoTextField.font = UIFont.systemFont(ofSize: 40, weight: .light)
            //infoTextField.borderStyle = UITextField.BorderStyle.none
            infoTextField.autocorrectionType = UITextAutocorrectionType.no
            infoTextField.keyboardType = UIKeyboardType.default
            infoTextField.returnKeyType = UIReturnKeyType.done
            infoTextField.textAlignment = .left
            //infoTextField.clearButtonMode = UITextField.ViewMode.whileEditing
            //infoTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            //infoTextField.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
            infoTextField.text = "Info"
            infoTextField.translatesAutoresizingMaskIntoConstraints = false
            return infoTextField
        }()
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    var toggleHeight: Bool = false
    
    var locations: [VPLocation] = [
        VPLocation(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Capital of england"),
        VPLocation(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Capital of Norway"),
        VPLocation(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Capital of France"),
        VPLocation(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Capital of Italy"),
        VPLocation(title: "Washington-DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Capital of USA"),
    ]
    
    
    @objc private func endEditing(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            nameTextField.resignFirstResponder()
        }
    }
    
    fileprivate func setupInfoView() {
        view.addSubview(infoView)
        infoView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        infoView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10).isActive = true
        infoView.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        infoView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        infoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapper = UITapGestureRecognizer(target: self, action:#selector(endEditing))
        tapper.cancelsTouchesInView = false
        view.addGestureRecognizer(tapper)
        
        let address = [CNPostalAddressStreetKey: "181 Piccadilly, St. James's", CNPostalAddressCityKey: "London", CNPostalAddressPostalCodeKey: "W1A 1ER", CNPostalAddressISOCountryCodeKey: "GB"]
        let place = MKPlacemark(coordinate: locations[0].coordinate, addressDictionary: address)
        mapView.addAnnotation(place)
        view.addSubview(imageView)
        view.addSubview(mapViewContainer)
        view.addSubview(weatherView)
    
        nameTextField.delegate = self
        
        navigationItem.titleView = nameTextField
        setupWeatherView()
        
        setupInfoView()
        
        mapViewContainer.addSubview(mapView)
        
        
        let mvTop = mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        mvTop.isActive = true
        //mapView.topAnchor.constraint(equalTo: mapViewContainer.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: mapViewContainer.bottomAnchor).isActive = true
        mapView.leftAnchor.constraint(equalTo: mapViewContainer.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: mapViewContainer.rightAnchor).isActive = true
        
        addDrawerToMap()
        
        mapViewContainer.addSubview(closeButton)
        mapViewContainer.clipsToBounds = true
        closeButton.topAnchor.constraint(equalTo: mapViewContainer.topAnchor, constant: 25, withIdentifier: "closeBtnTop").isActive = true
        closeButton.leftAnchor.constraint(equalTo: mapViewContainer.leftAnchor, constant: 20, withIdentifier: "closeBtnLeft").isActive = true
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        closeButton.isHidden = true 
        
        
        imageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10, withIdentifier: "leftAnchor").isActive = true
        //imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50, withIdentifier: "ivTopAnchor").isActive = true
        imageView.widthAnchor.constraint(equalToConstant: screenWidth / 1.5).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1 / aMultiplier).isActive = true
        imageView.bottomAnchor.constraint(equalTo: weatherView.topAnchor, constant: -10).isActive = true
        mapViewContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 10).isActive = true
        
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(enlargeView))
        mapViewContainer.addGestureRecognizer(touchGesture)
        
        
        let touchGesture2 = UITapGestureRecognizer(target: self, action: #selector(goToImageVc))
        imageView.addGestureRecognizer(touchGesture2)
        
        
        //apViewContainer.heightAnchor.constraint(equalToConstant: (screenHeight - 30) / 2, withIdentifier: "heightAnchor").isActive = true
        
        var multiplier: CGFloat = 2
        
        if UIDevice().userInterfaceIdiom == .pad {
            multiplier = 2.5
        }
        
        self.centerConstraint = mapViewContainer.heightAnchor.constraint(equalToConstant: (screenHeight - 30) / multiplier)
        self.centerConstraint.isActive = true
        
        
    }
    var heightWeatherConstraint: NSLayoutConstraint!
    var bottomWeatherConstraint: NSLayoutConstraint!
    var topWeatherConstraint: NSLayoutConstraint!
    fileprivate func setupWeatherView() {
        
        
        weatherView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        weatherView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
        topWeatherConstraint = weatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        print(screenHeight)
        print(UIScreen.main.nativeBounds.height/screenHeight)
        
        var multiplier: CGFloat = 1
        if screenHeight < 850 || UIDevice().userInterfaceIdiom == .pad {
            multiplier = 0.6
        }
        
        heightWeatherConstraint = weatherView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: multiplier)
        bottomWeatherConstraint = weatherView.bottomAnchor.constraint(equalTo: mapViewContainer.topAnchor, constant: -10)
        heightWeatherConstraint.isActive = true
        bottomWeatherConstraint.isActive = true
        
        let gst = UITapGestureRecognizer(target: self, action: #selector(openWeather))
        weatherView.addGestureRecognizer(gst)
        weatherView.isUserInteractionEnabled = true
        
        //infoTextField.backgroundColor = .red
        //weatherView.addSubview(infoTextField)
        //weatherView.bringSubviewToFront(infoTextField)
        //infoTextField.delegate = self
        //infoTextField.isScrollEnabled = false
//        infoTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        infoTextField.heightAnchor.constraint(equalToConstant: 100).isActive = true
        //infoTextField.topAnchor.constraint(equalTo: weatherView.topAnchor).isActive = true
        //infoTextField.centerXAnchor.constraint(equalTo: weatherView.centerXAnchor).isActive = true
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
                bottomWeatherConstraint = weatherView.bottomAnchor.constraint(equalTo: mapViewContainer.topAnchor, constant: -10)
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
        mapViewContainer.addSubview(drawerZone)
        drawerZone.topAnchor.constraint(equalTo: mapViewContainer.topAnchor, constant: 0).isActive = true
        drawerZone.centerXAnchor.constraint(equalTo: mapViewContainer.centerXAnchor).isActive = true
        drawerBar.centerXAnchor.constraint(equalTo: drawerZone.centerXAnchor).isActive = true
        drawerBar.centerYAnchor.constraint(equalTo: drawerZone.centerYAnchor).isActive = true
        //mapViewContainer.bringSubviewToFront(drawerZone)

    }
    
    @objc func close(_ sender: UIButton) {
        print("print outside if: \(toggleHeight)")
        if toggleHeight {
            print(toggleHeight)
            
            toggleHeight.toggle()
            
            var multiplier: CGFloat = 2
            
            if UIDevice().userInterfaceIdiom == .pad {
                multiplier = 2.5
            }
            self.centerConstraint.constant = (screenHeight - 30) / multiplier
            
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
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
    
    @objc func goToImageVc(_ sender: UITapGestureRecognizer) {
        let vc2 = GesturesViewController()
        let vc = ImageDetailViewController()
        vc.navigationItem.titleView = self.navigationItem.titleView
        vc.view.backgroundColor = .white
        
        navigationController?.pushViewController(vc, animated: true)
        
        
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
    
    //TODO: - IDEA: maybe i can remove map constraints from mapviewcontainer when i do this dragging shit
    @objc func detectPan(recognizer: UIPanGestureRecognizer) {
        var shouldAnimate = false
        var multiplier: CGFloat = 2
        
        if UIDevice().userInterfaceIdiom == .pad {
            multiplier = 2.5
        }
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
                if (centerConstraint.constant < screenHeight) || (centerConstraint.constant > screenHeight / multiplier) {
                    shouldAnimate = true
                    if recognizer.velocity(in: self.view).y < 0 {
                        centerConstraint.constant = (screenHeight - 100)
                        
                    } else {
                        centerConstraint.constant = (screenHeight - 30) / multiplier
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
