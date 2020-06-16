//
//  Test2ViewController.swift
//  VantagePoint
//
//  Created by Juan Manuel Tome on 15/06/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit

class Test2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addArrangedSubview(redView)
        scrollViewContainer.addArrangedSubview(blueView)
        scrollViewContainer.addArrangedSubview(greenView)

        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        // this is important for scrolling
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let scrollViewContainer: UIStackView = {
        let view = UIStackView()

        view.axis = .vertical
        view.spacing = 10

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let redView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 500).isActive = true
        view.backgroundColor = .red
        return view
    }()

    let blueView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        view.backgroundColor = .blue
        return view
    }()

    let greenView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 1200).isActive = true
        view.backgroundColor = .green
        return view
    }()
}
