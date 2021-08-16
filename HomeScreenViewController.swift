//
//  HomeScreenViewController.swift
//  HungryWolfs
//
//  Created by Wolfpack Digital on 10.08.2021.
//

import UIKit

class HomeScreenViewController: UIViewController
{

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var categoriesCollection: UICollectionView!
    @IBOutlet weak var mealsCollection: UICollectionView!
    
    private let viewModelFood: FoodViewModel = FoodViewModel()
    private let viewModelMeal: MealsViewModel = MealsViewModel()
    
    var selectedIndexPath = IndexPath (item: 0, section: 0)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        updateCornerRadius()
        
        categoriesCollection.delegate = self
        categoriesCollection.dataSource = self
        
        mealsCollection.delegate = self
        mealsCollection.dataSource = self
        
        viewModelFood.getFoods(completion: { [weak self] in
            self?.categoriesCollection.reloadData()
            self?.viewModelMeal.getMeals(categories: "Beef", completion: { [weak self] in self?.mealsCollection.reloadData()
            })
        })
        
        // afiseaza numai cate un produs din categorie
        (mealsCollection.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = .zero
        
        // linia de la tab bar si navigation controler
        
       // tabBar.clipsToBounds = true
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    // adauga colturi rotunde la search
    func updateCornerRadius()
    {
        searchView.layer.cornerRadius = 30
    }

}


extension HomeScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == categoriesCollection
        {
            return viewModelFood.category.count
        }
        else
        {
            return viewModelMeal.meals.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        if collectionView == categoriesCollection
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            
            cell.categoryFoodLabel.text = viewModelFood.category[indexPath.row].strCategory
            
            //  colturi rotunde linia de sub categorii
            cell.configure()
            
            // coloreaza categoria selectata
            if indexPath == selectedIndexPath
            {
                cell.categoryFoodLabel.textColor = .red
                cell.underView.isHidden = false
                cell.underView.backgroundColor = .red
            }
            else
            {
                cell.categoryFoodLabel.textColor = .gray
                cell.underView.isHidden = true
            }
            
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MealsCollectionViewCell", for: indexPath) as! MealsCollectionViewCell
            
            let meal = viewModelMeal.meals[indexPath.row]
        
            cell.configure(thumbnailUrl: meal.strMealThumb, title: meal.strMeal)
            
            
            return cell
        }
    
        
    }
    
    // functionalitate labeluri categorii - afiseaza mancarurile dintr-o anumita categorie
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        if collectionView == categoriesCollection
        {
            let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell
            let mealCategory = viewModelFood.category[indexPath.row].strCategory
            
            self.viewModelMeal.getMeals(categories: mealCategory, completion: { [weak self] in self?.mealsCollection.reloadData()
            })
            
            selectedIndexPath = indexPath
            
            //categoriesCollection.reloadItems(at: [indexPath])
            categoriesCollection.reloadData()
        } else
        {
            
        }
    }
    
}

