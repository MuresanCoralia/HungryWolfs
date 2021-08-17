//
//  Repository.swift
//  HungryWolfs
//
//  Created by Wolfpack Digital on 11.08.2021.
//

import Foundation
import Alamofire

class Repository
{

    let myFoodURL = "https://www.themealdb.com/api/json/v1/1/categories.php"
        
    func getCategories(completion: @escaping ([Food]?) -> Void)
    {
        AF.request(myFoodURL).responseJSON
        { response in
            switch response.result
            {
                case .success:
                    let decoder = JSONDecoder()
                    guard let data = response.data else { return }
                    let categoryArray = try? decoder.decode(FoodCategories.self, from: data)
                        completion(categoryArray?.categories)
                case .failure(let error):
                        print(error)
            }
        }
    }
    
    
    func getMeals(categories: String, completion: @escaping ([Meal]?) -> Void)
    {
        let myMealURL = "https://www.themealdb.com/api/json/v1/1/filter.php?c=" + categories
        
        AF.request(myMealURL).responseJSON
        { response in
            switch response.result
            {
                case .success:
                    let decoder = JSONDecoder()
                    guard let data = response.data else { return }
                    let mealsArray = try? decoder.decode(FoodMeals.self, from: data)
                        completion(mealsArray?.meals)
                case .failure(let error):
                        print(error)
            }
        }
    }
    
    func getSearch(name: String, completion: @escaping ([Meal]?) -> Void)
    {
        let myMealURL = "https://www.themealdb.com/api/json/v1/1/search.php?s=" + name
        
        AF.request(myMealURL).responseJSON
        { response in
            switch response.result
            {
                case .success:
                    let decoder = JSONDecoder()
                    guard let data = response.data else { return }
                    let mealsArray = try? decoder.decode(FoodMeals.self, from: data)
                        completion(mealsArray?.meals)
                case .failure(let error):
                        print(error)
            }
        }
    }
    
    // label found x items
    func getNumberMeals(name: String, completion: @escaping ([Meal]?) -> Void)
    {
        let myMealURL = "https://www.themealdb.com/api/json/v1/1/filter.php?c=" + name
        
        AF.request(myMealURL).responseJSON
        { response in
            switch response.result
            {
                case .success:
                    let decoder = JSONDecoder()
                    guard let data = response.data else { return }
                    let mealsArray = try? decoder.decode(FoodMeals.self, from: data)
                    completion(mealsArray?.meals)
                case .failure(let error):
                        print(error)
            }
        }
    }
    
}
