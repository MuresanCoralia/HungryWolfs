//
//  HomeScreenViewController.swift
//  HungryWolfs
//
//  Created by Wolfpack Digital on 10.08.2021.
//

import UIKit

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var categoriesCollection: UICollectionView!
    @IBOutlet weak var mealsCollection: UICollectionView!
    
    
    
    @IBOutlet weak var searchField: UITextField!
    
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
           // guard let category = self.viewModelMeal.categories[0].name else {return}
            self?.viewModelMeal.getMeals(categories: "Beef", completion: { [weak self] in self?.mealsCollection.reloadData()
            })
        })
        
        
        // afiseaza numai cate un produs din categorie
        (mealsCollection.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = .zero
        
        // linia de la navigation controler dispare
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        // linia de la tab bar
        UITabBar.appearance().clipsToBounds = true
        
    }
    
    // adauga colturi rotunde la search
    func updateCornerRadius()
    {
        searchView.layer.cornerRadius = 30
    }
    
    
    @IBAction func toSearch(_ sender: Any)
    {
        performSegue(withIdentifier: "fromMainToSearch", sender: self)
    }
    
    
    // pentru detail screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if segue.identifier == "fromMainToSearch",
            let destination = segue.destination as? SearchViewController
        {
            destination.text = searchField.text ?? ""
        }
        
        if segue.identifier == "fromMealToDetails",
           let destination = segue.destination as? DetailViewController,
           let mealId = sender as? String
        {
            destination.id = mealId
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell
            else{
                return UICollectionViewCell()
            }
            
            cell.categoryFoodLabel.text = viewModelFood.category[indexPath.row].name
            
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MealsCollectionViewCell", for: indexPath) as? MealsCollectionViewCell
            else{
                return UICollectionViewCell()
            }
            
            let meal = viewModelMeal.meals[indexPath.row]
        
            cell.configure(thumbnailUrl: meal.thumb, title: meal.name)
            
            
            return cell
        }
    
        
    }
    
    // functionalitate labeluri categorii - afiseaza mancarurile dintr-o anumita categorie
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        if collectionView == categoriesCollection
        {
            let mealCategory = viewModelFood.category[indexPath.row].name
            
            self.viewModelMeal.getMeals(categories: mealCategory, completion: { [weak self] in self?.mealsCollection.reloadData()
            })
            
            selectedIndexPath = indexPath
            
            //categoriesCollection.reloadItems(at: [indexPath])
            categoriesCollection.reloadData()
            
         // ramura else pentru detail screen
        } else if collectionView == mealsCollection
        {
            let id = viewModelMeal.meals[indexPath.row].id
            performSegue(withIdentifier: "fromMealToDetails", sender: id)
        }
    }
    
}


extension HomeScreenViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // User finished typing (hit return): hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
}

