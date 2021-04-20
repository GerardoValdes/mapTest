//  usersTableViewCell.swift
//  mapTest
//
//  Created by Gerardo Valdes on 19/04/21.
//
import UIKit

class usersTableViewCell: UITableViewCell {

    @IBOutlet weak var circle: UIView!
    @IBOutlet weak var icons: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var followbutton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //make circular view
        circle.layer.cornerRadius = circle.frame.size.width/2
        circle.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    

}
