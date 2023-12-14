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
    
    @Binding var showPinnedList: Bool
    @Binding var selectedCoordinate: CLLocationCoordinate2D?
    //var onLocationSelected: ((CLLocationCoordinate2D) -> Void)?
    
    var body: some View {
        NavigationView{
            
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
                        ListView(pinnedLocationList: pinnedLocationList,
                                 onLocationSelected: { location in
                                                 self.selectedCoordinate = location // Update the selected coordinate
                                             })
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
    }
    
    
    func onLoad(){
        pinnedLocationList = convertLocations(locations: mapLocations)
        print(pinnedLocationList)
        locationsLoaded = true
    }
    
    func locationSelected(_ location: LocationMarkings) {
        selectedCoordinate = location.location
            showPinnedList = false // Dismiss PinnedLocationsView
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
    //@Environment(\.presentationMode) var presentationMode
    
    var pinnedLocationList: [LocationMarkings]
    var onLocationSelected: ((CLLocationCoordinate2D) -> Void)? // Callback closure
    
    var body: some View {
//        List(pinnedLocationList, id: \.id){ location in
//            NavigationLink(
//                destination: MapView(lat: location.location.latitude, lng: location.location.longitude)
//                                    .navigationBarBackButtonHidden(true) // Hides back button in the MapView
//                                    .navigationBarItems(leading: Button(action: {
//                                        presentationMode.wrappedValue.dismiss() // Dismisses PinnedLocationsView
//                                    }) {
//                                        Image(systemName: "arrow.backward")
//                                    }),
//                                label: {
//                                    ListRowView(pinnedLocation: location)
//                                }
//                )
//            }
        
        List(pinnedLocationList, id: \.id) { location in
                    NavigationLink(
                        destination: MapView(lat: location.location.latitude, lng: location.location.longitude), // Replace with the original destination
                        label: {
                            ListRowView(pinnedLocation: location)
                                .onTapGesture {
                                    onLocationSelected?(location.location) // Call the closure when a location is selected
                                }
                        }
                    )
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
