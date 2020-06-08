//
//  SecondViewController.swift
//  VantagePoint
//
//  Created by Juan Manuel Tome on 05/06/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    let vcTitle: UILabel = {
        let title = UILabel(frame: .zero)
        title.font = UIFont.preferredFont(forTextStyle: .largeTitle).bold()
        title.text = "Add VP"
        return title
    }()
    
    
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorColor = UIColor.blue
        return tv
    }()
    
    let placeNameLabel: UILabel = {
        let name = UILabel(frame: .zero)
        name.font = UIFont.preferredFont(forTextStyle: .body).bold()
        name.text = "Place Name: "
        return name
    }()
    
    let placeNameTxtFld: UITextField = {
        let txtField: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 500.00, height: 30.00));
        //txtField.borderStyle = UITextField.BorderStyle.line
        txtField.placeholder = "Place Name"
        txtField.tag = 0
        //txtField.layer.cornerRadius = 10
        //txtField.layer.masksToBounds = true
        txtField.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
        return txtField
    }()
    
    let placeCountryLabel: UILabel = {
        let name = UILabel(frame: .zero)
        name.font = UIFont.preferredFont(forTextStyle: .body).bold()
        name.text = "Country: "
        return name
    }()
    
    let placeCountryTxtFld: UITextField = {
        let txtField: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 500.00, height: 30.00));
        //txtField.borderStyle = UITextField.BorderStyle.line
        txtField.placeholder = "Country"
        txtField.tag = 1
        //txtField.layer.cornerRadius = 10
        //txtField.layer.masksToBounds = true
        txtField.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
        return txtField
    }()
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        placeCountryTxtFld.delegate = self
        placeNameTxtFld.delegate = self
        
        addSubviews()

       
        
    

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            let nextTag = textField.tag + 1

        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        return true
    }
    
   
    
    
    func addSubviews() {
        view.addSubview(placeNameTxtFld)
        view.addSubview(vcTitle)
        view.addSubview(placeNameLabel)
        view.addSubview(placeCountryTxtFld)
        view.addSubview(placeCountryLabel)
      
        
        vcTitle.translatesAutoresizingMaskIntoConstraints = false
        vcTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/20).isActive = true
        
        placeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        placeNameTxtFld.translatesAutoresizingMaskIntoConstraints = false
        placeCountryLabel.translatesAutoresizingMaskIntoConstraints = false
        placeCountryTxtFld.translatesAutoresizingMaskIntoConstraints = false
        
        placeNameLabel.topAnchor.constraint(equalTo: vcTitle.topAnchor, constant: view.frame.height / 10).isActive = true
        placeNameTxtFld.topAnchor.constraint(equalTo: vcTitle.topAnchor, constant: view.frame.height / 10).isActive = true
        placeNameTxtFld.leftAnchor.constraint(equalTo: placeNameLabel.rightAnchor, constant: 20).isActive = true
       
        placeNameTxtFld.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true 
        
        
        placeCountryLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: view.frame.height / 20 ).isActive = true
        placeCountryTxtFld.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: view.frame.height / 20 ).isActive = true
        //placeCountryTxtFld.leftAnchor.constraint(equalTo: placeCountryLabel.rightAnchor, constant: 20).isActive = true
        placeCountryTxtFld.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        
        
        
//        let stackView = UIStackView(arrangedSubviews: [placeNameLabel, placeNameTxtFld])
//        stackView.axis = .horizontal
//        stackView.distribution = .equalSpacing
//
//        let stackView2 = UIStackView(arrangedSubviews: [placeContryLabel, placeCountryTxtFld])
//        stackView.axis = .horizontal
//        stackView.distribution = .equalSpacing
//
//        let vStack = UIStackView(arrangedSubviews: [stackView, stackView2])
//        vStack.axis = .vertical
//        vStack.distribution = .equalSpacing
//
//        view.addSubview(vStack)
//        vStack.translatesAutoresizingMaskIntoConstraints = false
//        vStack.topAnchor.constraint(equalTo: vcTitle.topAnchor, constant: 100).isActive = true
//
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    
//    override func setEditing(_ editing: Bool, animated: Bool) {
//        super.setEditing(editing,animated:animated)
//        if(self.isEditing)
//        {
//            self.editButtonItem.title = "Cancel"
//        }else
//        {
//            self.editButtonItem.title = "Change"
//        }
//    }
    
    
    @objc func editSave(_ sender: UIBarButtonItem) {
        //navigationController?.popViewController(animated: true)
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("pepe dragged")
    }
    
//    func setupTableView() {
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "newCellId")
//        view.addSubview(tableView)
//
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
//            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
//            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
//            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
//        ])
//    }
    /*
     let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
     ac.addTextField()
     
     let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
         guard let answer = ac?.textFields?[0].text else { return }
         self?.submit(answer)
     }
     ac.addAction(submitAction)
     present(ac, animated: true)
     */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func addNavigationBar(withTitle title: String?) {
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
        navItem.title = title
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(pepe))

        navbar.items = [navItem]

        view.addSubview(navbar)

        self.view?.frame = CGRect(x: 0, y: height, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - height))
    }
    
    @objc func pepe(){
        print("pepe pressed back")
    }

}

//extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "newCellId", for: indexPath)
//
//        cell.textLabel?.text = "pepe \(indexPath.row)"
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Header \(section)"
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
//
//}
