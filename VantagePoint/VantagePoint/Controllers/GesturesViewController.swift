//
//  GesturesViewController.swift
//  VantagePoint
//
//  Created by Juan Manuel Tome on 15/06/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit

class GesturesViewController: UIViewController, UIGestureRecognizerDelegate {

    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let topContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.orange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let bottomContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var centerConstraint: NSLayoutConstraint!

    var startingConstant: CGFloat  = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addViews()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(detectPan(recognizer:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        //slidingView.addGestureRecognizer(panGesture)
        drawerZone.addGestureRecognizer(panGesture)
        drawerZone.addSubview(drawerArrowUp)
        drawerZone.addSubview(drawerArrowDown)
        slidingView.addSubview(drawerZone)
        drawerZone.topAnchor.constraint(equalTo: slidingView.topAnchor, constant: 0).isActive = true
        drawerZone.centerXAnchor.constraint(equalTo: slidingView.centerXAnchor).isActive = true
        drawerArrowUp.centerXAnchor.constraint(equalTo: drawerZone.centerXAnchor, constant: -7).isActive = true
        drawerArrowUp.centerYAnchor.constraint(equalTo: drawerZone.centerYAnchor).isActive = true
        drawerArrowDown.centerXAnchor.constraint(equalTo: drawerZone.centerXAnchor, constant: 7).isActive = true
        drawerArrowDown.centerYAnchor.constraint(equalTo: drawerZone.centerYAnchor).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addViews() {

        //view.addSubview(topContainerView)
        //view.addSubview(bottomContainerView)
        view.addSubview(slidingView)

        //slidingView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        //slidingView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        
        //self.centerConstraint = separatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        //self.centerConstraint.isActive = true
        
        
        
        self.centerConstraint = slidingView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.5)
        centerConstraint.isActive = true
        slidingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        topContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        topContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        topContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        topContainerView.bottomAnchor.constraint(equalTo: separatorView.topAnchor).isActive = true
//
//        bottomContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        bottomContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        bottomContainerView.topAnchor.constraint(equalTo: separatorView.bottomAnchor).isActive = true
//        bottomContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    @objc func detectPan(recognizer: UIPanGestureRecognizer) {

        switch recognizer.state {
        case .began:
            self.startingConstant = self.centerConstraint.constant
        case .changed:
            let translation = recognizer.translation(in: self.view)
            self.centerConstraint.constant = self.startingConstant - translation.y
            
            
            if self.centerConstraint.constant > self.startingConstant {
                UIView.animate(withDuration: 0.5) { [weak self] in
                    self?.drawerArrowUp.transform = CGAffineTransform(rotationAngle: -.pi/10)
                    self?.drawerArrowDown.transform = CGAffineTransform(rotationAngle: .pi/10)
                }
            } else {
                UIView.animate(withDuration: 0.5) { [weak self] in
                    self?.drawerArrowUp.transform = CGAffineTransform(rotationAngle: .pi/10)
                    self?.drawerArrowDown.transform = CGAffineTransform(rotationAngle: -.pi/10)
                }
            }
        case .ended:
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.drawerArrowUp.transform = CGAffineTransform(rotationAngle: 0)
                self?.drawerArrowDown.transform = CGAffineTransform(rotationAngle: 0)
            }
        default:
            break
        }
        print(centerConstraint.constant)
    }
    
    private let drawerZone: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = .systemRed
        view.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
        view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1 / 20, constant: 10).isActive = true
        return view
    }()
    private let drawerBar: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 40).isActive = true
        view.heightAnchor.constraint(equalToConstant: 5).isActive = true
        view.transform = CGAffineTransform(rotationAngle: 0)//-pi/6

        return view
    }()
    private let drawerArrowUp: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 20).isActive = true
        view.heightAnchor.constraint(equalToConstant: 5).isActive = true
        view.transform = CGAffineTransform(rotationAngle: 0)// pi/6
        return view
    }()
    private let drawerArrowDown: UIView = {
           let view = UIView(frame: .zero)
           view.backgroundColor = .darkGray
           view.layer.cornerRadius = 3
           view.translatesAutoresizingMaskIntoConstraints = false
           view.widthAnchor.constraint(equalToConstant: 20).isActive = true
           view.heightAnchor.constraint(equalToConstant: 5).isActive = true
           view.transform = CGAffineTransform(rotationAngle: 0)
           return view
       }()
    
    private let slidingView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .lightGray
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -5)
        view.layer.shadowOpacity = 0.9
        view.layer.shadowRadius = 1.0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
        //view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.5).isActive = true
        view.layer.cornerRadius = 40

        return view
    }()

    var initialTouchLocation: CGPoint?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.addSubview(slidingView)
//
//        slidingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//
//        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleScreenEdgePan))
//        slidingView.addGestureRecognizer(gesture)
//        gesture.delegate = self
//
//        // Do any additional setup after loading the view.
//    }
//
//
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        initialTouchLocation = touches.first!.location(in: view)
//    }

}
