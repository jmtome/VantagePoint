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



class RootViewController: UIViewController {
    
    // MARK: - Properties
    var places = [VantagePoint]()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorColor = UIColor.blue
        return tv
    }()

    // MARK: - View Cycle Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBarSetup()
        setupTableView()
        //addDummyCells()
    }
        

    
    
    // MARK: - Private Methods
    private func navBarSetup() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addVP))
        navigationItem.rightBarButtonItem?.tintColor = .blue
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "My Places."
    }
    private func addDummyCells() {
        
        let dummyElement: VantagePoint = {
            let coordinate = CLLocationCoordinate2D(latitude: 55.507222, longitude: -0.1275)
            let location = VPLocation(title: "MYPlace", coordinate: coordinate, info: "no info")
        
            let el = VantagePoint(placeName: "place0", location: location, placeImage: UIImage(systemName: "cloud"))
            return el
        }()
        
        places.insert(dummyElement, at: 0)
        let indexPath = IndexPath(item: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .left)

    }
    @objc private func addVP() {
    
        let vc = storyboard?.instantiateViewController(identifier: "myModalView") as! DetailViewController
        vc.delegate = self
        vc.modalPresentationStyle = .pageSheet
        present(vc, animated: true, completion: nil)
    }
    
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MapViewCell.self, forCellReuseIdentifier: MapViewCell.reuseIdentifier)
        view.addSubview(tableView)
        
        tableView.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
}


// MARK: - UITableViewDelegate & UITableViewDataSource Conformance

extension RootViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MapViewCell.reuseIdentifier, for: indexPath) as! MapViewCell
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
        navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - DetailViewControllerDelegate Conformance

extension RootViewController: DetailViewControllerDelegate {
    func detailViewController(_ vc: DetailViewController, didAddNewData data: VantagePoint) {
        places.append(data)
        print(places[0])
        tableView.reloadData()
    }
    
    func detailViewController(_ vc: DetailViewController, didUpdateDataWith data: VantagePoint) {
        let vpUUID = data.uuid
        let vpIndex = places.firstIndex { place in
            place.uuid == vpUUID
        }
        places[vpIndex! as Int] = data
        tableView.reloadData()
    }
}
