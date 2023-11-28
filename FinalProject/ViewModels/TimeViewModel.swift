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
    
    @MainActor
    func getSunTimes(lat: String, lng: String) -> () {
        Task {
            do {
                let url = URL(string: "https://api.sunrise-sunset.org/json?lat=\(lat)&lng=\(lng)&formatted=0")!
                let (data, _) = try await URLSession.shared.data(from: url)
                print("The data is \(data)")
                    locationTimes = try JSONDecoder().decode(LocationTimes.self, from: data)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
            
            reverseGeocoding(latitude: Double(lat) ?? 0.00, longitude: Double(lng) ?? 0.00)
            
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
        //https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400&date=2023-11-28
    
            do {
                let url = URL(string: "https://api.sunrise-sunset.org/json?lat=\(lat)&lng=\(lng)&date=\(date)&formatted=0")!
                let (data, _) = try await URLSession.shared.data(from: url)
                //print("The data is \(data)")
                    let locationTimes = try JSONDecoder().decode(LocationTimes.self, from: data)
                let futureSunrise = FutureSunrises(date: date, sunrise: locationTimes.results.sunrise)
                sunriseData.append(futureSunrise)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
    }
    
    func createSunriseData(lat: String, lng: String){
        Task{ @MainActor in
            for i in 0...10 {
                var chartDate = Date()
                let modifiedDate = Calendar.current.date(byAdding: .weekOfMonth, value: i, to: chartDate)!
                //print(modifiedDate)
                var dateString = modifiedDate.yearMonthDayTimeString
                //print(dateString)
                try await getYearSunrises(lat: lat, lng: lng, date: dateString)
            }
            for sunrise in sunriseData{
                print(sunrise)
            }
        }
    }
    
    
}
