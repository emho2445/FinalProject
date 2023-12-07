//
//  PinnedLocations.swift
//  FinalProject
//
//  Created by Emma  Hopson on 12/6/23.
//

import SwiftUI
import CoreLocation


struct PinnedLocationsView: View {
    @Environment(\.dismiss) var dismiss
    
    var mapLocations: [CLLocationCoordinate2D]
    
    @State var pinnedLocationList: [LocationMarkings] = []
    @State var locationsLoaded = false
    
    var body: some View {

            ZStack(content: {
                
                VStack{
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Text("Pinned Locations")
                        .font(.title)
                    
                    Spacer()
                        .frame(height: 20)
                   
                    if locationsLoaded == false{
                        Text("Pinned Locations Loading..")
                    }else{
                        ListView(pinnedLocationList: pinnedLocationList)
                            //.frame(minHeight: 300)
                    }
                    
                    
                    Spacer()
                        .frame(height: 60)
                    
                    Button("Close Sheet"){
                        dismiss()
                    }.foregroundColor(Color("Burnt"))

                    
                }
                
            })
            .onAppear(perform: onLoad)
    }
    
    
    func onLoad(){
        pinnedLocationList = convertLocations(locations: mapLocations)
        print(pinnedLocationList)
        locationsLoaded = true
    }
}



func convertLocations(locations: [CLLocationCoordinate2D]) -> [LocationMarkings] {
    return locations.map{ LocationMarkings(location: $0) }
}

struct LocationMarkings: Identifiable {
    var id: Int  { return UUID().hashValue }
    var location: CLLocationCoordinate2D
}


struct ListView: View {
    
    var pinnedLocationList: [LocationMarkings]
    
    var body: some View {
        List(pinnedLocationList, id: \.id){ location in
            NavigationLink(destination: MapView(lat: location.location.latitude, lng: location.location.longitude)) {
                ListRowView(pinnedLocation: location)
            }
        }
    }
    
    
}

struct ListRowView: View {
    
    var pinnedLocation: LocationMarkings
    
    var body: some View {
        HStack{
            
            Image(systemName: "pin.circle")
            Text("Lat: \(pinnedLocation.location.latitude)")
            Text("Long: \(pinnedLocation.location.longitude)")
        }
        
    }
    
    
}
