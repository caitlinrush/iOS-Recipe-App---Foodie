//
//  NewRecipeView.swift
//  Foodie
//
//  Created by Pallavi Singla on 2020-11-12.
//

import SwiftUI

struct NewRecipeView: View {
    @EnvironmentObject var recipeListViewModel: RecipeListViewModel
    @State private var isPresented: Bool = false
    @State private var selectedIndex : Int? = nil
    
    var body: some View {
        NavigationView{
            VStack{
                List {
                    ForEach(self.recipeListViewModel.myRecipeList.enumerated().map({$0}), id: \.element.self){idx, myRecipe in
                        HStack{
                            VStack(alignment: .leading){
                                Text("\(myRecipe.title!)")
                                    .bold()
                                Text("\(myRecipe.describe!)").font(.system(size: 14))
                                    .italic()
                                   
                            }
                            Spacer()
                            if (myRecipe.ifFavourite){
                                Image(systemName: "heart.fill").foregroundColor(.red)
                            }
                            
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15)
                            .opacity(0.2))
                        .onTapGesture {
                            print("tapped")
                            myRecipe.ifFavourite = !myRecipe.ifFavourite
                            self.recipeListViewModel.myRecipeList[idx] = myRecipe
                            
                            self.recipeListViewModel.updateMyRecipe()
                        }
                        
                    }
                    .onDelete{(indexSet) in
                        for index in indexSet{
                            let myRecipeid = self.recipeListViewModel.myRecipeList[index].id
                            self.recipeListViewModel.deleteMyRecipeByID(myRecipeID: myRecipeid!)
                        }
                    }
                }
            }
            .navigationBarTitle("Your Recipes", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action:{
                                        self.isPresented = true
                                    }){
                                        Image(systemName: "plus")
                                            .resizable()
                                            .padding()
                                    }.sheet(isPresented: self.$isPresented){
                                        NewFavouriteRecipeView()
                                    }
            )
        }.onAppear(){
            self.recipeListViewModel.getAllMyRecipes()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct NewRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipeView()
            .environment(\.locale, .init(identifier: "fr"))
    }
}
