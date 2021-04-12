//
//  AppClipView.swift
//  Foodie
//
//  Created by Caitlin Rush on 2020-12-03.
//

import SwiftUI

struct AppClipView: View {
    @ObservedObject var randomViewModel = RandomViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView{
            VStack{
                HStack{
                    Image("dish")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    Text("Recipe of the Day")
                        .bold()
                        .italic()
                        .font(.system(size: 25))
                        .foregroundColor(Color("lavender"))
                        .padding()
                        .cornerRadius(5.0)
                }
                Button(action: {
                    self.randomViewModel.getRandom()}){
                HStack {
                    Image(systemName: "circles.hexagongrid.fill")
                    Text("Go!")
                        }
                .accentColor(Color.black)
                .padding()
                .background(RoundedRectangle(cornerRadius: 15)
                    .opacity(0.4)
                    .foregroundColor(Color("lavender")))
                .cornerRadius(5.0)
            }
                ForEach(randomViewModel.recipes ?? [Recipe](), id: \.id){ recipe in
                    VStack{
                        Text(recipe.title)
                            .bold()
                            .padding()
                            .font(.headline)
                            .foregroundColor(Color("lavender"))
                        URLImage(url: recipe.image)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("lavender"), lineWidth: 4))
                                .shadow(radius: 10)
                            .frame(width: 225, height: 225)
                            
                        Text(recipe.instructions)
                            .italic()
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 15)
                                .opacity(0.2)
                                .foregroundColor(Color("lavender")))
                            .cornerRadius(5.0)
                            
                            .padding(10)
                        
                    }
                }
            }
            }
        
        }
}
}


struct AppClipView_Previews: PreviewProvider {
    static var previews: some View {
        AppClipView(randomViewModel: RandomViewModel())
    }
}
