//
//  SpoonViewModel.swift
//  Foodie
//
//  Created by Caitlin Rush on 2020-11-19.
//

import Foundation

class SpoonStore: ObservableObject {
    @Published var spoons: [Spoon]? = [Spoon]()
    var query: String = ""
    
    func getAll(query: String){
        
        guard let url = URL(string: "https://api.spoonacular.com/recipes/complexSearch?query=\(query)&apiKey=80c96019ec244713b6ffd91740193040&instructionsRequired=true&addRecipeNutrition=true&number=20") else {
            fatalError("Invalid URL")
        }
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data = data, error == nil else{
                return
            }
            
            let spoonResponse = try? JSONDecoder().decode(SpoonResponse.self, from: data)
            if let spoonResponse = spoonResponse {
                DispatchQueue.main.async{
                    self.spoons = spoonResponse.spoons
                }
                
            }
            
        }.resume()
    }
    
}
    
    
   
