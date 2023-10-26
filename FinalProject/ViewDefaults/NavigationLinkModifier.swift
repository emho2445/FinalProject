//
//  NavigationLinkModifier.swift
//  FinalProject
//
//  Created by Emma  Hopson on 10/24/23.
//

import Foundation
import SwiftUI

struct NavigationLinkMod: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: 250)
            .foregroundColor(.white)
            .background(Color("ButtonBlue"))
            .cornerRadius(10)
    }
}


extension View {
    func customNavigationLink() -> some View {
        modifier(NavigationLinkMod())
    }
}
