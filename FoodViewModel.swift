//
//  FoodViewModel.swift
//  HungryWolfs
//
//  Created by Wolfpack Digital on 10.08.2021.
//

import Foundation

class FoodViewModel
{
    private let repository: Repository = Repository()
    var category = [Food]()
   
    
    func getFoods(completion: @escaping () -> Void)
    {
        repository.getCategories(completion: { [weak self] response in
            guard let array = response else { return }
            self?.category = array
            completion()
        })
    }
}
