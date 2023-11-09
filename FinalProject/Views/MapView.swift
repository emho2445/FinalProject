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
    @State private var showSheet = false
    let lat: Double
    let lng: Double
    
    
    var body: some View {
        
        Map() {

            Annotation("Latitude: \(lat), Longitude: \(lng)", coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng), anchor: .bottom){
                VStack{
                    Button("Show Time Details"){
                        showSheet = true
                    }.sheet(isPresented: $showSheet){
                        DetailsView(lat: String(lat), lng: String(lng))
                    }.customNavigationLink()
                    //DebugTempView(lat: String(lat), lng: String(lng))
                }
                //.padding()
//              .background(in: .capsule)
            }
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
