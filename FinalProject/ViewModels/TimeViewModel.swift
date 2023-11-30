//
//  TimeViewModel.swift
//  FinalProject
//
//  Created by Emma  Hopson on 10/24/23.
//

import Foundation
import MapKit
import CoreLocation

class TimeViewModel: ObservableObject {
    @Published var locationTimes: LocationTimes?
    @Published var notificationsDisabled: Bool = true
    @Published var latlngCountry: String?
    var sunriseData: [FutureSunrises] = []
    var dataLoaded = false
    
    
    @MainActor
    func getSunTimes(lat: String, lng: String) -> () {
        Task {
            do {
                let url = URL(string: "https://api.sunrise-sunset.org/json?lat=\(lat)&lng=\(lng)&formatted=0")!
                let (data, _) = try await URLSession.shared.data(from: url)
                print("The data is \(data)")
                locationTimes = try JSONDecoder().decode(LocationTimes.self, from: data)
                
                
                //print(sunriseData)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
            
            reverseGeocoding(latitude: Double(lat) ?? 0.00, longitude: Double(lng) ?? 0.00)
            //createSunriseData(lat: lat, lng: lng)
            //print("after array built")
            
        }
    }
    
    func changeNotificationPermissions(){
        notificationsDisabled = false
    }
    
    func reverseGeocoding(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geocoder.reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                print("Failed to retrieve address")
                return
            }
            
            if let placemarks = placemarks, let placemark = placemarks.first {
                //print(placemark.country!)
                if let country = placemark.country{
                    self.latlngCountry = country
                }
                
                if let ocean = placemark.ocean{
                    self.latlngCountry = ocean
                }
                
            }
            else
            {
                print("No Matching Address Found")
            }
        })
    }
    
    func getYearSunrises(lat: String, lng: String, date: String)async throws{
        var isInArray = false
        
        for sunrise in sunriseData {
            if sunrise.date.yearMonthDayTimeString == date{
                print("Second Entry of \(date)")
                isInArray = true
            }
        }
        
        if isInArray == false{
            do {
                let url = URL(string: "https://api.sunrise-sunset.org/json?lat=\(lat)&lng=\(lng)&date=\(date)&formatted=0")!
                let (data, _) = try await URLSession.shared.data(from: url)
                //print("The data is \(data)")
                let locationTimes = try JSONDecoder().decode(LocationTimes.self, from: data)
                
                let sunriseComponents = locationTimes.results.sunrise.split(separator: "T")
                let sunriseTimeComponent = sunriseComponents[1]
                
                if let dayDate = date.yearMonthDayTimeDate, let timeDate = String(sunriseTimeComponent).hourMinuteTimeDate{
                    
                    let futureSunrise = FutureSunrises(date: dayDate, sunrise: timeDate)
                    sunriseData.append(futureSunrise)
                }
                
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }else{
            print("Error Caught and \(date) not added again")
        }
        
     
    }
    
    
    func createSunriseData(lat: String, lng: String){
        Task{ @MainActor in
            for i in 0...15 {
                var chartDate = Date()
                let modifiedDate = Calendar.current.date(byAdding: .weekOfMonth, value: i, to: chartDate)!
                //print(modifiedDate)
                var dateString = modifiedDate.yearMonthDayTimeString
                //print(dateString)
                try await getYearSunrises(lat: lat, lng: lng, date: dateString)
            }
            dataLoaded = true
            for sunrise in sunriseData{
                print(sunrise)
                //                var dateSunrise = sunrise.sunrise.basicTimeDate
                //                var stringSunrise = dateSunrise?.basicTimeString
                //                print(dateSunrise ?? "")
                //                print(stringSunrise ?? "")
            }
        }
    }
    
    
}
