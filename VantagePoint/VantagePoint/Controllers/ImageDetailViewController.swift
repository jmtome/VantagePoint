//
//  ImageDetailViewController.swift
//  VantagePoint
//
//  Created by Juan Manuel Tome on 14/06/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {

    private let imageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = #imageLiteral(resourceName: "London").roundedImage
        image.contentMode = .scaleAspectFit
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
    
    private let closeButton: UIButton = {
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: .zero, size: smallSquare))
        button.setBackgroundImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 35).isActive = true
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
        //button.isUserInteractionEnabled = true

        return button
        
    }()
    
//     init(closeButton: UIButton) {
//        self.closeButton = closeButton
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //se me ocurre que por algun motivo imageView tiene un marco no visible de background con color transparente y que al colocar el boton como subview del main view, sigue estando tapado por el imageview, y por eso no estaba andando...
        
        
        //self.view.addSubview(closeButton)
        self.view.addSubview(imageView)
        imageView.addSubview(closeButton)
        closeButton.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        closeButton.leftAnchor.constraint(equalTo: imageView.leftAnchor).isActive = true
//        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40, withIdentifier: "closeBtnTop2").isActive = true
//        closeButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20, withIdentifier: "closeBtnLeft2").isActive = true
        closeButton.addTarget(self, action: #selector(close(_:)), for: .touchUpInside)

        //imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -50, withIdentifier: "topAnchor").isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        //imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        // Do any additional setup after loading the view.
        setupTableView()
    }
    
    @objc func close(_ sender: UIButton) {
        dismiss(animated: true) {
            
        }
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -50, withIdentifier: "tvTop").isActive = true
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
            return 5
        case 1:
            return 3
        default:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newCell", for: indexPath)
        cell.textLabel?.text = "hola pepe"
        return cell
    }
    
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
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
