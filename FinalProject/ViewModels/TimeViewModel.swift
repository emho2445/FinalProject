//
//  TimeViewModel.swift
//  FinalProject
//
//  Created by Emma  Hopson on 10/24/23.
//

import Foundation

class TimeViewModel: ObservableObject {
    @Published var locationTimes: LocationTimes?
    
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
        }
    }
    
}
