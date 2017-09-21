//
//  DataShowVC.swift
//  CoreDataDemo
//
//  Created by appinventiv on 20/09/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//

import UIKit

class DataShowVC: UIViewController {

    var arr = [String]()
    var passarr = [String]()
    var headerValue = ["UserName", "Password"]
    
    @IBOutlet weak var tableViewOutlet: UITableView!

    
    @IBAction func backBtn(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibCell = UINib(nibName: "CellOfTableView", bundle: nil)
        tableViewOutlet.register(nibCell, forCellReuseIdentifier: "CellOfTableViewId")
        
        let nibHeader = UINib(nibName: "HeaderOfTableView", bundle: nil)
        tableViewOutlet.register(nibHeader, forHeaderFooterViewReuseIdentifier: "HeaderOfTableViewId")
        
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        
        
        print("Datashow array value is \(arr)")
    }

  }

extension DataShowVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellOfTableViewId", for: indexPath) as? CellOfTableView else {fatalError("unable to make cell")}
       
        switch indexPath.section {
        case 0:
             cell.userNamelabel.text = arr[indexPath.row]
        default:
             cell.userNamelabel.text = passarr[indexPath.row]
        }
       // cell.userNamelabel.text = arr[indexPath.row]
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderOfTableViewId") as? HeaderOfTableView else {fatalError("unable to make header")}
        
        header.headerLabel.text = headerValue[section]
        header.contentView.backgroundColor = UIColor.cyan
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerValue.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    
    
}
