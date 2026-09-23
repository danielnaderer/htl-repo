//
//  iPhoneView.swift
//  election_swift
//
//  Created by Daniel Naderer on 22.09.26.
//

import SwiftUI

struct iPhoneView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Election")
                .font(.largeTitle)
                .bold()

            Text("iPhone Layout")

            Button("Abstimmen") {
                print("Abgestimmt")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()

    }
}

#Preview {
    iPhoneView()
}
