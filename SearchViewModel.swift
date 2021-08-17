//
//  SearchViewModel.swift
//  HungryWolfs
//
//  Created by Wolfpack Digital on 16.08.2021.
//

import Foundation

class SearchViewModel
{
    private let repository: Repository = Repository()
    var meals = [Meal]()
   
    
    func getSearch(name: String, completion: @escaping () -> Void)
    {
        repository.getSearch(name: name, completion: { [weak self] response in
            guard let array = response else { return }
            self?.meals = array
            completion()
        })
    }
    
    // label found x items
    func getNumberMeals(name: String, completion: @escaping () -> Void)
    {
        repository.getNumberMeals(name: name, completion: { [weak self] response in
            guard let array = response else { return }
            self?.meals = array
            completion()
        })
    }
    
}
