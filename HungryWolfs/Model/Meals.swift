//
//  Meals.swift
//  HungryWolfs
//
//  Created by Wolfpack Digital on 12.08.2021.
//

import Foundation

public struct Meal: Decodable
{
    var name: String
    var thumb: String
    var id: String
    
    public enum CodingKeys: String, CodingKey{
        case id = "idMeal"
        case name = "strMeal"
        case thumb = "strMealThumb"
    }
}

struct FoodMeals: Decodable
{
    let meals: [Meal]
}

public var favourite:[Meal] = []


