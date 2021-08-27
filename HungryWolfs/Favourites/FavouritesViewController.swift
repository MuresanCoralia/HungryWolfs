//
//  FavouritesViewController.swift
//  HungryWolfs
//
//  Created by Wolfpack Digital on 19.08.2021.
//

import UIKit

class FavouritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        //internet connection
        if (NetworkManager.sharedInstance.reachability).connection == .unavailable {
            self.showOfflinePage()
        }
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        tableView.rowHeight = UITableView.automaticDimension
        navigationController?.setNavigationBarHidden(true, animated: animated)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "myFavourite",
           let destination = segue.destination as? DetailViewController,
           let Id = sender as? String{
              destination.id = Id
        }
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
}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return favourite.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteCell", for: indexPath) as? FavouriteTableViewCell
        else{ return UITableViewCell()}

        let fav = favourite[indexPath.row]
        cell.update(with: fav)
        cell.showsReorderControl = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = favourite[indexPath.row].id
        performSegue(withIdentifier: "myFavourite", sender: id)

    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        if editingStyle == .delete{
            favourite.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath){
        
        let movedFavourite = favourite.remove(at: fromIndexPath.row)
            favourite.insert(movedFavourite, at: to.row)
       
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle{
        
        return .delete
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
      
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
       
        let action = UIContextualAction(style: .destructive, title:""){
          (action, view, completion) in
          favourite.remove(at: indexPath.row)
          self.tableView.deleteRows(at: [indexPath], with: .automatic)
          completion(true)
        }
        action.image = UIImage(named: "trash1" )
        action.backgroundColor = .systemGray6
        return action
      }
    
}
        
