//
//  ConverterTableViewController.swift
//  Currency-Converter
//
//  Created by Kristina Gelzinyte on 2/10/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class ConverterTableViewController: UITableViewController {

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //challenges.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "amount") as! ConverterTableViewCell
        
        
        //        let challenge = challenges[indexPath.row]
        //        cell.title.text = challenge.name.uppercased()
        //        cell.difficulty.text = challenge.level.rawValue
        //        cell.distance.text = "\(String(describing: challenge.distance))KM"
        //        // TODO: Temporary implementation. Need to get reward linked to challenege with rewardId and Challenge status
        //        cell.state = indexPath.row != 0 ? .locked : .unlocked
        //        cell.rewardText = indexPath.row != 0  ? "shoe discount".uppercased() : "Magazine discount".uppercased()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        guard indexPath.row == 0 else { return }
    //        let challenge = challenges[indexPath.row]
    //        MixPanelManager.track(event: "Selected Challenge", properties: ["Name": challenge.name])
    //        Router.showOnboarding(from: self, challenge: challenges[indexPath.row])
    //    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
