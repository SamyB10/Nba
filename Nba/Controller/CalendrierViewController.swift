//
//  CalendrierViewController.swift
//  Nba
//
//  Created by Samy Boussair on 20/05/2022.
//

import UIKit





class CalendrierViewController: UIViewController {
    
  //var EquipeDom = loadMatch()

    @IBOutlet weak var tableView: UITableView!
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
      
        
    }
    
    
}

extension CalendrierViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me!")
    }
    
}

extension CalendrierViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CalendrierCell = tableView.dequeueReusableCell(withIdentifier: "CalendrierCell", for: indexPath)

    
        return CalendrierCell
    }
}
