//
//  PageView.swift
//  iexpense
//
//  Created by Tan Tan on 4/28/22.
//

import Foundation
import SwiftUI
import Introspect

struct PageView: View {
    @State private var tabSelection = 1
    
    var body: some View {
        let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
        
        TabView(selection: $tabSelection) {
            HomeView()
                .tag(1)
            ExpenseListView()
                .tag(2)
        }
        .introspectTabBarController(customize: { tabBarController in
            tabBarController.tabBar.isHidden = true
        })
        .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global).onEnded({ value in
            let horizontalAmount = value.translation.width as CGFloat
            let verticalAmount = value.translation.height as CGFloat
            
            if abs(horizontalAmount) > abs(verticalAmount) {
                if horizontalAmount < 0 {
                    tabSelection = 2
                } else {
                    tabSelection = 1
                }
            } else {
                print(verticalAmount < 0 ? "up swipe" : "down swipe")
            }
        }))

    }
}

struct PageViewPreview_Provider: PreviewProvider {
    static var previews: some View {
        PageView()
    }
}
