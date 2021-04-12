//
//  NewFavouriteRecipeView.swift
//  Foodie
//
//  Created by Pallavi Singla on 2020-12-09.
//

import SwiftUI

struct NewFavouriteRecipeView: View {
    @EnvironmentObject var recipeListViewModel: RecipeListViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var newMyRecipeTitle: String = ""
    @State private var newMyRecipeDescribe: String = ""
    
    
    
    var body: some View {
        VStack{
            VStack{
                Text("Add the recipes to your list")
                    .bold()
                    .font(.system(size: 25))
                    .foregroundColor(.red)
                Spacer()
                TextField("Title", text: $newMyRecipeTitle).padding()
                    .border(Color.orange, width: 3)
                TextField("Description", text: $newMyRecipeDescribe).padding()
                    .border(Color.orange, width: 3)
            }.frame(width: 350, height: 200)
            
            Button(action: {
                self.recipeListViewModel.insertmyRecipe(title: newMyRecipeTitle, ifFavourite: false, describe: newMyRecipeDescribe)
                self.presentationMode.wrappedValue.dismiss()
            }){
                HStack {
                    Image(systemName: "checkmark.seal.fill")
                    Text("Add My Recipe")
                        }
                .accentColor(Color.blue)
                .padding()
                .background(RoundedRectangle(cornerRadius: 15)
                    .opacity(0.2))
                .cornerRadius(5.0)
            }
        }
        
    }
}

struct NewFavouriteRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NewFavouriteRecipeView()
    }
}
