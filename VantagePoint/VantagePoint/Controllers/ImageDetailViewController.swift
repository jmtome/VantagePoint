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
        
        
        self.view.addSubview(imageView)
    
        imageView.isUserInteractionEnabled = true
        let gst = UITapGestureRecognizer(target: self, action: #selector(showImageInDetail))
        imageView.addGestureRecognizer(gst)
        
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -60).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        //imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        // Do any additional setup after loading the view.
        setupTableView()
        

    }
    @objc private func showImageInDetail(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            
            let imgVC = ImageViewController(image: #imageLiteral(resourceName: "London"))
//            let imageView: UIImageView = {
//                let view = UIImageView(image: #imageLiteral(resourceName: "London"))
//                return view
//            }()
            //let imgVC = Test2ViewController()
            navigationController?.pushViewController(imgVC, animated: true)
        }
    }
    
    private func addNavigationBar() {
        let height: CGFloat = 75
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: statusBarHeight, width: UIScreen.main.bounds.width, height: height))
        navbar.backgroundColor = UIColor.white
        navbar.delegate = self as? UINavigationBarDelegate

        let navItem = UINavigationItem()
        navItem.title = "Sensor Data"
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(close))

        navbar.items = [navItem]

        view.addSubview(navbar)

        self.view?.frame = CGRect(x: 0, y: height, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - height))
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
