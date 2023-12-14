//
//  GraphView.swift
//  FinalProject
//
//  Created by Emma  Hopson on 11/27/23.
//

import Foundation
import SwiftUI
import Charts

struct GraphView: View {
    let graphData: [FutureSunrises]
    
    var maxGraphData: FutureSunrises?{
        graphData.max { $0.sunrise < $1.sunrise}
    }
    
    var minGraphData: FutureSunrises?{
        graphData.min { $0.sunrise > $1.sunrise}
    }
    
    
    
    var body: some View {
        
        VStack{
            Chart{
                ForEach (graphData) { dataPoint in
                    LineMark(x: .value("Date", dataPoint.date), 
                             y: .value("Time", dataPoint.sunrise))
                    .symbol(){
                        Circle()
                            .fill(.red)
                            .frame(width: 7, height: 7)
                    }
                    .foregroundStyle(.orange)
                    
                }
                
                
                //BarMark(x: .value("Date", "\(Date.now)"), y: .value("Time", "\(Date.now)"))
            }
            .chartXScale(domain: graphData[0].date...graphData[graphData.count-1].date)
            .chartYAxis {
                AxisMarks(values: .automatic(desiredCount: 6))
            }
            .chartXAxis{
                AxisMarks(values: .stride(by: .month)) { _ in
                       AxisValueLabel(format: .dateTime.month())
                        AxisGridLine()
                   }
            }
            //.chartYScale(domain: graphData.sunrise.min()...graphData.sunrise.max())
            .aspectRatio(1, contentMode: .fit)
            .padding()
            
        }
            
    }
}
