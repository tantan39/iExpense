//
//  ContentView.swift
//  iexpense
//
//  Created by Tan Tan on 4/27/22.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        PageView()
            .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
