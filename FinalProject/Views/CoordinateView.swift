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
                Image("Sunset")
                    .resizable()
                    //.aspectRatio(contentMode: .fill)
                    //.frame(height: 1000, alignment: .top)
                    .scaledToFit()
                    //.scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                Rectangle()
                    .colorInvert()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.00)
                
                VStack{
                    Spacer()
                    
                    Group{
                        Text("Enter a LATITUDE coordinate. This is a number between -90 and 90.")
                        TextField("Latitude", text: $lat)
                        
                        Text("Enter a LONGITUDE coordinate. This is a number between -180 and 180.")
                        TextField("Longitude", text: $lng)
                    }
                    .frame(minWidth: 300, idealWidth: 300, maxWidth: 300)
                    
                    Spacer()
                        .frame(height: 200)
                    
                    
                    if lat != "", lng != "" {
                        
                        if let doubleLat = Double(lat), let doubleLng = Double(lng){
                            if doubleLat < -90{
                                Text("ERROR!")
                                    .foregroundColor(.red)
                                Text("Value entered for Latitude is invalid")
                                    .foregroundColor(.red)
                            }else if doubleLat > 90{
                                Text("ERROR!")
                                    .foregroundColor(.red)
                                Text("Value entered for Latitude is invalid")
                                    .foregroundColor(.red)
                            }
                            
                            if doubleLng < -180{
                                Text("ERROR!")
                                    .foregroundColor(.red)
                                Text("Value entered for Longitude is invalid")
                                    .foregroundColor(.red)
                            }else if doubleLng > 180{
                                Text("ERROR!")
                                    .foregroundColor(.red)
                                Text("Value entered for Longitude is invalid")
                                    .foregroundColor(.red)
                            }
                            
                            NavigationLink(destination: MapView(lat: doubleLat, lng: doubleLng)){
                                Text("See Details ->")
                            }.customNavigationLink()
                        }else{
                            Text("ERROR!")
                                .foregroundColor(.red)
                            Text("Values entered are invalid")
                                .foregroundColor(.red)
                        }
                        
                        
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
