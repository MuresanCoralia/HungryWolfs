//
//  Details.swift
//  HungryWolfs
//
//  Created by Wolfpack Digital on 18.08.2021.
//

import Foundation

struct Detail: Decodable 
{
    var name: String
    var tags: String?
    var youtube: String?
    var ingredient1: String?
    var ingredient2: String?
    var ingredient3: String?
    var measure1: String?
    var measure2: String?
    var measure3: String?
    var thumb: String
    var instructions: String
    var id: String

    public enum CodingKeys: String, CodingKey{
        case name = "strMeal"
        case tags = "strTags"
        case youtube = "strYoutube"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case measure1 = "strMeasure1"
        case measure2 = "strMeasure2"
        case measure3 = "strMeasure3"
        case thumb = "strMealThumb"
        case instructions = "strInstructions"
        case id = "idMeal"
    }
}

struct FoodDetails: Decodable
{
    let meals: [Detail]
}

