//
//  Food.swift
//  HungryWolfs
//
//  Created by Wolfpack Digital on 10.08.2021.
//

import Foundation

struct Food: Decodable
{
    var idCategory: String
    var strCategory: String
    var strCategoryThumb: String
    var strCategoryDescription: String
    
}

struct FoodCategories: Decodable
{
    let categories: [Food]
}


