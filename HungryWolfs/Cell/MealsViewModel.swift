//
//  MealsViewModel.swift
//  HungryWolfs
//
//  Created by Wolfpack Digital on 12.08.2021.
//

import Foundation

class MealsViewModel
{
    private let repository: Repository = Repository()
    var meals = [Meal]()
   
    
    func getMeals(categories: String, completion: @escaping () -> Void)
    {
        repository.getMeals(categories: categories, completion: { [weak self] response in
            guard let array = response else { return }
            self?.meals = array
            completion()
        })
    }
}
