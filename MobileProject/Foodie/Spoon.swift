//
//  Spoon.swift
//  Foodie
//
//  Created by Caitlin Rush on 2020-11-19.
//

import Foundation

struct SpoonResponse: Decodable {
    let spoons: [Spoon]
    
    private enum CodingKeys: String, CodingKey{
        case spoons = "results"
    }
}

struct Spoon: Decodable{
    let id: Int
    let title: String
    let image: String
    let summary: String
    let readyInMinutes: Int
    let servings: Int
    
    private enum CodingKeys: String, CodingKey{
        case id
        case title
        case image
        case summary
        case readyInMinutes
        case servings
    }
}



