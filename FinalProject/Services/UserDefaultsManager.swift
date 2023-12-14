//
//  UserDefaultsManager.swift
//  FinalProject
//
//  Created by Emma  Hopson on 12/11/23.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation

struct CodableCoordinate: Codable {
    let latitude: Double
    let longitude: Double

    init(coordinate: CLLocationCoordinate2D) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }

    var clLocationCoordinate2D: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct UserDefaultsManager {
    private static let mapLocationsKey = "MapLocations"

    static func saveMapLocations(_ locations: [CLLocationCoordinate2D]) {
        let codableCoordinates = locations.map { CodableCoordinate(coordinate: $0) }
        let encodedData = try? JSONEncoder().encode(codableCoordinates)
        UserDefaults.standard.set(encodedData, forKey: mapLocationsKey)
    }

    static func getMapLocations() -> [CLLocationCoordinate2D] {
        guard let mapLocationsData = UserDefaults.standard.data(forKey: mapLocationsKey),
              let decodedCoordinates = try? JSONDecoder().decode([CodableCoordinate].self, from: mapLocationsData) else {
            return []
        }
        return decodedCoordinates.map { $0.clLocationCoordinate2D }
    }
}
