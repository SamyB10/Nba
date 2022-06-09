//
//  CalendrierTableViewCell.swift
//  Nba
//
//  Created by Samy Boussair on 23/05/2022.
//

import Foundation
import UIKit



class CalendrierTableViewCell: UITableViewCell {
    
        
    @IBOutlet weak var LogoDom: UIImageView!
    @IBOutlet weak var LogoExt: UIImageView!
    @IBOutlet weak var DomLabel: UILabel!
    @IBOutlet weak var ExtLabel: UILabel!
    @IBOutlet weak var ScoreDom: UILabel!
    @IBOutlet weak var ScoreExt: UILabel!
    @IBOutlet weak var StatusLabel: UILabel!
    @IBOutlet weak var viewCalendrier: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewCalendrier.layer.cornerRadius = viewCalendrier.frame.height / 6
        addShadow()
        
    }

    // Custom rectangle des rencontre
        func addShadow() {
        viewCalendrier.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        viewCalendrier.layer.shadowRadius = 5
        viewCalendrier.layer.shadowOffset = CGSize( width: 2.0, height: 2.0)
        viewCalendrier.layer.shadowOpacity = 2.0
    }
}



