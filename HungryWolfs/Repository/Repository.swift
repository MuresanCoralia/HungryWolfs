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
    
    let URL = "https://www.themealdb.com/api/json/v1/1/"
    
    func getCategories(completion: @escaping ([Food]?) -> Void)
    {
        let myFoodURL = URL + "categories.php"
        
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
        let myMealURL = URL + "filter.php?c=" + categories
        
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
        let myMealURL = URL + "search.php?s=" + name
        
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
        let myMealURL = URL + "filter.php?c=" + name
        
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
    
    
    func getDetails(id: String, completion: @escaping ([Detail]?) -> Void)
    {
        let myMealURL = URL + "lookup.php?i=" + id
        
        AF.request(myMealURL).responseJSON
        { response in
            switch response.result
            {
            case .success:
                let decoder = JSONDecoder()
                guard let data = response.data else { return }
                do {
                    let detailsArray = try decoder.decode(FoodDetails.self, from: data)
                    completion(detailsArray.meals)
                } catch { error
                    print(error)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
