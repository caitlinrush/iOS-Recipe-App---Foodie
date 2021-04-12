//
//  WidgetViewModel.swift
//  Foodie
//
//  Created by Caitlin Rush on 2020-12-03.
//

import Foundation
import WidgetKit

public class WidgetViewModel: ObservableObject{
    @Published var recipes: [Recipe]? = [Recipe]()
    
    func getRandom(){
        guard let url = URL(string: "https://api.spoonacular.com/recipes/random?number=1&apiKey=80c96019ec244713b6ffd91740193040") else {
            fatalError("Invalid Url")
        }
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data = data, error == nil else{
             return
            }
            
            let randomResponse = try? JSONDecoder().decode(RandomResponse.self, from: data)
            if let randomResponse = randomResponse {
                DispatchQueue.main.async {
                    self.recipes = randomResponse.recipes
                }
            }
        }.resume()
        WidgetCenter.shared.reloadTimelines(ofKind: "RandomRecipeWidget")
    }
}
