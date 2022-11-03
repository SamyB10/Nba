//
//  CalendrierViewController.swift
//  Nba
//
//  Created by Samy Boussair on 20/05/2022.
//

import UIKit
// swiftlint:disable: all force_cast
// swiftlint:disable: all line_length
// swiftlint:disable: line_length


class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var schedule = [ScheduleGame]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        downloadJSON(date: DateCategory.today)
        self.tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedule.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifiant = "ScheduleCell"
        let scheduleCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiant, for: indexPath) as! ScheduleTableViewCell
        // print of the cells
        let resultHomeOrOutside = schedule[indexPath.row].AwayTeamScore
        let scoreExtOuNon = schedule[indexPath.row].HomeTeamScore
        scheduleCell.homeLabel.text = schedule[indexPath.row].AwayTeam
        scheduleCell.outsideLabel.text = schedule[indexPath.row].HomeTeam
        scheduleCell.statusLabel.text = "\(schedule[indexPath.row].Status) @ \(schedule[indexPath.row].DateTime)"
        scheduleCell.logoHome.image = UIImage(named: schedule[indexPath.row].AwayTeam)
        scheduleCell.logoOutside.image = UIImage(named: schedule[indexPath.row].HomeTeam)
        printResultYesOrNo()
        
        
        // MARK: - func for the results
        func printResultYesOrNo() {
            if resultHomeOrOutside == nil {
                scheduleCell.resultHome.text = "-"
            } else {
                scheduleCell.resultHome.text = "\(schedule[indexPath.row].AwayTeamScore!)"
            }
            if scoreExtOuNon == nil {
                scheduleCell.resultOutside.text = "-"
            } else {
                scheduleCell.resultOutside.text = "\(schedule[indexPath.row].HomeTeamScore!)"
            }
        }
        return scheduleCell
    }
    
    
    // MARK: - API schedule
    func downloadJSON (date: DateCategory) {
        // retrieve the good formatted date for the call API
        let formattedDate = DateHelpers.getDateString(day: date)
        guard let url = URL(string: "https://api.sportsdata.io/v3/nba/scores/json/GamesByDate/\(formattedDate)?key=\(Constants.apiKey)")
        else {
            fatalError("BAD URL")
        }
        // Call API
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                if error == nil && data != nil {
                    // chack the JSON incomming ; it will be check each a array
                    let decoder = JSONDecoder()
                    self.schedule = try decoder.decode([ScheduleGame].self, from: data!)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            } catch {
                fatalError("\(error)")
            }
        }.resume()
    }
    
    
    // MARK: - Segmented control (Today, Tomorrow, Yesterday)
    @IBAction func segmentControl (_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            downloadJSON(date: .yesterday)
        } else if sender.selectedSegmentIndex == 1 {
            downloadJSON(date: .today)
        } else if sender.selectedSegmentIndex == 2 {
            downloadJSON(date: .tomorrow)
        }
    }
}
