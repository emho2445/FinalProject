//
//  CoordinateView.swift
//  FinalProject
//
//  Created by Emma  Hopson on 10/24/23.
//

import SwiftUI

struct CoordinateView: View {
    @State var lat: String = ""
    @State var lng: String = ""

    var body: some View {
            ZStack(content: {
                Image("Earth")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                Rectangle()
                    .colorInvert()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.70)
                
                VStack{
                    Spacer()
                    
                    Group{
                        Text("Enter a LATITUDE in the field below. This is a number between -90 and 90. You may include up to 4 decimal points")
                        TextField("Latitude", text: $lat)
                        
                        Text("Enter a LONGITUDE in the field below. This is a number between -180 and 180. You may include up to 4 decimal points")
                        TextField("Longitude", text: $lng)
                    }
                    .frame(minWidth: 300, idealWidth: 300, maxWidth: 300)
                    
                    if lat != "", lng != "" {
                        NavigationLink(destination: MapView(lat: Double(lat)!, lng: Double(lng)!)){
                            Text("See Details ->")
                        }.customNavigationLink()
                    }
                    Spacer()
                        .frame(height: 25.0)
                    
                    Button("Clear Fields"){
                        lat = ""
                        lng = ""
                    }.customNavigationLink()
                    
                    Spacer()
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
                //.background(.ultraThinMaterial)
            })

        .navigationTitle("Set Location")
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)

    }
}

#Preview {
    CoordinateView()
}
