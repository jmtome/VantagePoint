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


// TODO: - Check what happens when I edit/delete/add places while in favorites mode
// Initially i disabled adding while in favorites, also disabled moving and deleting
// I also disabled didselectrowat, so no editing while in favorites mode

//TODO: - Begin the design of new UI, UISearchBar with Mapkit to pre-position the user, 

class RootViewController: UIViewController {
    
    // MARK: - Properties
    var places: [VantagePoint] = [VantagePoint]()
    var favorites: [VantagePoint] = [VantagePoint]()
    
    var isShowingFavorites: Bool = false
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorColor = UIColor.red
        return tv
    }()
    
    // MARK: - View Cycle Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBarSetup()
        setupTableView()
        //addDummyCells()
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        
        tableView.isEditing = editing
  
    }

    override func viewWillAppear(_ animated: Bool) {
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: false)
        }
    }
    
    
    // MARK: - Private Methods
    private func navBarSetup() {
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease.circle"), style: .plain, target: self, action: #selector(showFavorites(_:)))
       
        navigationItem.leftBarButtonItems = [editButtonItem, filterButton]

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addVP))
        navigationItem.rightBarButtonItem?.tintColor = .blue
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "My Places."
    }
    @objc private func showFavorites(_ sender: UIBarButtonItem) {
    
        print(isShowingFavorites)
        //ideally I wouldn't have to do this, but i have found no way to just change the image
        var filtered: UIBarButtonItem
        if !isShowingFavorites {
            filtered = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease.circle.fill"), style: .plain, target: self, action: #selector(showFavorites(_:)))
            isShowingFavorites.toggle()
            navigationItem.rightBarButtonItem?.isEnabled = false
           
        } else {
            filtered = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease.circle"), style: .plain, target: self, action: #selector(showFavorites(_:)))
            isShowingFavorites.toggle()
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
       
        print(isShowingFavorites)
        navigationItem.leftBarButtonItems = [editButtonItem, filtered]
        tableView.reloadData()
    }
    private func addDummyCells() {
        
        let dummyElement: VantagePoint = {
            let coordinate = CLLocationCoordinate2D(latitude: 55.507222, longitude: -0.1275)
            let location = VPLocation(title: "MYPlace", coordinate: coordinate, info: "no info")
            
            let el = VantagePoint(placeName: "place0", location: location, placeImage: UIImage(systemName: "cloud"), isFavourite: false)
            return el
        }()
        
        places.insert(dummyElement, at: 0)
        let indexPath = IndexPath(item: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .left)
        
    }
    @objc private func addVP() {
        let vcMap = storyboard?.instantiateViewController(identifier: "mapVC") as! MapViewController
        
        vcMap.delegate = self
        
//        let vc = storyboard?.instantiateViewController(identifier: "myModalView") as! DetailViewController
//        vc.delegate = self
        
        //vcMap.modalPresentationStyle = .pageSheet
        navigationController?.pushViewController(vcMap, animated: true)
 //       present(vcMap, animated: true, completion: nil)
    }
    
    
    private func setupTableView() {
        //tableView.isEditing = true
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
    
        return isShowingFavorites ? favorites.count : places.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MapViewCell.reuseIdentifier, for: indexPath) as! MapViewCell
        
        let newPlace: VantagePoint = isShowingFavorites ? favorites[indexPath.row] : places[indexPath.row]
        cell.place = newPlace
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !isShowingFavorites else {
            if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: indexPathForSelectedRow, animated: false)
            }
            return
            
        }
        
        
        let vc = storyboard?.instantiateViewController(identifier: "myModalView") as! DetailViewController
        vc.delegate = self
        vc.isButtonHidden = true
        vc.newPlace = places[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            places.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false 
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return !isShowingFavorites
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = places[sourceIndexPath.row]
        places.remove(at: sourceIndexPath.row)
        places.insert(movedObject, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
       
        return (tableView.isEditing || isShowingFavorites) ? .none : .delete
        
    }
    
  
}

extension RootViewController: MapViewControllerDelegate {
    func mapViewController(_ vc: MapViewController, didAddNewData data: VantagePoint) {
        places.append(data)
        favorites = places.filter({ data in
            data.isFavourite
        })
        let indexPath = IndexPath(row: places.count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: .left)
        //tableView.reloadData()
    }
    
    
}
extension RootViewController: DetailViewControllerDelegate {
    func detailViewController(_ vc: DetailViewController, didAddNewData data: VantagePoint) {
        print("no deberia estar nunca aca")
    }
    
    func detailViewController(_ vc: DetailViewController, didUpdateDataWith data: VantagePoint) {
        let vpUUID = data.uuid
        let vpIndex = places.firstIndex { place in
            place.uuid == vpUUID
        }
        places[vpIndex! as Int] = data
        favorites = places.filter({ data in
            data.isFavourite
        })
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        //tableView.reloadData()
    }
    
    
}

//    func detailViewController(_ vc: DetailViewController, didUpdateDataWith data: VantagePoint) {
//        let vpUUID = data.uuid
//        let vpIndex = places.firstIndex { place in
//            place.uuid == vpUUID
//        }
//        places[vpIndex! as Int] = data
//        favorites = places.filter({ data in
//            data.isFavourite
//        })
//        if let indexPath = tableView.indexPathForSelectedRow {
//            tableView.reloadRows(at: [indexPath], with: .automatic)
//        }
//        //tableView.reloadData()
//    }



// MARK: - DetailViewControllerDelegate Conformance


//extension RootViewController: DetailViewControllerDelegate {
//    func detailViewController(_ vc: DetailViewController, didAddNewData data: VantagePoint) {
////
//        places.append(data)
//        favorites = places.filter({ data in
//            data.isFavourite
//        })
//        let indexPath = IndexPath(row: places.count-1, section: 0)
//        tableView.insertRows(at: [indexPath], with: .left)
//        //tableView.reloadData()
//    }
//
//    func detailViewController(_ vc: DetailViewController, didUpdateDataWith data: VantagePoint) {
//        let vpUUID = data.uuid
//        let vpIndex = places.firstIndex { place in
//            place.uuid == vpUUID
//        }
//        places[vpIndex! as Int] = data
//        favorites = places.filter({ data in
//            data.isFavourite
//        })
//        if let indexPath = tableView.indexPathForSelectedRow {
//            tableView.reloadRows(at: [indexPath], with: .automatic)
//        }
//        //tableView.reloadData()
//    }
//}
