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
    @IBOutlet weak var itemNotFoundStack: UIStackView!
    @IBOutlet weak var mealCollection: UICollectionView!
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
        searchData(name: name)
        
        viewModelSearch.getSearch(name: name, completion: { [weak self] in self?.mealSearchCollection.reloadData()
        })
        
        (mealSearchCollection.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = .zero
        
        //searchTextField.becomeFirstResponder()
        searchTextField.resignFirstResponder()
        searchTextField.delegate = self // set delegate
        
        //internet connection
        NetworkManager.isUnreachable { _ in self.showOfflinePage() }
    }
    
    // internet connection
    private func showOfflinePage() -> Void {
        DispatchQueue.main.async {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let internetConnectionViewController = mainStoryboard.instantiateViewController(identifier: "InternetConnectionScreen")
            internetConnectionViewController.modalPresentationStyle = .fullScreen
            self.present(internetConnectionViewController, animated: true)
        }
    }
    
    // labelul cu nr de results
    @IBAction func editingSearch(_ sender: Any?)
    {
        let name = searchTextField.text ?? ""
        searchData(name: name)
    }
    
    // labelul cu nr de results
    func searchData(name: String)
    {
        self.itemNotFoundStack.isHidden = false
        self.mealCollection.isHidden = true
        self.foundLabel.isHidden = true
        viewModelSearch.getSearch(name: name, completion: { [weak self] in
            self?.mealSearchCollection.reloadData()
            let nrOfResults = String(self?.viewModelSearch.meals.count ?? 0)
            if nrOfResults == "1"
            {
                self?.foundLabel.isHidden = false
                self?.mealCollection.isHidden = false
                self?.foundLabel.text = "Found \(nrOfResults) result"
            }
            else
            {
                self?.foundLabel.isHidden = false
                self?.mealCollection.isHidden = false
                self?.foundLabel.text = "Found \(nrOfResults) results"
            }
        })
    }
    
    // pentru detail screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "fromSearchToDetails",
           let destination = segue.destination as? DetailViewController,
           let mealId = sender as? String
        {
            destination.id = mealId
        }
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
            
            if let mealName:String? = meal.name,
               let thumbnail:String? = meal.thumb
            {
                if indexPath.row % 2 == 0
                {
                    cell.configureEvenRow(thumbnailUrlString: meal.thumb, mealName: meal.name)
                } else
                {
                    cell.configureOddRow(thumbnailUrlString: meal.thumb, mealName: meal.name)
                }
            }
            return cell
        }
        else
        {
            return UICollectionViewCell()
        }
    
    }
    
    // pentru detail screen
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
       if collectionView == mealSearchCollection
        {
            let id = viewModelSearch.meals[indexPath.row].id
            performSegue(withIdentifier: "fromSearchToDetails", sender: id)
        }
    }
    
}

// for keyboard issues
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder() // dismiss keyboard
        return true
    }
}


