//
//  ClassementViewController.swift
//  Nba
//
//  Created by Samy Boussair on 02/06/2022.
//

import UIKit
// swiftlint:disable:all line_length
// swiftlint:disable:all identifier_name
// swiftlint:disable:all force_cast
// swiftlint:disable:all vertical_whitespace



class ClassementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @Published var conference: ClassementConference?
    var standing = [Standing]()
    var year = Constants.saison[0]
    var colorBlue = UIColor(red: 39/255, green: 65/255, blue: 133/255, alpha: 0.7)
    var colorRed = UIColor(red: 184/255, green: 43/255, blue: 53/255, alpha: 0.7)
    
    @IBOutlet weak var legendeRed: UILabel!
    @IBOutlet weak var legendeBlue: UILabel!
    @IBOutlet weak var validerAnne: UIButton!
    @IBOutlet weak var saison: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        legendeBlue.backgroundColor = colorBlue
        legendeRed.backgroundColor = colorRed
        self.downloadsJSON()
    }
    @IBAction func selectConf(_ sender: UISegmentedControl) -> () {
        tableView.reloadData()
    }
    
    
    // MARK: - Table VIew
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
        let classementCellIdentifiant = "ClassementCell"
        let classementCell = tableView.dequeueReusableCell(withIdentifier: classementCellIdentifiant, for: indexPath) as! ClassementTableViewCell
        // Print in the cell
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            classementCell.numeroClassement(numero: indexPath.row + 1)
            if indexPath.row <= 5 {
                classementCell.classementLabel.backgroundColor = colorBlue
            } else if indexPath.row <= 9 {
                classementCell.classementLabel.backgroundColor = colorRed
            } else {
                classementCell.classementLabel.backgroundColor = .white
            }
            classementCell.logoImageView.image = UIImage(named: (conference?.east[indexPath.row].Key)!)
            classementCell.equipeLabel.text = "\(conference!.east[indexPath.row].City) \(conference!.east[indexPath.row].Name)"
            classementCell.statsLabel.text = "\(conference!.east[indexPath.row].Wins) - \(conference!.east[indexPath.row].Losses)"
        case 1:
            classementCell.numeroClassement(numero: indexPath.row + 1)
            if indexPath.row <= 5 {
                classementCell.classementLabel.backgroundColor = colorBlue
            } else if indexPath.row <= 9 {
                classementCell.classementLabel.backgroundColor = colorRed
            } else {
                classementCell.classementLabel.backgroundColor = .white
            }
            classementCell.numeroClassement(numero: indexPath.row + 1)
            classementCell.logoImageView.image = UIImage(named: (conference?.weast[indexPath.row].Key)!)
            classementCell.equipeLabel.text = "\(conference!.weast[indexPath.row].City) \(conference!.weast[indexPath.row].Name)"
            classementCell.statsLabel.text = "\(conference!.weast[indexPath.row].Wins) - \(conference!.weast[indexPath.row].Losses)"
        default:
            break
        }
        return classementCell
    }
    
    
    // MARK: - API Classement
    func downloadsJSON() {
        guard let url = URL(string: "https://api.sportsdata.io/v3/nba/scores/json/Standings/\(year)?key=\(Constants.apiKey)")
        else {
            fatalError("BAD URL")
        }
        // call of the API
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                if error == nil && data != nil {
                    // check the JSON incoming ; it will be check as an array
                    let decoder = JSONDecoder()
                    self.standing = try decoder.decode([Standing].self, from: data!)
                    var incomingData = try decoder.decode([Standing].self, from: data!)
                    // assign a ID a each team
                    for s in (1..<incomingData.count) {
                        incomingData[s].id = UUID()
                    }
                    var newConference = ClassementConference()
                    DispatchQueue.main.async {
                        newConference.teams = incomingData
                        newConference.conference()
                        self.conference = newConference
                        self.tableView.reloadData()
                    }
                }
            } catch {
                fatalError("Impossible d'analyser JSON dans Calendrier! \n\(error)")
            }
        }.resume()
    }
    // MARK: - Changer Saison
    @IBAction func valider(_ sender: Any) {
        choixAnnee()
    }
    func choixAnnee() {
        let years = year
        if years == "2021" {
            downloadsJSON()
        } else if years == "2022" {
            downloadsJSON()
        }
    }
}

// MARK: - PICKER VIEW SAISONS
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
        year = Constants.saison[row]
    }
}
