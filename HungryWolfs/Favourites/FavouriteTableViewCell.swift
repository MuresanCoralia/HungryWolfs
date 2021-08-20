//
//  FavouriteTableViewCell.swift
//  HungryWolfs
//
//  Created by Wolfpack Digital on 19.08.2021.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var favouriteView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        configure()
        
        //self.mealName.text = favourite[0].name
       
        //guard let imageURL = URL(string: (favourite[0].thumb)!) else { return }
     //   self.mealImage.kf.setImage(with: imageURL)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(){
        
        self.mealImage.layer.masksToBounds = true
        self.mealImage.layer.cornerRadius = (self.mealImage.bounds.width) / 2
        favouriteView.layer.cornerRadius = 20
    }

}
