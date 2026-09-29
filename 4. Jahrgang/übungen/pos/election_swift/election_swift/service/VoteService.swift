//
//  VoteService.swift
//  election_swift
//
//  Created by Daniel Naderer on 28.09.26.
//

import Foundation

final class VoteService {
    public var candidateList: [Candidate] = [
        Candidate(name: "Kandidat 1", votes: 0),
        Candidate(name: "Kandidat 2", votes: 0),
        Candidate(name: "Kandidat 3", votes: 0),
    ]
    
    func getCandidates() -> [Candidate] {
        return candidateList
    }
    
    func removeCandidate(id: UUID) -> Bool {
        guard let index = candidateList.firstIndex(where: { $0.id == id }) else {
            return false
        }

        candidateList.remove(at: index)
        return true
    }
    
    func addCandidate(candidate: Candidate) -> Bool {
        if candidate.name.isEmpty {
            return false
        }
        
        candidateList.append(candidate)
        return true
    }
    
    func vote(for id: UUID, type: String) -> Bool {
        guard let index = candidateList.firstIndex(where: { $0.id == id }) else {
            return false
        }
        
        if (type == "1st") {
            candidateList[index].votes += 2
        } else if (type == "2nd") {
            candidateList[index].votes += 1
        }
        
        return true
    }
}
