//
//  MapView.swift
//  FinalProject
//
//  Created by Emma  Hopson on 10/24/23.
//

import Foundation
import SwiftUI
import MapKit

struct MapView: View {
// USE THIS COMMENTED CODE TO START TO FIGURE OUT WEEK 2 CODE
//    @ObservedObject var timeViewModel = TimeViewModel()
    let lat: Double
    let lng: Double
    
    
    var body: some View {
        
        Map() {
            Marker("Latitude: \(lat), Longitude: \(lng))", systemImage: "mappin.and.ellipse", coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng))
        }
        .mapStyle(.imagery(elevation: .realistic))
        .mapControls {
            //MapUserLocationButton()
            MapCompass()
            MapScaleView()
            MapPitchToggle()
// USE THIS COMMENTED CODE TO START TO FIGURE OUT WEEK 2 CODE
//        .onAppear{
//            timeViewModel.getSunTimes(lat: String(lat), lng: String(lng))
//            }
        
        }
    }
}

//#Preview {
//    MapView(lat: 0, lng: 0)
//}
