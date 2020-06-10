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
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}

struct VantagePoint {
    var placeName: String?
    var location: VPLocation
    var placeImage: UIImage?
    var uuid: UUID = UUID()
    var isFavourite: Bool
}

