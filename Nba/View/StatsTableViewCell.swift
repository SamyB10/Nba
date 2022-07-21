//
//  StatsTableViewCell.swift
//  Nba
//
//  Created by Samy Boussair on 13/06/2022.
//

import Foundation
import UIKit

class StatsTableViewCell: UITableViewCell {

    @IBOutlet weak var ViewStats: UIView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var PointLabel: UILabel!
    @IBOutlet weak var PosteLabel: UILabel!
    @IBOutlet weak var ORP: UILabel!
    @IBOutlet weak var DRP: UILabel!
    @IBOutlet weak var AP: UILabel!
    @IBOutlet weak var BS: UILabel!

    var Image = StatsViewController()
     
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NameLabel.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(clickLabel))
        tap.numberOfTapsRequired = 1
        NameLabel.addGestureRecognizer(tap)

    }
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){
        
    }
    
    @objc func clickLabel() {
        Image.rechercheImage(NamePlayersFields: "") 
       // print("\(NameLabel)")
        
    }
}
