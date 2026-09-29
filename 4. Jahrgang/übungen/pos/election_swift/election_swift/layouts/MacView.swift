//
//  MacView.swift
//  election_swift
//

import SwiftUI

struct MacView: View {
    private let voteService: VoteService
    @State private var candidateList: [Candidate]
    
    func loadCandidates() {
        self.candidateList = voteService.getCandidates()
    }
    
    init() {
        let voteService = VoteService()
        self.voteService = voteService
        self._candidateList = State(initialValue: voteService.getCandidates())
    }
    
    @FocusState private var focusedField: UUID?
    @State private var selectedCandidate: UUID?

    var body: some View {
        ZStack {
            VStack {
                Text("Election")
                    .font(.largeTitle)
                    .bold()

                Spacer()

                VStack(spacing: -15) {
                    ForEach($candidateList) { $candidate in
                        HStack {
                            ZStack(alignment: .trailing) {
                                TextField(
                                    "Name eingeben",
                                    text: $candidate.name
                                )
                                .textFieldStyle(.roundedBorder)
                                .frame(width: 200)
                                .focused($focusedField, equals: candidate.id)
                                .simultaneousGesture(
                                    TapGesture().onEnded {
                                        selectedCandidate = candidate.id
                                    }
                                )

                                Image(systemName: "square.and.pencil")
                                    .foregroundStyle(.secondary)
                                    .padding(.trailing, 8)
                                    .allowsHitTesting(false)
                            }

                            Button {
                                // TODO: was wenn stimme für Schulsprecher
                            } label: {
                                Text("1st")
                            }

                            Button {
                                // TODO: was wenn Stimme für Vertretung
                            } label: {
                                Text("2nd")
                            }
                        }
                        .padding()
                    }
                }

                if let selectedCandidate {
                    Button {
                        let candidateID = selectedCandidate
                        focusedField = nil
                        self.selectedCandidate = nil

                        // --------------------------------------
                        // Code in dieser Box ist AI weil kp wie ich Index out of range error fixe
                        
                        Task { @MainActor in
                            // Let AppKit finish ending the text field edit before
                            // removing its index-backed SwiftUI binding.
                            await Task.yield()
                            let removeCandidateSuccess = voteService.removeCandidate(id: candidateID)
                            self.loadCandidates()
                        }
                        // --------------------------------------
                    } label: {
                        Image(systemName: "minus")
                            .font(.title2)
                            .frame(width: 20, height: 20)
                    }
                } else {
                    Button {
                        let addCandidateSuccess = voteService.addCandidate(candidate: Candidate(name: "Kandidat", votes: 0))
                        self.loadCandidates()
                        
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                            .frame(width: 20, height: 20)
                    }
                }

                Spacer()
            }
            .frame(width: 500, height: 300)
            .padding()
        }
    }
    

}

#Preview {
    MacView()
}
