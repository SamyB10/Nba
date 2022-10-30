//
//  ClassementTableViewCell.swift
//  Nba
//
//  Created by Samy Boussair on 02/06/2022.
//

import UIKit

class ClassementTableViewCell: UITableViewCell {
    @IBOutlet weak var viewClassement: UIView!
    @IBOutlet weak var classementLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var equipeLabel: UILabel!
    @IBOutlet weak var statsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadows()
    }
    func addShadows() {
        viewClassement.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        viewClassement.layer.shadowOpacity = 2.0
    }
    func numeroClassement(numero: Int) {
        classementLabel.text = "\(numero)"
    }
}
