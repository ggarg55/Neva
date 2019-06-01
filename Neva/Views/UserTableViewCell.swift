//
//  UserTableViewCell.swift
//  Neva
//
//  Created by Gourav  Garg on 31/05/19.
//  Copyright © 2019 Gourav  Garg. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var contentSubView: UIView!
    @IBOutlet weak private var profileImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var skillLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureContentSubView()
    }
    
    func confiureCell(data: UserData) {
        nameLabel.text = data.name
        skillLabel.text = data.skills
        if let imgAddress = data.image {
            profileImageView.configureImage(imgAddress)
        }
    }
    
    func configureContentSubView() {
        let color : UIColor = UIColor( red: 0.5, green: 0.5, blue:0.5, alpha: 1.0 )
        let borderWidth: CGFloat = 2.0
        contentSubView.layer.borderColor = color.cgColor
        contentSubView.layer.borderWidth = borderWidth
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 58
        profileImageView.layer.borderColor = UIColor( red: 0.8, green: 0.8, blue:0.8, alpha: 0.3 ).cgColor
        profileImageView.layer.borderWidth = borderWidth
    }
}
