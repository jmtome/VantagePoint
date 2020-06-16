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
        view.backgroundColor = UIColor.black
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
        separatorView.addGestureRecognizer(panGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addViews() {

        //view.addSubview(topContainerView)
        //view.addSubview(bottomContainerView)
        view.addSubview(separatorView)

        separatorView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        separatorView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        self.centerConstraint = separatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        self.centerConstraint.isActive = true

        separatorView.heightAnchor.constraint(equalToConstant: 50).isActive = true

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
            self.centerConstraint.constant = self.startingConstant + translation.y
        default:
            break
        }
    }
    
    private let slidingView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
        view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.5).isActive = true
        view.layer.cornerRadius = 20

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
