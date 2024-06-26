//
//  ContentView.swift
//  CatchEmAll
//
//  Created by Denilson Washuma on 24/06/2024.
//

import SwiftUI

struct CreatureListView: View {
    
    @StateObject var creaturesVM = CreatureListViewModel()
    
    var body: some View {
        NavigationStack{
           // List(creaturesVM.creaturesArray,id: \.self) { creature in
            List(0..<creaturesVM.creaturesArray.count,id: \.self) { index in
               
                NavigationLink{
                    DetailView(creature: creaturesVM.creaturesArray[index])
                } label: {
                    Text("\(index). \(creaturesVM.creaturesArray[index].name)")
                        .font(.title2)
                }
                
              
            }
            
            .listStyle(.plain)
            .navigationTitle("Pokemon")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    
                    Text("\(creaturesVM.creaturesArray.count) of \(creaturesVM.count)")
                    
                }
            }
        }
        .task {
            await creaturesVM.fetchData()
        }
    }
}

#Preview {
    CreatureListView()
}
