//
//  DebugTempView.swift
//  FinalProject
//
//  Created by Emma  Hopson on 10/26/23.
//

import SwiftUI
import CoreLocation


struct DetailsView: View {
    @ObservedObject var timeViewModel = TimeViewModel()
    @Environment(\.dismiss) var dismiss
    let lat: String
    let lng: String
    
    // For controlling if the generate graph button is clicked
    @State var graphAppear = false
    
    // For keeping track of when the page loads
    @State var pageLoaded = false
    @State var appearCount = 0
    
    //Push notifications
     @ObservedObject var pushNotificationService: PushNotificationService

    
    
    var body: some View {
        
        ScrollView{
            ZStack(content: {
                VStack{
                    
                    //This logic is just for debugging and will be deleted in Week 7 for the final product
                    if pushNotificationService.isPermissionGranted == false{
                        Text("Permissions are not granted")
                    }else{
                        Text("Permissions are granted")
                    }
                    
                    Spacer()
                        .frame(height: 70)
                    
                    if let existingLocationTimes = timeViewModel.locationTimes{
                        Text(timeViewModel.latlngCountry ?? "No Country")
                            .font(.title)
                        
                        Spacer()
                            .frame(height: 30)
                        
                        if let sunrise = existingLocationTimes.results.sunrise.basicTimeDate{
                            Text("\(sunrise)")
                                .frame(maxWidth:350)
                                .foregroundColor(.black)
                            
                            Button{
                                pushNotificationService.scheduleNotification(coordinates: "\(lat), \(lng)", subtitle: "The sun will rise at \(sunrise) today", time: sunrise)
                            } label:{
                                if pushNotificationService.isPermissionGranted == false{
                                    Text("Set notification for sunrise")
                                        .pushNotificationLinkDisabled()
                                }else{
                                    Text("Set notification for sunrise")
                                        .pushNotificationLinkEnabled()
                                }
                                
                            }.disabled(!pushNotificationService.isPermissionGranted)
                            
                        }
                        
                        Spacer()
                            .frame(height: 20)
                        
                        if let sunset = existingLocationTimes.results.sunset.basicTimeDate{
                            Text("\(sunset)")
                                .frame(maxWidth:350)
                            Button{
                                pushNotificationService.scheduleNotification(coordinates: "\(lat), \(lng)", subtitle: "The sun will set at  \(sunset) today", time: sunset)
                            }label: {
                                if pushNotificationService.isPermissionGranted == false{
                                    Text("Set notification for sunset")
                                        .pushNotificationLinkDisabled()
                                }else{
                                    Text("Set notification for sunset")
                                        .pushNotificationLinkEnabled()
                                }
                            }.disabled(!pushNotificationService.isPermissionGranted)
                        }
                        
                        Spacer()
                            .frame(height:30)
                        
                        Button{
                            graphAppear = true
                        } label: {
                            Text("Generate Graph")
                                .customNavigationLink()
                        }
                        
                        
                        
                        
                        if graphAppear == true{
                            
                            if timeViewModel.dataLoaded == false{
                                Text("Loading Graph Data...")
                                    .foregroundStyle(.blue)
                                
                            }else{
                                Text("Future Sunrise Times (in user's time)")
                                GraphView(graphData: timeViewModel.sunriseData)
                            }
                        }
                        
                        
                        Spacer()
                            .frame(height: 100)
                        
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
                                Text("Loading Data. Please wait....")
                                    .foregroundColor(.red)
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

