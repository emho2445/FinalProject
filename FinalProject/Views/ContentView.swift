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
                    Text("EXPLORE SOLAR TIMES AROUND THE WORLD")
                        .font(Font.custom("Raleway", size: 42))
                        .frame(minWidth: 300, idealWidth: 300, maxWidth: 300)
                        .multilineTextAlignment(.center)
                    Spacer()
                        .frame(height: 200.0)
                    NavigationLink{
                        CoordinateView()
                    }label: {
                        Text("Start Exploring ->")
                            .customNavigationLink()
                    }
                    //.customNavigationLink()
                }
                //.padding()
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
