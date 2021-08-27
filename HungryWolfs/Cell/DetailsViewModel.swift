//
//  DetailsViewModel.swift
//  HungryWolfs
//
//  Created by Wolfpack Digital on 18.08.2021.
//

import Foundation

class DetailsViewModel
{
    private let repository: Repository = Repository()
    var details = [Detail]()

    func getDetails(id: String, completion: @escaping () -> Void)
    {
        repository.getDetails(id: id, completion: { [weak self] response in
            guard let array = response else { return }
            self?.details = array
            print(array)
            completion()
        })
    }

}
