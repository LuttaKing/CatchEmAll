//
//  DetailViewModel.swift
//  CatchEmAll
//
//  Created by Denilson Washuma on 26/06/2024.
//

import Foundation


@MainActor
class DetailViewModel: ObservableObject {
    
    
    
    
    var urlString = ""
  
    // these struct variable have to be named exactly as the JSON sent from API
    private struct ReturnedData: Codable {
        //identicle to the Json we want to retrieve
        var height:Int
        var weight: Int
        var sprites: Sprite
        
        struct Sprite: Codable{
            var front_default:String
        }
        
    }
    
   
    
    @Published var height = 0
    @Published var weight = 0
    @Published var imageUrl = ""
   
    
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
            self.height = returned.height
            self.weight = returned.weight
            self.imageUrl = returned.sprites.front_default
           
            
        } catch {
            print("err")
        }
        
    }
    
}

