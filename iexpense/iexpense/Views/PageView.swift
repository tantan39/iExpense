//
//  PageView.swift
//  iexpense
//
//  Created by Tan Tan on 4/28/22.
//

import Foundation
import SwiftUI
import Introspect

struct MenuItemView: View {
    @State var title: String
    @State var icon: String
    @State var enable: Bool = false
    var onClick: (() -> Void)?
    
    var body: some View {
        Button {
//            onClick?()
            enable.toggle()
        } label: {
            HStack {
                Image(systemName: icon)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding()
                if enable {
                    Text(title)
//                        .animation(.default).transition(AnyTransition.opacity.animation(.interactiveSpring()))
//                        .padding(.trailing, 10)
                        .offset(x: -10, y: 0)
                }
            }
            .background(RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.gray))
            .animation(.default, value: enable)

        }

    }
}

struct MenuItemViewPreview_Provider: PreviewProvider {
    static var previews: some View {
        MenuItemView(title: "Transaction", icon: "note.text.badge.plus", onClick: { })
    }
}

enum TabItem: Int {
    case transaction
    case history
}


struct PageView: View {
    @State private var tabSelection: TabItem = .transaction
    
    var body: some View {
        let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
        VStack {
            HStack {
//                MenuItemView(title: "Transaction", icon: "note.text.badge.plus") {
//                    tabSelection = 1
//                }
                
//                MenuItemView(title: "Transaction", icon: "note.text.badge.plus") {
//                    tabSelection = 1
//                }
                
                Button {
                    tabSelection = .transaction
                } label: {
                    HStack {
                        Image(systemName: "note.text.badge.plus")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding()
                        if tabSelection == .transaction {
                            Text("Transaction")
                                .offset(x: -12, y: 0)
                        }
                    }
                }
                .background(RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.gray))
                .animation(.default, value: tabSelection)

                Button {
                    tabSelection = .history
                } label: {
                    HStack {
                        Image(systemName: "list.bullet.rectangle.portrait")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding()
                        if tabSelection == .history {
                            Text("History")
                                .offset(x: -12, y: 0)
                        }
                    }
                }
                .background(RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.gray))
                .padding(.leading, 20)
                .animation(.default, value: tabSelection)

                
                Spacer()

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
