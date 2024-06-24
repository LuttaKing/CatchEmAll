//
//  CreatureViewModel.swift
//  CatchEmAll
//
//  Created by Denilson Washuma on 24/06/2024.
//

import Foundation

class CreatureViewModel: ObservableObject {
    
    struct Resul: Codable, Hashable { // VERY Important, JSON values are Codable. i.e they use encode and decode
        // Hashable is to allow iteration like with for each
        var name: String
        var url: String
    }
    
    private struct ReturnedData: Codable {
        //identicle to the Json we want to retrieve
        var count: Int
        var next: String
        var results:[Resul]
        
    }
    
    @Published var urlString: String = "https://pokeapi.co/api/v2/pokemon"
    @Published var count = 0
    @Published var creaturesArray:[Resul] = []
    
    func fetchData() async {
        
        
        //convert string to url type
        guard let url = URL(string: urlString)  else { print("Could not create url")
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let returned = try? JSONDecoder().decode(ReturnedData.self ,from: data) else {
                print("Could not decode Json Data")
                return
            }
            self.count = returned.count
            self.urlString = returned.next
            self.creaturesArray = returned.results
            
        //    print("Nice JSON: count: \(returned.count), next: \(returned.next)")
            
            
        } catch {
            print("err")
        }
        
    }
    
}
