//
//  ContentView.swift
//  CatchEmAll
//
//  Created by Denilson Washuma on 24/06/2024.
//

import SwiftUI

struct CreatureListView: View {
    
    @StateObject var creaturesVM = CreatureViewModel()
    
    var body: some View {
        NavigationStack{
            List(creaturesVM.creaturesArray,id: \.self) { creature in
                Text(creature.name)
                    .font(.title2)
            }
            
            .listStyle(.plain)
            .navigationTitle("Pokemon")
        }
        .task {
            await creaturesVM.fetchData()
        }
    }
}

#Preview {
    CreatureListView()
}
