//
//  ContentView.swift
//  FinalProject
//
//  Created by Emma  Hopson on 10/24/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
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
                    Text("Explore sunrise and sunset times at different locations around the world.")
                        .font(.title)
                        .frame(minWidth: 300, idealWidth: 300, maxWidth: 300)
                    Spacer()
                        .frame(height: 50.0)
                    NavigationLink("Explore by Coordinates ->"){
                        CoordinateView()
                    }.customNavigationLink()
                    Spacer()
                        .frame(height: 25.0)
                    NavigationLink("Explore by Country ->"){
                        MapView(lat: 20.00, lng: 45.00)
                    }.customNavigationLink()
                }
                .padding()
                .frame(maxWidth: .infinity)
                

            })
            
        }
        .navigationTitle("")
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationViewStyle(.stack)
    }
}


#Preview {
    ContentView()
}
