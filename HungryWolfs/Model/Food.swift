//
//  Food.swift
//  HungryWolfs
//
//  Created by Wolfpack Digital on 10.08.2021.
//

import Foundation

struct Food: Decodable
{
    var id: String
    var name: String
    var thumb: String
    var description: String
    
    public enum CodingKeys: String, CodingKey{
        case id = "idCategory"
        case name = "strCategory"
        case thumb = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
}

struct FoodCategories: Decodable
{
    let categories: [Food]
}


