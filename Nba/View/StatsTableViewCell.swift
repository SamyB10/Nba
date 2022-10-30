//
//  StatsTableViewCell.swift
//  Nba
//
//  Created by Samy Boussair on 13/06/2022.
//

import Foundation
import UIKit

class StatsTableViewCell: UITableViewCell {
    @IBOutlet weak var viewStats: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var posteLabel: UILabel!
    @IBOutlet weak var offensiveReboundPercentage: UILabel!
    @IBOutlet weak var defensiveReboundPercentage: UILabel!
    @IBOutlet weak var assistPercentage: UILabel!
    @IBOutlet weak var blockPercentage: UILabel!
    var image = StatsViewController()
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(clickLabel))
        tap.numberOfTapsRequired = 1
        nameLabel.addGestureRecognizer(tap)
    }
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
    }
    @objc func clickLabel() {
        image.imagePlayers()
        // print("\(NameLabel)")
    }
}
