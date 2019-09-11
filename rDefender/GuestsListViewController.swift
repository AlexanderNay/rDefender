//
//  GuestsListViewController.swift
//  rDefender
//
//  Created by AlexanderN on 09/09/2019.
//  Copyright © 2019 AlexanderN. All rights reserved.
//

import UIKit

class GuestsListViewController: UIViewController {
    
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var listOfGuests = [Guest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        registrationCells()
        setupUI()
        loadData()

        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        mainTableView.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.07450980392, blue: 0.03921568627, alpha: 1)
    }
    
    
    private func loadData() {
        //TODO: Activity indicator
        DBManager.shared.getGuests { (results, error) in
            guard let results = results else { return }
            let guests = results.documents.map {Guest(data: $0.data())}
            self.listOfGuests = guests
            self.mainTableView.reloadData()
        }
    }

}

extension GuestsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func registrationCells() {
        let guestTableViewCellNib = UINib(nibName: "GuestTableViewCell", bundle: Bundle.main)
        mainTableView.register(guestTableViewCellNib, forCellReuseIdentifier: "GuestTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfGuests.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GuestTableViewCell", for: indexPath) as! GuestTableViewCell
        cell.setupCell(guest: listOfGuests[indexPath.row])
        return cell
    }
    
    
}
