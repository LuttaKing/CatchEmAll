//
//  CreatureViewModel.swift
//  CatchEmAll
//
//  Created by Denilson Washuma on 24/06/2024.
//

import Foundation

@MainActor
class CreatureListViewModel: ObservableObject {
    
  
    
    private struct ReturnedData: Codable {
        //identicle to the Json we want to retrieve
        var count: Int
        var next: String
        var results:[PokeMon]
        
    }
    
    @Published var urlString: String = "https://pokeapi.co/api/v2/pokemon"
    @Published var count = 0 //published means it will emit a value when shit changes
    @Published var creaturesArray:[PokeMon] = []
    @Published var isFetching = false
    
    func fetchData() async {
        
        isFetching = true
        
        guard let url = URL(string: urlString)  else { print("Could not create url")
            isFetching = false
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let returned = try? JSONDecoder().decode(ReturnedData.self ,from: data) else {
                isFetching = false
                print("Could not decode Json Data")
                return
            }
            self.count = returned.count
            self.urlString = returned.next
            self.creaturesArray = returned.results
            
            isFetching = false
            
            
            
        } catch {
            isFetching = false
            print("err")
        }
        
    }
    
}
