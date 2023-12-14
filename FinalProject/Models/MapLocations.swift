//
//  MapLocations.swift
//  FinalProject
//
//  Created by Emma  Hopson on 11/15/23.
//

import Foundation
import MapKit


struct MapLocations: Identifiable{
    let coordinate: CLLocationCoordinate2D
    var id = UUID()
}
