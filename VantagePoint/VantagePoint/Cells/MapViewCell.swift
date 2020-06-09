//
//  MapViewCell.swift
//  VantagePoint
//
//  Created by Juan Manuel Tome on 04/06/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//
import UIKit


class MapViewCell: UITableViewCell {
    
    enum Labels: Int {
        case Latitude = 0
        case Longitude
        case Location
        case Lat
        case Long
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    var place : VantagePoint? {
        didSet {
            if let coordinates = place?.location.coordinate {
                labels[Labels.Latitude.rawValue].text = String(format: "%.2f", coordinates.latitude)
                labels[Labels.Longitude.rawValue].text = String(format: "%.2f", coordinates.longitude)
                labels[Labels.Location.rawValue].text = place?.placeName
            }
            vpImage.image = place?.placeImage
        }
    }
    
    
    
    
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
    
    
    private lazy var labels: [UILabel] = [UILabel]()


    private func createFormLabels() {
        let labelTitles = ["Latitude","Longitude","Location","Lat","Long"]
        
        for title in labelTitles {
            let newLabel = UILabel.init(frame: .zero)
            newLabel.text = title
            newLabel.font = UIFont.boldSystemFont(ofSize: 16)
            newLabel.textAlignment = .left
            newLabel.translatesAutoresizingMaskIntoConstraints = false
            self.labels.append(newLabel)
            addSubview(newLabel)
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(vpImage)
        addSubview(cellView)
        createFormLabels()
        

        let subViews: [[UIView]] = [[labels[Labels.Latitude.rawValue],cellView,labels[Labels.Longitude.rawValue]],
            [labels[Labels.Lat.rawValue],cellView,labels[Labels.Long.rawValue]]]

        let stackView = UIStackView(arrangedSubviews: subViews[0])
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = 5
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let stackView2 = UIStackView(arrangedSubviews: subViews[1])
        stackView2.distribution = .equalSpacing
        stackView2.axis = .horizontal
        stackView2.spacing = 5
        addSubview(stackView2)
        stackView2.translatesAutoresizingMaskIntoConstraints = false

        vpImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)

        labels[Labels.Location.rawValue].anchor(top: self.topAnchor, left: vpImage.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)

        stackView2.anchor(top: topAnchor, left: labels[Labels.Location.rawValue].rightAnchor, bottom: stackView.topAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 5, paddingBottom: 0, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        
        
//        stackView2.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
//        stackView2.leftAnchor.constraint(equalTo: mapNameLabel.rightAnchor, constant: 5).isActive = true
//        stackView2.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: 0).isActive = true
//        stackView2.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
//
        
        stackView.anchor(top: stackView2.bottomAnchor, left: labels[Labels.Location.rawValue].rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 3, paddingLeft: 5, paddingBottom: 5, paddingRight: 10, width: 0, height: 70, enableInsets: false)
               
        
      
        
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(cellView)
        cellView.addSubview(labels[Labels.Location.rawValue])
        self.selectionStyle = .default
        
        // Activate cell constraints
        
        cellView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0, enableInsets: false)
//
//        NSLayoutConstraint.activate([
//            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
//            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
//            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
//            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
//        ])
        
        labels[Labels.Location.rawValue].anchor(top: nil, left: cellView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 200, height: 200, enableInsets: false)
        labels[Labels.Location.rawValue].centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        
//
//        mapNameLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
//        mapNameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        mapNameLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
//        mapNameLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20).isActive = true
    }
}


