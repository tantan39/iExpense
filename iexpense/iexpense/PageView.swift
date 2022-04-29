//
//  PageView.swift
//  iexpense
//
//  Created by Tan Tan on 4/28/22.
//

import Foundation
import SwiftUI

struct PageView: View {
    var body: some View {
        TabView {
            HomeView()
            ExpenseListView()
        }
        .tabViewStyle(.page)
    }
}

struct PageViewPreview_Provider: PreviewProvider {
    static var previews: some View {
        PageView()
    }
}
