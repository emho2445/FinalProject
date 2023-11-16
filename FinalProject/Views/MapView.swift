//
// MapView.swift
//FinalProject
//
// Created by Emma  Hopson on 10/24/23.


import Foundation
import SwiftUI
import MapKit
import CoreLocation


//struct MapView: View {
//    @State private var showSheet = false
//    let lat: Double
//    let lng: Double
//
//
//    var body: some View {
//
//        Map() {
//
//            Annotation("Latitude: \(lat), Longitude: \(lng)", coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng), anchor: .bottom){
//                VStack{
//                    Button("Show Time Details"){
//                        showSheet = true
//                    }.sheet(isPresented: $showSheet){
//                        DetailsView(lat: String(lat), lng: String(lng))
//                    }.customNavigationLink()
//                    //DebugTempView(lat: String(lat), lng: String(lng))
//                }
//                //.padding()
////              .background(in: .capsule)
//            }
//        }
//        .mapStyle(.imagery(elevation: .realistic))
//        .mapControls {
//            //MapUserLocationButton()
//            MapCompass()
//            MapScaleView()
//            MapPitchToggle()
//// USE THIS COMMENTED CODE TO START TO FIGURE OUT WEEK 2 CODE
////        .onAppear{
////            timeViewModel.getSunTimes(lat: String(lat), lng: String(lng))
////            }
//
//        }
//    }
//}
//
////#Preview {
////    MapView(lat: 0, lng: 0)
////}


struct MapView: View {
    let lat: Double
        let lng: Double
        
        @State private var cameraProsition: MapCameraPosition
        
        init(lat: Double, lng: Double) {
            self.lat = lat
            self.lng = lng
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            _cameraProsition = State(initialValue: MapCameraPosition.camera(MapCamera(
                centerCoordinate: coordinate,
                distance: 3729,
                heading: 92,
                pitch: 70
            )))
        }
    
    @State private var showSheet = false
    @State var placeAPin = false
    @State var pinLocation :CLLocationCoordinate2D? = nil
    
    @State var mapLocations: [CLLocationCoordinate2D] = []

    
    var body: some View {
        GeometryReader { proxy in
            NavigationView {
                VStack{
                    MapReader{ reader in
                        Map(
                            position: $cameraProsition,
                            interactionModes: .all
                        )
                        {
                            Annotation("Latitude: \(lat), Longitude: \(lng)", coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng), anchor: .bottom){
                                VStack{
                                    Button("Add a Pin"){
                                        mapLocations.append(CLLocationCoordinate2D(latitude: lat, longitude: lng))
                                    }.customNavigationLink()
                                    Button("Show Time Details"){
                                        showSheet = true
                                    }.sheet(isPresented: $showSheet){
                                        DetailsView(lat: String(lat), lng: String(lng))
                                    }.customNavigationLink()
                                }
                            }
                            
                            
                            if let pl = pinLocation {
                                Annotation("(\(pl.latitude), \(pl.longitude))", coordinate: pl){
                                    VStack{
                                        Button("Add a Pin"){
                                            mapLocations.append(CLLocationCoordinate2D(latitude: lat, longitude: lng))
                                        }
                                        Button("Show Time Details"){
                                            showSheet = true
                                        }.sheet(isPresented: $showSheet){
                                            DetailsView(lat: String(pl.latitude), lng: String(pl.longitude))
                                        }.customNavigationLink()
                                    }
                                    
                                }
                            }
                            }
                                .onTapGesture(perform: { screenCoord in
                                    pinLocation = reader.convert(screenCoord, from: .local)
                                    placeAPin = false
                                })
                            
                                .mapControls{
                                    MapCompass()
                                    MapScaleView()
                                    MapPitchToggle()
                                }
                            
                                .mapStyle(.imagery(elevation: .automatic))
                        }
                        
                    }
                    .navigationTitle("Map View")
                    .toolbar {
                        if !placeAPin{
                            Button("Place a Pin") {
                                placeAPin = true
                            }
                        }
                    }
                }
            }
        }
    }
