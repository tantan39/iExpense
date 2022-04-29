//
//  MainButtonStyle.swift
//  iexpense
//
//  Created by Tan Tan on 4/29/22.
//

import SwiftUI

struct MainButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    MyButtonStyleView(configuration: configuration)
  }
}

private extension MainButtonStyle {
  struct MyButtonStyleView: View {

    @Environment(\.isEnabled) var isEnabled
    let configuration: MainButtonStyle.Configuration

    var body: some View {
      return configuration.label
        .foregroundColor(.white)
        .background(RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(isEnabled ? Color.accentColor : .gray.opacity(0.5))
        )
        .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
  }
}
