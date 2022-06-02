//
//  CalendrierViewController.swift
//  Nba
//
//  Created by Samy Boussair on 20/05/2022.
//

import UIKit


class CalendrierViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var calendrierDict:[DateCategory:Calendrier?] = [:]
    var calendrier = [CalendrierMatch]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        downloadJSON(date: DateCategory.today)
        self.tableView.reloadData()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calendrier.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifiant = "CalendrierCell"
    let CalendrierCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiant, for: indexPath) as! CalendrierTableViewCell
        
        //Affichage dans les cellules
        let  ScoreDomOuNon = calendrier[indexPath.row].AwayTeamScore
        let  ScoreExtOuNon = calendrier[indexPath.row].HomeTeamScore
        CalendrierCell.DomLabel.text = calendrier[indexPath.row].AwayTeam
        CalendrierCell.ExtLabel.text = calendrier[indexPath.row].HomeTeam
        CalendrierCell.StatusLabel.text = "\(calendrier[indexPath.row].Status) @ \(calendrier[indexPath.row].DateTime)"
        CalendrierCell.LogoDom.image = UIImage(named: calendrier[indexPath.row].AwayTeam)
        CalendrierCell.LogoExt.image = UIImage(named: calendrier[indexPath.row].HomeTeam)
        AffichageScoreOuNon()
        
        
        // Fonction pour les score
        func AffichageScoreOuNon() {
            
            if ScoreDomOuNon == nil {
                CalendrierCell.ScoreDom.text = "-"
            } else{
                CalendrierCell.ScoreDom.text = "\(calendrier[indexPath.row].AwayTeamScore!)"
            }
            
            if ScoreExtOuNon == nil {
                CalendrierCell.ScoreExt.text = "-"
            } else{
                CalendrierCell.ScoreExt.text = "\(calendrier[indexPath.row].HomeTeamScore!)"
            }
        }
        
        return CalendrierCell
    }

    
    //MARK: API Calendrier
    func downloadJSON (date: DateCategory) {
    // Récupère la date correctement formatée pour l'appel de l'API
    let formattedDate = DateHelpers.getDateString(day: date)
    
        guard let url = URL(string: "https://api.sportsdata.io/v3/nba/scores/json/GamesByDate/\(formattedDate)?key=\(Constants.apiKey)")
        else {
        fatalError("BAD URL")
    }
      
    //Appel de L'API
    URLSession.shared.dataTask(with: url) { data, response, error in
        do {
            if error == nil && data != nil {
                
                // Analyse le JSON entrant ; il sera analysé comme un tableau
                let decoder = JSONDecoder()
                self.calendrier = try decoder.decode([CalendrierMatch].self, from: data!)
                
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        } catch {
            fatalError("Impossible d'analyser JSON dans Calendrier! \n\(error)")
        }
    }.resume()
  }
    
    
    //MARK: Segmented control (Today, Tomorrow, Yesterday)
    
    @IBAction func SegmentControl (_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            downloadJSON(date: .yesterday)
        } else if sender.selectedSegmentIndex == 1 {
            downloadJSON(date: .today)
        } else if sender.selectedSegmentIndex == 2 {
            downloadJSON(date: .tomorrow)
        }
    }
}

