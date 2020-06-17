//
//  ImageDetailViewController.swift
//  VantagePoint
//
//  Created by Juan Manuel Tome on 14/06/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController, UINavigationBarDelegate {

    private let imageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = #imageLiteral(resourceName: "London").roundedImage
        image.contentMode = .scaleAspectFill
        //image.widthAnchor.constraint(equalToConstant: screenHeight / 2.5, withIdentifier: "imageWidth").isActive = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        return image
    }()
    
    let tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    lazy var aMultiplier: CGFloat = {
        return (imageView.image?.size.width)! / (imageView.image?.size.height)!
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        //se me ocurre que por algun motivo imageView tiene un marco no visible de background con color transparente y que al colocar el boton como subview del main view, sigue estando tapado por el imageview, y por eso no estaba andando...
        
        
        self.view.addSubview(imageView)

        
        imageView.isUserInteractionEnabled = true
        let gst = UITapGestureRecognizer(target: self, action: #selector(showImageInDetail))
        imageView.addGestureRecognizer(gst)
        
        imageView.widthAnchor.constraint(equalToConstant: screenWidth / 1 - 10).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1 / aMultiplier).isActive = true
        
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        //imageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        //imageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        setupTableView()
        

    }
    @objc private func showImageInDetail(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            
            let imgVC = ImageViewController(image: #imageLiteral(resourceName: "London"))
            navigationController?.pushViewController(imgVC, animated: true)
        }
    }
    
    
    
    @objc func close(_ sender: UIButton) {
        dismiss(animated: true) {
            
        }
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10, withIdentifier: "tvTop").isActive = true
        tableView.heightAnchor.constraint(equalToConstant: screenHeight / 2).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0, withIdentifier: "tvLeft").isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0, withIdentifier: "tvRight").isActive = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "newCell")
        
        
    }
   

}

extension ImageDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 5
        default:
            return 3
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "newCell", for: indexPath)
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "newCell")
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "City"
                cell.detailTextLabel?.text = "pepe1"
            case 1:
                cell.textLabel?.text = "Longitude"
                cell.detailTextLabel?.text = "pepe2"
            case 2:
                cell.textLabel?.text = "Latitude"
                cell.detailTextLabel?.text = "pepe3"
            default:
                cell.textLabel?.text = "pepe"
                cell.detailTextLabel?.text = "pepe4"

            }
        case 1:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "ISO"
                cell.detailTextLabel?.text = "pepe5"
            case 1:
                cell.textLabel?.text = "Shutter Speed"
                cell.detailTextLabel?.text = "pepe6"
            case 2:
                cell.textLabel?.text = "Aperture"
                cell.detailTextLabel?.text = "pepe7"
            case 3:
                cell.textLabel?.text = "Camera"
                cell.detailTextLabel?.text = "pepe camera"
            case 4:
                cell.textLabel?.text = "Lens"
                cell.detailTextLabel?.text = "pepe lens"
            default:
                cell.textLabel?.text = "pepe"
                cell.detailTextLabel?.text = "pepe8"
            }
        default: break
            
        }
        
        //cell.textLabel?.text = "hola pepe"
        return cell
    }
    
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Location Info:"
        case 1:
            return "Image Info:"
        default:
            return "0"
        }
    }
    
}
