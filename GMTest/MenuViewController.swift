//
//  ViewController.swift
//  GMTest
//
//  Created by Alex Dontsov on 31.10.16.
//  Copyright © 2016 Kinect.Pro. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate {
    func menuItemSelected(item: City)
}

class MenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let slideMenuBackgroundColor = UIColor.darkGray
    var delegate: MenuViewControllerDelegate?
    
    var menuItems: Array<City>!
    
    struct TableView {
        struct CellIdentifiers {
            static let MenuCell = "MenuCell"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        //tableView.backgroundView?.backgroundColor = UIColor.darkGray
        tableView.backgroundColor = slideMenuBackgroundColor
        tableView.separatorStyle = .none
        self.view.backgroundColor = slideMenuBackgroundColor
    }
    
}

// MARK: Table View Data Source

extension MenuViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.MenuCell, for: indexPath)
        cell.backgroundColor = slideMenuBackgroundColor
        cell.textLabel?.text = menuItems[indexPath.row].title
        cell.textLabel?.textColor = .white
        return cell
    }
    
}

// Mark: Table View Delegate

extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = menuItems[indexPath.row]
        delegate?.menuItemSelected(item: selectedItem)
    }
}

