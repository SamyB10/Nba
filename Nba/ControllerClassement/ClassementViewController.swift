//
//  ClassementViewController.swift
//  Nba
//
//  Created by Samy Boussair on 02/06/2022.
//

import UIKit

class ClassementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
   @Published var conference: ClassementConference?
    var classement = [Classement]()
    var annee = Constants.saison[0]
    
    
    @IBOutlet weak var validerAnne: UIButton!
    @IBOutlet weak var Saison: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        downloadsJSON()
    }
    
    @IBAction func SelectConf(_ sender: UISegmentedControl) -> () {
            tableView.reloadData()
}
    
    
    //MARK: Table VIew
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       switch segmentedControl.selectedSegmentIndex {
        case 0:
           return conference!.east.count
           
        case 1:
           return conference!.weast.count
           
        default:
            break
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ClassementCellIdentifiant = "ClassementCell"
        let ClassementCell = tableView.dequeueReusableCell(withIdentifier: ClassementCellIdentifiant, for: indexPath) as! ClassementTableViewCell
        
        //Affichage dans les cellules
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            ClassementCell.NumeroClassement(Numero: indexPath.row + 1)
            ClassementCell.LogoImageView.image = UIImage(named: (conference?.east[indexPath.row].Key)!)
            ClassementCell.EquipeLabel.text = "\(conference!.east[indexPath.row].City) \(conference!.east[indexPath.row].Name)"
            ClassementCell.StatsLabel.text = "\(conference!.east[indexPath.row].Wins) - \(conference!.east[indexPath.row].Losses)"
        case 1:
            ClassementCell.NumeroClassement(Numero: indexPath.row + 1)
            ClassementCell.LogoImageView.image = UIImage(named: (conference?.weast[indexPath.row].Key)!)
            ClassementCell.EquipeLabel.text = "\(conference!.weast[indexPath.row].City) \(conference!.weast[indexPath.row].Name)"
            ClassementCell.StatsLabel.text = "\(conference!.weast[indexPath.row].Wins) - \(conference!.weast[indexPath.row].Losses)"
        default:
            break
        }
        return ClassementCell
    }
    
    
    //MARK: API Classement
    func downloadsJSON() {
        
        guard let url = URL(string: "https://api.sportsdata.io/v3/nba/scores/json/Standings/\(annee)?key=\(Constants.apiKey)")
        else {
        fatalError("BAD URL")
    }
      
    //Appel de L'API
    URLSession.shared.dataTask(with: url) { data, response, error in
        do {
            if error == nil && data != nil {
                
                // Analyse le JSON entrant ; il sera analysé comme un tableau
                let decoder = JSONDecoder()
                self.classement = try decoder.decode([Classement].self, from: data!)
                var incomingData = try decoder.decode([Classement].self, from: data!)
                
                // Assigner un ID a chaque equipe
                 for s in (1..<incomingData.count) {
                 incomingData[s].id = UUID()
            }
    
   // créer un nouvel objet lui donner le tableau des équipes, le trier, l'affecter à la propriété de classement du modèle
            var newConference = ClassementConference()
            DispatchQueue.main.async {
                newConference.teams = incomingData
                newConference.Conference()
                self.conference = newConference
                self.tableView.reloadData()
            }
        }
        } catch {
            fatalError("Impossible d'analyser JSON dans Calendrier! \n\(error)")
        }
    }.resume()
  }
    
    
   
    //MARK: Changer Saison
    @IBAction func valider(_ sender: Any) {
        ChoixAnnee()
    }
    
    func ChoixAnnee() {
        let years = annee
    
        if years == "2021" {
            downloadsJSON()
        } else if years == "2022" {
            downloadsJSON()
        }
    }
}

    //MARK: PICKER VIEW SAISONS
 extension ClassementViewController: UIPickerViewDataSource, UIPickerViewDelegate {
         func numberOfComponents(in pickerView: UIPickerView) -> Int {
             1
         }
         
         func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
             return Constants.saison.count
         }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
             return Constants.saison[row]
     }
        
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         annee = Constants.saison[row]
        
    }
}









