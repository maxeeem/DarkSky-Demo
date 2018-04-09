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
    
    var api: API
    
    let cellID = "DayCell"
    let segueID = "DayDetail"
    
    
    init(api: API) {
        self.api = api
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.api = DarkSkyAPI()
        super.init(coder: aDecoder)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "San Diego"
        
        /// configure tableview
        let cellNib = UINib(nibName: "DayCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
        
        /// create refresh control and register refresh action
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .white
        refreshControl.attributedTitle = NSAttributedString(string: "Contacting the server")
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.refreshControl = refreshControl
        
        /// show loading indicator
        let offset = CGPoint(x: 0, y: tableView.contentOffset.y - refreshControl.frame.height)
        tableView.setContentOffset(offset, animated: true)
        refreshControl.beginRefreshing()
        refreshControl.sendActions(for: .valueChanged)
    }

    
    // MARK: - Refresh action
    
    @objc func refreshData() {
        api.getForecast({ [weak self] days in
            /// set new `days` values
            self?.days = days
            /// hide loading indicator after a small delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.refreshControl?.endRefreshing()
            }
        }, failure: { [weak self] in
            /// hide loading indicator after a small delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.refreshControl?.endRefreshing()
                /// display error message
                let alert = UIAlertController(title: "Server error", message: "There was an issue connecting to the server. Please try again later.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self?.present(alert, animated: true)
            }
        })
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
