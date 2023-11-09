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
            
            //potential reverse geocoding function
            
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
                        self.latlngCountry = placemark.country
                    }
                    
                    if let ocean = placemark.ocean{
                        self.latlngCountry = placemark.ocean
                    }

                }
                else
                {
                    print("No Matching Address Found")
                }
            })
        }
    
    
}
