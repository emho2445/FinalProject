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
    @State var graphAppear = false
    
    @State var pageLoaded = false
    @State var appearCount = 0
    //let latlngCountry: String
    
    //let date: Date
    
    var pushNotificationService = PushNotificationService()
    var body: some View {
        
        ScrollView{
            ZStack(content: {
                VStack{
                    
                    //This is for debugging the data array. Will be deleting for final product
                    Text("Array Length: \(timeViewModel.sunriseData.count)")
                    
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
                        
                        Text("NOTE FOR THIS IN-PROGRESS APP: The chart data takes a while to load so please wait until you see the data print to the console in xCode or wait at least 10 seconds after opening the sheet before clicking 'Generate Graph'")
                        
                        Button("Generate Graph"){
                            //timeViewModel.createSunriseData(lat: lat, lng: lng)
                            graphAppear = true
                        }.customNavigationLink()
                        
                        
                        
                        if graphAppear == true{
                            if timeViewModel.sunriseData.isEmpty{
                                Text("Loading Graph")
                            }else{
                                Text("Future Sunrise Times (in user's time)")
                                GraphView(graphData: timeViewModel.sunriseData)
                            }
                        }
                        
                        
                        //GraphView(graphData: timeViewModel.sunriseData)
                        
                        
                        Button("Close Sheet"){
                            dismiss()
                            graphAppear = false
                        }.foregroundColor(Color("Burnt"))
                        
                        
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
            .onAppear(perform: onLoad)
        }
    }
    
    func onLoad(){
        if pageLoaded == false {
            appearCount += 1
            timeViewModel.getSunTimes(lat: lat, lng: lng)
            timeViewModel.createSunriseData(lat: lat, lng: lng)
        }
        pageLoaded = true
    }
}

//struct TimeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimeDetailView(timeViewModel: TimeViewModel)
//    }
//}

