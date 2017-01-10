//
//  UserCell.swift
//  DevChat
//
//  Created by Alfonso, Hector I. on 12/30/16.
//  Copyright © 2016 Alfonso, Hector I. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var firstNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCheckMark(selected: false)
    }

    func updateUI(user: User) {
        self.firstNameLabel.text = user.firstName
    }
    
    func setCheckMark(selected: Bool ) {
        
        let imageStr = selected ? "messageindicatorchecked1": "messageindicator1"
        self.accessoryView = UIImageView(image: UIImage(named: imageStr))
        
    }

}
