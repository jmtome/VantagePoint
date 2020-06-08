//
//  ViewController.swift
//  VantagePoint
//
//  Created by Juan Manuel Tome on 04/06/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit



class ViewController: UIViewController {
    
    var places = [VantagePoint]()
    let dummyElement: VantagePoint = {
        let coordinate = CLLocationCoordinate2D(latitude: 55.507222, longitude: -0.1275)
        let location = VPLocation(title: "MYPlace", coordinate: coordinate, info: "no info")
    
        let el = VantagePoint(placeName: "place0", location: location, placeImage: UIImage(systemName: "cloud"))
        return el
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorColor = UIColor.blue
        return tv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addVP))
        setupTableView()
        //let indexPath = IndexPath(row: 0, section: 0)
        //places.insert(dummyElement, at: 0)
        //tableView.insertRows(at: [indexPath], with: .left)
    }
    
    
    @objc func addVP() {
    
        let vc = storyboard?.instantiateViewController(identifier: "myModalView") as! DetailViewController
        vc.delegate = self
        vc.modalPresentationStyle = .pageSheet
        present(vc, animated: true, completion: nil)
        
        
        
    }
    
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MapViewCell.self, forCellReuseIdentifier: "cellId")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
    
    
    
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! MapViewCell
        let newPlace = places[indexPath.row]
        cell.place = newPlace
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "myModalView") as! DetailViewController
        vc.delegate = self
        vc.isButtonHidden = true
        vc.newPlace = places[indexPath.row]
        vc.passedIndexPath = indexPath
        navigationController?.pushViewController(vc, animated: true)
//        vc.modalPresentationStyle = .pageSheet
//        present(vc, animated: true, completion: nil)
        
        
    }
    
}


extension ViewController: DetailViewControllerDelegate {
    func detailViewController(_ vc: DetailViewController, didAddNewData data: VantagePoint) {
        places.append(data)
        print(places[0])
        tableView.reloadData()
    }
    
    func detailViewController(_ vc: DetailViewController, didUpdateDataWith data: VantagePoint, indexPath: IndexPath) {
        print(places[indexPath.row])
        places[indexPath.row] = data
        print("after")
        print(places[indexPath.row])
        tableView.reloadData()
    }
    
}
