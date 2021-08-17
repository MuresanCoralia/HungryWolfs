//
//  Meals.swift
//  HungryWolfs
//
//  Created by Wolfpack Digital on 12.08.2021.
//

import Foundation

struct Meal: Decodable
{
    var strMeal: String
    var strMealThumb: String
    var idMeal: String
    
}

struct FoodMeals: Decodable
{
    let meals: [Meal]
}


