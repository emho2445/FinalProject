//
//  PinnedLocations.swift
//  FinalProject
//
//  Created by Emma  Hopson on 12/6/23.
//

import SwiftUI
import CoreLocation


struct PinnedLocationsView: View {
    var mapLocations: [CLLocationCoordinate2D]
    
    var body: some View {
        
        ScrollView{
            ZStack(content: {
                
                if let pinnedLocations = mapLocations{
                    List(pinnedLocations){ location in
                        Text(String(location))
                        
                    }
                }
                
                
                
            })
        }
    }
}
