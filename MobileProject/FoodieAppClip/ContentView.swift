//
//  ContentView.swift
//  FoodieAppClip
//
//  Created by Caitlin Rush on 2020-12-03.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var randomViewModel = RandomViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView{
            VStack{
            Text("Recipe of the Day")
            Button(action: {
                    self.randomViewModel.getRandom()}){
                Text("Go!")
                
            }
                ForEach(randomViewModel.recipes ?? [Recipe](), id: \.id){ recipe in
                    VStack{
                        Text(recipe.title)
                            .bold()
                            .padding()
                            .font(.headline)
                        URLImage(url: recipe.image)
                            .frame(width: 200, height: 270)
                        Text(recipe.instructions)
                            .italic()
                            .padding()
                        
                        
                    }
                }
            }
            }
        
        }
}
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(randomViewModel: RandomViewModel())
    }
}
