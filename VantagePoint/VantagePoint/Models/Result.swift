//
//  Result.swift
//  VantagePoint
//
//  Created by Juan Manuel Tome on 12/06/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    enum LoadingState {
        case loading, loaded, failed
    }
    
//    func fetchNearbyPlaces() {
//        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(placemark.coordinate.latitude)%7C\(placemark.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
//
//        guard let url = URL(string: urlString) else {
//            print("Bad URL: \(urlString)")
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data {
//                // we got some data back!
//                let decoder = JSONDecoder()
//
//                if let items = try? decoder.decode(Result.self, from: data) {
//                    // success – convert the array values to our pages array
//                    self.pages = Array(items.query.pages.values).sorted()
//                    self.loadingState = .loaded
//                    return
//                }
//            }
//
//            // if we're still here it means the request failed somehow
//            self.loadingState = .failed
//        }.resume()
//    }
    
}
