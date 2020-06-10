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
            
            self.favoriteIcon.image = place!.isFavourite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
            
        }
    }
    // MARK: - Constants
    //let myColors: [UIColor] = [#colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1), #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1), #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1), #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1), #colorLiteral(red: 1, green: 0.5409764051, blue: 0.8473142982, alpha: 1)]

    // MARK: - Properties
    
    private lazy var labels: [UILabel] = [UILabel]()

    var favoriteIcon: UIImageView = UIImageView(frame: .zero)
    let vpImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "cloud"))
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        //image.layer.cornerRadius = 10 //this wont work with scaleAspectFit
        return image
    }()
    
    let cellView: UIView = {
       let view = UIView()
//        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        //cellView.addSubview(stackView)
        
        let stackView2 = UIStackView(arrangedSubviews: subViews[1])
        stackView2.distribution = .equalSpacing
        stackView2.axis = .horizontal
        stackView2.spacing = 5
        //cellView.addSubview(stackView2)
        
        let stackView3 = UIStackView(arrangedSubviews: [stackView2,stackView])
        stackView3.distribution = .fillProportionally
        stackView3.axis = .vertical
        stackView3.spacing = 1
        cellView.addSubview(stackView3)
        
        
//        stackView2.anchor(top: cellView.topAnchor, left: labels[Labels.Location.rawValue].rightAnchor, bottom: stackView.topAnchor, right: cellView.rightAnchor, paddingTop: 10, paddingLeft: 5, paddingBottom: 0, paddingRight: 10, width: 0, height: 0, enableInsets: false)
//
//        stackView.anchor(top: stackView2.bottomAnchor, left: labels[Labels.Location.rawValue].rightAnchor, bottom: cellView.bottomAnchor, right: cellView.rightAnchor, paddingTop: 3, paddingLeft: 5, paddingBottom: 5, paddingRight: 10, width: 0, height: 70, enableInsets: false)
        
        stackView3.anchor(top: cellView.topAnchor, left: nil, bottom: cellView.bottomAnchor, right: cellView.rightAnchor, paddingTop: 10, paddingLeft: 5, paddingBottom: 0, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        
        
    }
    
    private func setupCellView() {
        //cellView.backgroundColor = myColors.randomElement()
        addSubview(cellView)
        createFormLabels()

        cellView.addSubview(vpImage)
        cellView.addSubview(favoriteIcon)
        
        cellView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 60, width: 0, height: 0, enableInsets: false)
        
        vpImage.anchor(top: cellView.topAnchor, left: cellView.leftAnchor, bottom: cellView.bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        
        labels[Labels.Location.rawValue].anchor(top: cellView.topAnchor, left: vpImage.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        favoriteIcon.anchor(top: nil, left: vpImage.rightAnchor, bottom: cellView.bottomAnchor, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        setupStackViews()
        self.selectionStyle = .default
    }
}


