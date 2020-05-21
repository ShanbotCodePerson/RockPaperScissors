//
//  LeaderboardTableViewController.swift
//  RockPaperScissors
//
//  Created by Bethany Morris on 5/21/20.
//  Copyright © 2020 Shannon Draeker. All rights reserved.
//

import UIKit

class LeaderboardTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the data from the cloud
        UserController.shared.fetchHighScoringUsers { [weak self] (success) in
            if success {
                DispatchQueue.main.async { self?.tableView.reloadData() }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserController.shared.users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath)

        let user = UserController.shared.users[indexPath.row]
        cell.textLabel?.text = user.username
        cell.detailTextLabel?.text = "\(user.highScore)"

        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
