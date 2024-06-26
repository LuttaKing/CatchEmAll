//
//  DetailView.swift
//  CatchEmAll
//
//  Created by Denilson Washuma on 26/06/2024.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var detailVM = DetailViewModel()
    var creature: PokeMon
    
    var body: some View {
        VStack(alignment:.leading,spacing: 3) {
            Text(creature.name)
                .font(Font.custom("Font Name", size: 50))
                .bold()
                .minimumScaleFactor(0.5)
            
            Rectangle()
                .frame(height: 1)
                .padding(.bottom)
            
            HStack{
                AsyncImage(url: URL(string: detailVM.imageUrl)) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                }
                .background(.white)
                .frame(maxHeight: 96)
                .cornerRadius(16)
                .shadow(radius: 16, x: 5, y: 5)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.gray,lineWidth: 1)
                }

                    
              
                
                VStack {
                    HStack(alignment: .top){
                        Text("Height:")
                            .font(.title3)
                            .foregroundStyle(.red)
                        
                        Text("\(detailVM.height)")
                            .font(.title3)
                            .bold()
                    }
                    HStack(alignment: .top){
                        Text("Weight:")
                            .font(.title3)
                            .foregroundStyle(.red)
                        
                        Text("\(detailVM.weight)")
                            .font(.title3)
                            .bold()
                    }
                }
                
                
            }
            Spacer()
        }
        .padding()
        .task {
            
            //update url in DetailVM
        
            
            detailVM.urlString = creature.url
            await detailVM.fetchData()
        }
    }
}

#Preview {
    DetailView(creature: PokeMon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"))
}
