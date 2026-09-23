//
//  Kandidate.swift
//  election_swift
//
//  Created by Daniel Naderer on 23.09.26.
//

import Foundation

struct Candidate: Identifiable {
    let id = UUID()
    var name: String
    var active: Bool
}
