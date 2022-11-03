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



class StandingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @Published var conference: StandingsConference?
    var standing = [Standing]()
    var year = Constants.season[0]
    var colorBlue = UIColor(red: 39/255, green: 65/255, blue: 133/255, alpha: 0.7)
    var colorRed = UIColor(red: 184/255, green: 43/255, blue: 53/255, alpha: 0.7)
    
    @IBOutlet weak var legendRed: UILabel!
    @IBOutlet weak var legendBlue: UILabel!
    @IBOutlet weak var validateYear: UIButton!
    @IBOutlet weak var season: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        legendBlue.backgroundColor = colorBlue
        legendRed.backgroundColor = colorRed
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
        let standingsCellIdentifiant = "StandingsCell"
        let standingsCell = tableView.dequeueReusableCell(withIdentifier: standingsCellIdentifiant, for: indexPath) as! StandingsTableViewCell
        // Print in the cell
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            standingsCell.numeroClassement(numero: indexPath.row + 1)
            if indexPath.row <= 5 {
                standingsCell.standingsLabel.backgroundColor = colorBlue
            } else if indexPath.row <= 9 {
                standingsCell.standingsLabel.backgroundColor = colorRed
            } else {
                standingsCell.standingsLabel.backgroundColor = .white
            }
            standingsCell.logoPictureView.image = UIImage(named: (conference?.east[indexPath.row].Key)!)
            standingsCell.teamLabel.text = "\(conference!.east[indexPath.row].City) \(conference!.east[indexPath.row].Name)"
            standingsCell.statsLabel.text = "\(conference!.east[indexPath.row].Wins) - \(conference!.east[indexPath.row].Losses)"
        case 1:
            standingsCell.numeroClassement(numero: indexPath.row + 1)
            if indexPath.row <= 5 {
                standingsCell.standingsLabel.backgroundColor = colorBlue
            } else if indexPath.row <= 9 {
                standingsCell.standingsLabel.backgroundColor = colorRed
            } else {
                standingsCell.standingsLabel.backgroundColor = .white
            }
            standingsCell.numeroClassement(numero: indexPath.row + 1)
            standingsCell.logoPictureView.image = UIImage(named: (conference?.weast[indexPath.row].Key)!)
            standingsCell.teamLabel.text = "\(conference!.weast[indexPath.row].City) \(conference!.weast[indexPath.row].Name)"
            standingsCell.statsLabel.text = "\(conference!.weast[indexPath.row].Wins) - \(conference!.weast[indexPath.row].Losses)"
        default:
            break
        }
        return standingsCell
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
                    var newConference = StandingsConference()
                    DispatchQueue.main.async {
                        newConference.teams = incomingData
                        newConference.conference()
                        self.conference = newConference
                        self.tableView.reloadData()
                    }
                }
            } catch {
                fatalError("\(error)")
            }
        }.resume()
    }
    // MARK: - Switch Seasons
    @IBAction func validate(_ sender: Any) {
        choiceYear()
    }
    func choiceYear() {
        let years = year
        if years == "2021" {
            downloadsJSON()
        } else if years == "2022" {
            downloadsJSON()
        }
    }
}

// MARK: - PICKER VIEW SAISONS
extension StandingsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.season.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Constants.season[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        year = Constants.season[row]
    }
}
