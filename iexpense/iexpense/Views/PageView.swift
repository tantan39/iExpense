//
//  PageView.swift
//  iexpense
//
//  Created by Tan Tan on 4/28/22.
//

import Foundation
import SwiftUI
import Introspect

enum TabItem: Int, CaseIterable {
    case transaction
    case history
    
    var title: String {
        switch self {
        case .transaction:
            return "Transaction"
        case .history:
            return "History"
        }
    }
    
    var icon: String {
        switch self {
        case .transaction:
            return "note.text.badge.plus"
        case .history:
            return "list.bullet.rectangle.portrait"
        }
    }
}

struct PageView: View {
    @State private var tabSelection: TabItem = .transaction
    
    var body: some View {
        let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
        VStack {
            HStack {
                ForEach (TabItem.allCases, id: \.self) { tabItem in
                    MenuItemView(title: tabItem.title, icon: tabItem.icon, selected: .constant(tabSelection == tabItem)) {
                        tabSelection = tabItem
                    }
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                .padding(.trailing, 20)

            }

            TabView(selection: $tabSelection) {
                HomeView()
                    .tag(TabItem.transaction)
                ExpenseListView()
                    .tag(TabItem.history)
            }
            .introspectTabBarController(customize: { tabBarController in
                tabBarController.tabBar.isHidden = true
            })
            .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global).onEnded({ value in
                let horizontalAmount = value.translation.width as CGFloat
                let verticalAmount = value.translation.height as CGFloat
                
                if abs(horizontalAmount) > abs(verticalAmount) {
                    if horizontalAmount < 0 {
                        tabSelection = .history
                    } else {
                        tabSelection = .transaction
                    }
                } else {
                    print(verticalAmount < 0 ? "up swipe" : "down swipe")
                }
            }))
        }
    }
}

struct PageViewPreview_Provider: PreviewProvider {
    static var previews: some View {
        PageView()
    }
}
