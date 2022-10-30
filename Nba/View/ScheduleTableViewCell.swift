//
//  CalendrierTableViewCell.swift
//  Nba
//
//  Created by Samy Boussair on 23/05/2022.
//

import Foundation
import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var logoHome: UIImageView!
    @IBOutlet weak var logoOutside: UIImageView!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var outsideLabel: UILabel!
    @IBOutlet weak var resultHome: UILabel!
    @IBOutlet weak var resultOutside: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var viewSchedule: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewSchedule.layer.cornerRadius = viewSchedule.frame.height / 6
        addShadow()
    }
    
    
    //MARK: - Custom of match rectangles
    func addShadow() {
        viewSchedule.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        viewSchedule.layer.shadowRadius = 5
        viewSchedule.layer.shadowOffset = CGSize( width: 2.0, height: 2.0)
        viewSchedule.layer.shadowOpacity = 2.0
    }
}
