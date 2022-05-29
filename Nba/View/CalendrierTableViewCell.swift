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
    @IBOutlet weak var viewCalendrier: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
   
        
    do {
        let url = NSURL(string: "https://api.sportsdata.io/v3/nba/scores/json/GamesByDate/2021-APR-20?key=0560e10d2faa4de281ca1d422e8f0354");
        let texte: NSString = try NSString(contentsOf: url! as URL, usedEncoding: nil)
        
       
        
        let jsonData = texte.data(using: 4)
        let jsonResult: NSArray? = try
        JSONSerialization.jsonObject(with: jsonData!) as? NSArray
        
        // Conversion et affichage donne Nom Equipe domicile
        if let jsonResult = jsonResult {
            print ("JsonResult est bien covertit ! ")
            for HomeT in jsonResult {
                let HomeT2 = HomeT as! NSDictionary
                ExtLabel.text = "\(HomeT2["HomeTeam"]!)"
                LogoExt.image = UIImage(named: "\(HomeT2["HomeTeam"]!)")
                ScoreExt.text = "\(HomeT2["HomeTeamScore"]!)"
                }
      
        // Conversion et affichage donne Nom Equipe domicile
            for AwayT in jsonResult {
                print ("JsonResult est bien covertit ! ")
                for AwayT in jsonResult {
                    let AwayT2 = AwayT as! NSDictionary
                    DomLabel.text = "\(AwayT2["AwayTeam"]!)"
                    LogoDom.image = UIImage(named: "\(AwayT2["AwayTeam"]!)")
                    ScoreDom.text = "\(AwayT2["AwayTeamScore"]!)"
                }
            }
        }
    }  catch {
        print("Ereuer de conversion")
}
        
        // Initialization code
        viewCalendrier.layer.cornerRadius = viewCalendrier.frame.height / 3
        addShadow()
        
    }
    // Custom rectangle des rencontre
    private func addShadow() {
        viewCalendrier.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        viewCalendrier.layer.shadowRadius = 3.0
        viewCalendrier.layer.shadowOffset = CGSize( width: 2.0, height: 2.0)
        viewCalendrier.layer.shadowOpacity = 2.0
    }
}





