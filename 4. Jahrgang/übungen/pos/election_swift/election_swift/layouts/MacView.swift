//
//  MacView.swift
//  election_swift
//
//  Created by Daniel Naderer on 22.09.26.
//

import SwiftUI

struct MacView: View {
    @State private var kandidateList: [Candidate] = [
        Candidate(name: "Kandidat 1", active: false),
        Candidate(name: "Kandidat 2", active: false),
        Candidate(name: "Kandidat 3", active: false)
    ]
    @State private var k1c = false  // temp
    
    @FocusState private var focusedField: UUID?
    @State private var selectedCandidate: UUID?
    
    var body: some View {
        ZStack {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    focusedField = nil
                }
            VStack {
                Text("Election")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                VStack(spacing: -15) {
                    ForEach($kandidateList) { $candidate in
                        HStack {
                            ZStack(alignment: .trailing) {
                                TextField("Name eingeben", text: $candidate.name)
                                    .textFieldStyle(.roundedBorder)
                                    .frame(width: 200)
                                    .focused($focusedField, equals: candidate.id)
                                    .onTapGesture {
                                        selectedCandidate = candidate.id
                                    }
                                
                                Image(systemName: "square.and.pencil")
                                    .foregroundStyle(.secondary)
                                    .padding(.trailing, 8)
                                    .allowsHitTesting(false)
                            }
                            
                            Toggle("", isOn: $candidate.active)
                                .labelsHidden()
                            
                            Toggle("", isOn: $k1c)
                                .labelsHidden()
                        }
                        .padding()
                    }
                }
                
                Spacer()
                
                if let selectedCandidate {
                    Button {
                        focusedField = nil
                        kandidateList.removeAll { $0.id == selectedCandidate }
                        self.selectedCandidate = nil
                    } label: {
                        Image(systemName: "minus")
                            .font(.title2)
                            .frame(width: 20, height: 20)
                    }
                } else {
                    Button {
                        kandidateList.append(
                            Candidate(name: "Kandidat", active: false)
                        )
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                            .frame(width: 20, height: 20)
                    }
                }
                
            }
            .frame(width: 500, height: 300)
            .padding()
        }
    }
}

#Preview {
    MacView()
}
