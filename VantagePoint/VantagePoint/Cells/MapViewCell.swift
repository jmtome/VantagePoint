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
    
    // MARK: - Cell Reuse Identifier
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    // MARK: - Computed Properties
    
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
    
    // MARK: - Properties
    private lazy var labels: [UILabel] = [UILabel]()
    
    let vpImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "cloud"))
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        //image.layer.cornerRadius = 10 //this wont work with scaleAspectFit
        return image
    }()
    
    // MARK: - Overriden Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private Methods
    
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
    private func setupStackViews() {
        let subViews: [[UIView]] = [[labels[Labels.Latitude.rawValue],labels[Labels.Longitude.rawValue]],
                                    [labels[Labels.Lat.rawValue],labels[Labels.Long.rawValue]]]
        
        let stackView = UIStackView(arrangedSubviews: subViews[0])
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = 5
        addSubview(stackView)
        
        let stackView2 = UIStackView(arrangedSubviews: subViews[1])
        stackView2.distribution = .equalSpacing
        stackView2.axis = .horizontal
        stackView2.spacing = 5
        addSubview(stackView2)
        
        stackView2.anchor(top: topAnchor, left: labels[Labels.Location.rawValue].rightAnchor, bottom: stackView.topAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 5, paddingBottom: 0, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        
        stackView.anchor(top: stackView2.bottomAnchor, left: labels[Labels.Location.rawValue].rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 3, paddingLeft: 5, paddingBottom: 5, paddingRight: 10, width: 0, height: 70, enableInsets: false)
        
    }
    private func setupCellView() {
        addSubview(vpImage)
        createFormLabels()
        
        vpImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        
        labels[Labels.Location.rawValue].anchor(top: self.topAnchor, left: vpImage.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
            
        setupStackViews()

    }
}


