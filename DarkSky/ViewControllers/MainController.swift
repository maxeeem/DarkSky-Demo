//
//  MainController.swift
//  DarkSky
//
//  Created by Maxim VT on 4/7/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import UIKit

class MainController: UITableViewController {

    var days: [Day] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    let cellID = "DayCell"
    let segueID = "DayDetail"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "San Diego"
        
        /// configure tableview
        let cellNib = UINib(nibName: "DayCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView()
        
        /// register refresh action
        refreshControl!.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        /// show loading indicator
        let offset = CGPoint(x: 0, y: tableView.contentOffset.y - refreshControl!.frame.height)
        tableView.setContentOffset(offset, animated: true)
        refreshControl!.beginRefreshing()
        refreshControl!.sendActions(for: .valueChanged)
    }

    
    // MARK: - Refresh action
    
    @objc func refreshData() {
        /// simulate api call delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            guard let s = self else {
                fatalError("Could not reassign `self`")
            }
            
            s.days = [Day(), Day(), Day(), Day(), Day()]
            
            s.refreshControl?.endRefreshing()
        }
    }
    

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! DayCell
        
        guard indexPath.row < days.count else {
            fatalError("Incorrect number of items in `days` array")
        }

        let day = days[indexPath.row]
        cell.configure(with: day)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < days.count else {
            fatalError("Incorrect number of items in `days` array")
        }
        
        performSegue(withIdentifier: segueID, sender: days[indexPath.row])
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            fatalError("Missing identifier for segue")
        }
        
        switch identifier {
            
        case segueID:
            guard let detail = segue.destination as? DetailController else {
                fatalError("Incorrect destination controller for segue with identifier \(segueID)")
            }
            
            guard let day = sender as? Day else {
                fatalError("Incorrect sender for segue with identifier \(segueID)")
            }
            
            /// pass selected day to the detail controller
            detail.day = day
            
        default: break
        }
    }

}
