//
//  VantagePointLocation.swift
//  VantagePoint
//
//  Created by Juan Manuel Tome on 04/06/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import Foundation
import MapKit

// TODO: - Implement UserDefaults with NSCoding

class VPLocation: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String?
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String?) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
    
}

extension VPLocation {
    convenience init(from placemark: MKPlacemark, info: String) {
        self.init(title: placemark.title!, coordinate: placemark.coordinate, info: info)
    }
}

extension VPLocation {
    convenience init(from mapItem: MKMapItem, info: String) {
        self.init(title: mapItem.placemark.title!, coordinate: mapItem.placemark.coordinate, info: info)
    }
}

struct VantagePoint {
    var placeName: String?
    var location: VPLocation
    var placeImage: UIImage?
    var uuid: UUID = UUID()
    var isFavourite: Bool = false
    
}

extension VantagePoint {
    init(from mapItem: MKMapItem, placeName: String, placeImage: UIImage, isFavourite: Bool) {
        location = VPLocation(from: mapItem, info: "")
        self.placeName = placeName
        self.placeImage = placeImage
        self.isFavourite = isFavourite
    }
}

extension VantagePoint {
    init(from placemark: MKPlacemark, placeName: String, placeImage: UIImage, isFavourite: Bool) {
        location = VPLocation(from: placemark, info: "")
        self.placeName = placeName
        self.placeImage = placeImage
        self.isFavourite = isFavourite
    }
}
