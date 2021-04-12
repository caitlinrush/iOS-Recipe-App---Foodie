//
//  RandomSpoon.swift
//  Foodie
//
//  Created by Caitlin Rush on 2020-12-03.
//

import Foundation

struct RandomResponse: Decodable{
    let recipes: [Recipe]
    
    private enum CodingKeys: String, CodingKey{
        case recipes
    }
}

struct Recipe: Decodable{
    let id: Int
    let title: String
    let image: String
    let instructions: String
    
    private enum CodingKeys: String, CodingKey{
        case id
        case title
        case image
        case instructions
    }
}
