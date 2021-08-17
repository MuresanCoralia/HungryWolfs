//
//  SearchViewController.swift
//  HungryWolfs
//
//  Created by Wolfpack Digital on 16.08.2021.
//

import UIKit

class SearchViewController: UIViewController
{

    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var foundLabel: UILabel!
    @IBOutlet weak var mealSearchCollection: UICollectionView!
    
    var text = ""
    
    private let viewModelSearch: SearchViewModel = SearchViewModel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        viewSearch.layer.cornerRadius = 40
        
        mealSearchCollection.delegate = self
        mealSearchCollection.dataSource = self
        
        searchTextField.text = text
        let name = searchTextField.text ?? ""
        
        viewModelSearch.getSearch(name: name, completion: { [weak self] in self?.mealSearchCollection.reloadData()
        })
        
        (mealSearchCollection.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = .zero
        
        searchTextField.becomeFirstResponder()

    }
    
    
    @IBAction func editingSearch(_ sender: Any?)
    {
        let name = searchTextField.text ?? ""
        print(name)
        
        // label found x items
        viewModelSearch.getSearch(name: name, completion: { [weak self] in
            self?.mealSearchCollection.reloadData()
            let nrOfResults = String(self?.viewModelSearch.meals.count ?? 0)
            if nrOfResults == "1"
            {
                self?.foundLabel.text = "Found \(nrOfResults) result"
            }
            else
            {
                self?.foundLabel.text = "Found \(nrOfResults) results"
            }
        })
    }
    
     @IBAction func backButtnTapped(_ sender: Any)
     {
             self.navigationController?.popViewController(animated: true)
     }
}



extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource
{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == self.mealSearchCollection
        {
            return viewModelSearch.meals.count
        }
        else
        {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        if collectionView == self.mealSearchCollection
        {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchMeal", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
            
            let meal = viewModelSearch.meals[indexPath.row]
            
            if let mealName:String? = meal.strMeal,
               let thumbnail:String? = meal.strMealThumb
            {
                if indexPath.row % 2 == 0
                {
                    cell.configureEvenRow(thumbnailUrlString: meal.strMealThumb, mealName: meal.strMeal)
                } else
                {
                    cell.configureOddRow(thumbnailUrlString: meal.strMealThumb, mealName: meal.strMeal)
                }
            }
            return cell
        }
        else
        {
            return UICollectionViewCell()
        }
        
        /*
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchMeal", for: indexPath) as! SearchCollectionViewCell

        let meal = viewModelSearch.meals[indexPath.row]
    
        cell.configure(thumbnailUrl: meal.strMealThumb, title: meal.strMeal)
        // mealSearchCollection.reloadData()
        
        return cell
         */
    
    }
    
}
