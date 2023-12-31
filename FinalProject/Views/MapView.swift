//
// MapView.swift
//FinalProject
//
// Created by Emma  Hopson on 10/24/23.


import Foundation
import SwiftUI
import MapKit
import CoreLocation


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
    
    //Pinned locations list
    @State var mapLocations: [CLLocationCoordinate2D] = UserDefaultsManager.getMapLocations() {
        didSet {
            UserDefaultsManager.saveMapLocations(mapLocations)
        }
    }
    
    //Push notifications
    @StateObject var pushNotificationService = PushNotificationService()
    
    @State private var showPinnedList = false
    
    //For the PinnedLocationView management
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    
    
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
                                    Button{
                                        //I know the issue is here
                                        mapLocations.append(CLLocationCoordinate2D(latitude: lat, longitude: lng))
                                    } label: {
                                        Text("Pin These Coordinates")
                                            .customNavigationLink()
                                    }
                                    //.customNavigationLink()
                                    
                                    
                                    
                                    Button{
                                        showSheet = true
                                    } label: {
                                        Text("Show Time Details")
                                            .customNavigationLink()
                                    }
                                    .sheet(isPresented: $showSheet){
                                        DetailsView(lat: String(lat), lng: String(lng), pushNotificationService: pushNotificationService)
                                    }
                                }
                            }
                            
                            
                            if let pl = pinLocation {
                                Annotation("(\(pl.latitude), \(pl.longitude))", coordinate: pl){
                                    VStack{
                                        Button{
                                            mapLocations.append(CLLocationCoordinate2D(latitude: pl.latitude, longitude: pl.longitude))
                                        }label: {
                                            Text("Pin These Coordinates")
                                                .customNavigationLink()
                                        }
                                        //.customNavigationLink()
                                        Button{
                                            showSheet = true
                                        }label: {
                                            Text("Show Time Details")
                                                .customNavigationLink()
                                        }
                                        .sheet(isPresented: $showSheet){
                                            //DetailsView(lat: String(pl.latitude), lng: String(pl.longitude), notificationPermissionsEnabled: $pushNotificationService)
                                        }
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
                .toolbar {
                    Button("Allow Notifications"){
                        pushNotificationService.requestPermissions()
                    }
                    
                    Spacer()
                    
                    Button("Show Pin List") {
                        placeAPin = true
                        print(mapLocations)
                        showPinnedList.toggle()
                    }.sheet(isPresented: $showPinnedList){
                        PinnedLocationsView(
                            mapLocations: mapLocations,
                        showPinnedList: $showPinnedList)
                    }
                }
                .navigationTitle("Map View")
            }
        }
    }
}
