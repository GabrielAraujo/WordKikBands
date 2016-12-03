//
//  BandCell.swift
//  Bands
//
//  Created by Gabriel Araujo on 03/12/16.
//  Copyright © 2016 Wordkik. All rights reserved.
//

import UIKit

class BandCell: UITableViewCell {

    @IBOutlet weak var container: UIVisualEffectView! {
        didSet {
            container.clipsToBounds = true
            container.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var bullet: UIView! {
        didSet {
            bullet.clipsToBounds = true
            bullet.layer.cornerRadius = 5
            bullet.layer.shadowColor = UIColor.black.cgColor
            bullet.layer.shadowOpacity = 1
            bullet.layer.shadowOffset = CGSize.zero
            bullet.layer.shadowRadius = 10
            bullet.layer.shouldRasterize = true
        }
    }
    @IBOutlet weak var lblName: UILabel! {
        didSet {
            lblName.adjustsFontSizeToFitWidth = true
        }
    }
    
    var color:UIColor!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
