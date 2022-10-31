//
//  ClassementTableViewCell.swift
//  Nba
//
//  Created by Samy Boussair on 02/06/2022.
//

import UIKit

class StandingsTableViewCell: UITableViewCell {
    @IBOutlet weak var viewStandings: UIView!
    @IBOutlet weak var standingsLabel: UILabel!
    @IBOutlet weak var logoPictureView: UIImageView!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var statsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadows()
    }
    func addShadows() {
        viewStandings.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        viewStandings.layer.shadowOpacity = 2.0
    }
    func numeroClassement(numero: Int) {
        standingsLabel.text = "\(numero)"
    }
}
