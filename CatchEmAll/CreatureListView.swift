//
//  ContentView.swift
//  CatchEmAll
//
//  Created by Denilson Washuma on 24/06/2024.
//

import SwiftUI

struct CreatureListView: View {
    
    @StateObject var creaturesVM = CreatureListViewModel()
    
    @State private var searchText = ""
    var searchResults:[PokeMon] {
        if searchText.isEmpty{
            return creaturesVM.creaturesArray //just return everything
        }
        else{
            return creaturesVM.creaturesArray.filter{
                $0.name.contains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack{
            
            ZStack {
                // List(creaturesVM.creaturesArray,id: \.self) { creature in
                List(searchResults,id: \.self) { creature in //with search
                    
                    NavigationLink{
                        DetailView(creature:creature)
                    } label: {
                        Text("\(creature.name)")
                           // .font(.title2)
                    }
                    
                    
                }
                
                .listStyle(.plain)
                .navigationTitle("Pokemon")
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        
                        Text("\(creaturesVM.creaturesArray.count) of \(creaturesVM.count)")
                        
                    }
                }
                .searchable(text: $searchText)
                
                if creaturesVM.isFetching{
                    ProgressView()
                        .tint(.blue).scaleEffect(3)
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
