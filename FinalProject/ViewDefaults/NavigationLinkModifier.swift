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
            .background(Color("Burnt"))
            .cornerRadius(10)
    }
}

struct PushNotificationAcceptLinkMod: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            //.padding()
            .frame(width: 225)
            .foregroundColor(.white)
            .background(Color("ButtonBlue2"))
            .cornerRadius(10)
    }
}

struct PushNotificationLinkModDisabled: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            //.padding()
            .frame(width: 225)
            .foregroundColor(.white)
            .background(Color("ButtonBlue"))
            .cornerRadius(10)
    }
}

struct PushNotificationLinkModEnabled: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            //.padding()
            .frame(width: 225)
            .foregroundColor(.white)
            .background(Color("ButtonBlue1"))
            .cornerRadius(10)
    }
}


extension View {
    func customNavigationLink() -> some View {
        modifier(NavigationLinkMod())
    }
    
    func pushNotificationAcceptLink() -> some View{
        modifier(PushNotificationAcceptLinkMod())
    }
    
    func pushNotificationLinkDisabled() -> some View{
        modifier(PushNotificationLinkModDisabled())
    }
    
    func pushNotificationLinkEnabled() -> some View{
        modifier(PushNotificationLinkModEnabled())
    }
}
