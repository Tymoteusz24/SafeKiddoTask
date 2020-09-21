//
//  TableViewController.swift
//  SafeKiddoRecruitmentTask
//
//  Created by Tymoteusz Pasieka on 20/09/2020.
//  Copyright © 2020 Tymoteusz Pasieka. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    private var tableViewModel = DataListViewModel(networkingManager: NetworkingManager())


    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewModel.populateViewModel(url: "https://run.mocky.io/v3/f3b71af6-6dc6-40c5-aee1-5a6944f94b57") { [weak self] (err) in
            
            if let error = err {
                print(error)
            }
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }
       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell else {
            return UITableViewCell()
        }
        
        let cellViewModel = tableViewModel.cellViewModel(index: indexPath.row)
        cell.viewModel = cellViewModel
        print(indexPath.row)
        
        return cell
    }
  
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }


}
