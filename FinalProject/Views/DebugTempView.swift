//
//  DebugTempView.swift
//  FinalProject
//
//  Created by Emma  Hopson on 10/26/23.
//

import SwiftUI

struct DebugTempView: View {
    @ObservedObject var timeViewModel = TimeViewModel()
    let lat: String
    let lng: String
    
    //let date: Date
    
    var pushNotificationService = PushNotificationService()
    
    
    var body: some View {
    
        
        ZStack(content: {
            Image("Earth")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            Rectangle()
                .colorInvert()
            .frame(height: 400)
                .opacity(0.70)
            VStack{
                
                if let existingLocationTimes = timeViewModel.locationTimes{
                    Text("Lat: \(lat), Long: \(lng)")
                    Text("Sunrise: \(existingLocationTimes.results.sunrise.basicTimeDate ?? Date.now)")
                    Text("Sunset: \(existingLocationTimes.results.sunset)")
                    Text("Solar Noon: \(existingLocationTimes.results.solar_noon)")
                    //Text("Day Length: \(existingLocationTimes.results.day_length)")
                    let date = existingLocationTimes.results.sunrise.basicTimeDate
                    Text("\(date ?? Date.now)")
                    
                    Group{
                        Text("Civil Twilight Start: \(existingLocationTimes.results.civil_twilight_begin)")
                        Text("Civil Twilight End: \(existingLocationTimes.results.civil_twilight_end)")
                        Text("Nautical Twilight Start: \(existingLocationTimes.results.nautical_twilight_begin)")
                        Text("Nautical Twilight End: \(existingLocationTimes.results.nautical_twilight_end)")
                        Text("Astronomical Twilight Start: \(existingLocationTimes.results.astronomical_twilight_begin)")
                        Text("Astronomical Twilight End: \(existingLocationTimes.results.astronomical_twilight_end)")
                    }
                    Spacer()
                        .frame(height: 20.0)
                    if let latitude = Double(lat), let longitude = Double(lng){
                        NavigationLink("Go to Map"){
                            MapView(lat: latitude, lng: longitude)
                        }
                    }
                    Spacer()
                        .frame(height: 20.0)
//                    Button("Set notification for sunrise"){
//                        pushNotificationService.scheduleNotification(coordinates: "\(lat), \(lng)", subtitle: "The sun will rise at \(existingLocationTimes.results.sunrise) today", time: existingLocationTimes.results.sunrise)
//                    }
//                    Button("Set notification for sunset"){
//                        pushNotificationService.scheduleNotification(coordinates: "\(lat), \(lng)", subtitle: "The sun will set at  \(existingLocationTimes.results.sunset) today", time: existingLocationTimes.results.sunset)
//                    }
                }else{
                    ZStack{
                        Rectangle()
                            .colorInvert()
                            .frame(height: 600)
                            .opacity(0.80)
                        VStack{
                            Text("ERROR: COULD NOT LOAD TIME DETAILS")
                                .foregroundColor(.red)
                            Text("Instead, please enjoy this meme that Brodie made of Emma back in January")
                                .frame(width: 300)
                            //Image("ErrorMeme")
                            Text("This is how Emma feels after breaking the entire API server :)")
                                .frame(width:300)
                        }
                    }
                }
                
            }
        })
        .onAppear {
            timeViewModel.getSunTimes(lat: lat, lng:lng)
        }
        .navigationTitle("")
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        
    }
}

//struct TimeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimeDetailView(timeViewModel: TimeViewModel)
//    }
//}

