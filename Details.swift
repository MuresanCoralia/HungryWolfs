//
//  Details.swift
//  HungryWolfs
//
//  Created by Wolfpack Digital on 18.08.2021.
//

import Foundation

struct Detail: Decodable 
{
    var strMeal: String
    var strTags: String?
    var strYoutube: String?
    var strIngredient1: String?
    var strIngredient2: String?
    var strIngredient3: String?
    var strMeasure1: String?
    var strMeasure2: String?
    var strMeasure3: String?
    var strMealThumb: String
    var strInstructions: String
    var idMeal: String

}

struct FoodDetails: Decodable
{
    let meals: [Detail]
}

