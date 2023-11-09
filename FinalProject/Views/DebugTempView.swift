//
//  DebugTempView.swift
//  FinalProject
//
//  Created by Emma  Hopson on 10/26/23.
//

import SwiftUI
import CoreLocation

//THIS VIEW WILL NOT BE IN THE FINAL PRODUCT. IT IS ONLY A STEPPING STONE TO GET CERTAIN DATA AND FUNCTIONS SET UP CORRECTLY. THEREFORE I WAS NOT CONCERNED WITH UI OR APPEARANCE, JUST FUNCTIONALITY

struct DetailsView: View {
    @ObservedObject var timeViewModel = TimeViewModel()
    @Environment(\.dismiss) var dismiss
    let lat: String
    let lng: String
    //let latlngCountry: String
    
    //let date: Date
    
    var pushNotificationService = PushNotificationService()
    var body: some View {
        
        
        ZStack(content: {
            VStack{
                
                
                Button("Allow Push Notifications"){
                    pushNotificationService.requestPermissions()
                    timeViewModel.changeNotificationPermissions()
                }.customNavigationLink()
                
                if let existingLocationTimes = timeViewModel.locationTimes{
                    Text(timeViewModel.latlngCountry ?? "No Country")
                        .font(.title)
                    if let sunrise = existingLocationTimes.results.sunrise.basicTimeDate{
                        Text("\(sunrise)")
                            .frame(maxWidth:350)
                            .foregroundColor(.black)
                        Button{
                            pushNotificationService.scheduleNotification(coordinates: "\(lat), \(lng)", subtitle: "The sun will rise at \(sunrise) today", time: sunrise)
                        } label:{
                            Text("Set notification for sunrise")
                        }.disabled(timeViewModel.notificationsDisabled)
                            .customNavigationLink()
                    }
                    if let sunset = existingLocationTimes.results.sunset.basicTimeDate{
                        Text("\(sunset)")
                            .frame(maxWidth:350)
                        Button("Set notification for sunset"){
                            pushNotificationService.scheduleNotification(coordinates: "\(lat), \(lng)", subtitle: "The sun will set at  \(sunset) today", time: sunset)
                        }.disabled(timeViewModel.notificationsDisabled)
                            .customNavigationLink()
                    }
                    
                    Spacer()
                        .frame(height:20)
                        
                    
                    Button("Close Sheet"){
                        dismiss()
                    }.foregroundColor(Color("Burnt"))
                    
                    
                    //                    Spacer()
                    //                        .frame(height: 20.0)
                    
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
        .padding()
        .foregroundColor(.black)
        .onAppear {
            timeViewModel.getSunTimes(lat: lat, lng:lng)
        }
    }
}

//struct TimeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimeDetailView(timeViewModel: TimeViewModel)
//    }
//}

