//
//  Candidate.swift
//  election_swift
//

import Foundation

struct Candidate: Identifiable {
    let id = UUID()
    var name: String
    var votes: Int
}
