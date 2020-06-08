//
//  MapViewCell.swift
//  VantagePoint
//
//  Created by Juan Manuel Tome on 04/06/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//
import UIKit


class MapViewCell: UITableViewCell {
    
    
    var place : VantagePoint? {
        didSet {
            vpImage.image = place?.placeImage
            mapNameLabel.text = place?.placeName
            if let coordinates = place?.location.coordinate {
                let latitude = String(format: "%.2f", coordinates.latitude)
                let longitude = String(format: "%.2f", coordinates.longitude)
                
                latLabel.text = latitude
                longLabel.text = longitude
            }
            
            
            
        }
    }
    
    let latLabel: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "latitud"
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let latLabelTitle: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "Lat"
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let longLabelTitle: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "Long"
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let longLabel: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "longitud"
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let mapNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Location 0"
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false //if i use the extension i shouldnt use this
        return label
    }()
    
    
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let vpImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "cloud"))
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        //image.layer.cornerRadius = 10 //this wont work with scaleAspectFit
        return image
    }()
    
    
    
    
    //    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    //        super.init(style: style, reuseIdentifier: reuseIdentifier)
    //        setupView()
    //    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(latLabel)
        addSubview(longLabel)
        addSubview(latLabelTitle)
        addSubview(longLabelTitle)
        addSubview(mapNameLabel)
        addSubview(vpImage)
        addSubview(cellView)
        
        vpImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        
        mapNameLabel.anchor(top: topAnchor, left: vpImage.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        
        
        //latLabel.anchor(top: mapNameLabel.bottomAnchor, left: vpImage.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        let stackView = UIStackView(arrangedSubviews: [latLabel,cellView,longLabel])
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = 5
        addSubview(stackView)
        
        
        let stackView2 = UIStackView(arrangedSubviews: [latLabelTitle,cellView,longLabelTitle])
        stackView2.distribution = .equalSpacing
        stackView2.axis = .horizontal
        stackView2.spacing = 5
        addSubview(stackView2)

       
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        
        stackView2.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        stackView2.leftAnchor.constraint(equalTo: mapNameLabel.rightAnchor, constant: 5).isActive = true
        stackView2.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: 0).isActive = true
        stackView2.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true 
       
        
        stackView.anchor(top: stackView2.bottomAnchor, left: mapNameLabel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 3, paddingLeft: 5, paddingBottom: 5, paddingRight: 10, width: 0, height: 70, enableInsets: false)
               
        
      
        
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(cellView)
        cellView.addSubview(mapNameLabel)
        self.selectionStyle = .default
        
        // Activate cell constraints
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        mapNameLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        mapNameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        mapNameLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        mapNameLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20).isActive = true
    }
}


