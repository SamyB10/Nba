//
//  ClassementTableViewCell.swift
//  Nba
//
//  Created by Samy Boussair on 02/06/2022.
//

import UIKit

class ClassementTableViewCell: UITableViewCell {

    @IBOutlet weak var ViewClassement: UIView!
    @IBOutlet weak var ClassementLabel: UILabel!
    @IBOutlet weak var LogoImageView: UIImageView!
    @IBOutlet weak var EquipeLabel: UILabel!
    @IBOutlet weak var StatsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadows()
        
    }

    func addShadows() {
        ViewClassement.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        ViewClassement.layer.shadowOpacity = 2.0
    }
    
    func NumeroClassement(Numero: Int) {
        ClassementLabel.text = "\(Numero)"
    }
}
