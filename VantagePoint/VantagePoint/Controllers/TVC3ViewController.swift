//
//  TVC3ViewController.swift
//  VantagePoint
//
//  Created by Juan Manuel Tome on 15/06/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//


import UIKit

class TVC3ViewController: UIViewController {

    let collectionView: UICollectionView = {
        let frame = CGRect(x: 0, y: 50, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 50)
        let col = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        col.layer.borderColor = UIColor.red.cgColor
        col.layer.borderWidth = 1.0
        col.backgroundColor = UIColor.yellow
        return col
    }()

    let switchView = UISwitch()

    @objc func switched(s: UISwitch){
        let origin: CGFloat = s.isOn ? view.frame.height : 50
        UIView.animate(withDuration: 0.35) {
            self.collectionView.frame.origin.y = origin
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        switchView.frame = CGRect(x: 0, y: 20, width: 40, height: 20)
        switchView.addTarget(self, action: #selector(switched), for: .valueChanged)

        view.addSubview(switchView)
        view.addSubview(collectionView)

    }

}
