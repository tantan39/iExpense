//
//  DatePickerButtonView.swift
//  iexpense
//
//  Created by Tan Tan on 4/29/22.
//

import SwiftUI

struct DatePickerButtonView: View {
    @Binding var date: Date
    
    var body: some View {
        ZStack {
            DatePicker("label", selection: $date, in: ...Date(), displayedComponents: [.date])
                .datePickerStyle(CompactDatePickerStyle())
                .labelsHidden()
            Image(systemName: "calendar")
                .resizable()
                .frame(width: 35, height: 35, alignment: .center)
                .userInteractionDisabled()
        }
    }
}

struct NoHitTesting: ViewModifier {
    func body(content: Content) -> some View {
        SwiftUIWrapper { content }.allowsHitTesting(false)
    }
}

extension View {
    func userInteractionDisabled() -> some View {
        self.modifier(NoHitTesting())
    }
}

struct SwiftUIWrapper<T: View>: UIViewControllerRepresentable {
    let content: () -> T
    func makeUIViewController(context: Context) -> UIHostingController<T> {
        UIHostingController(rootView: content())
    }
    func updateUIViewController(_ uiViewController: UIHostingController<T>, context: Context) {}
}
