//
//  CarListViewController.swift
//  rDefender
//
//  Created by AlexanderN on 11/09/2019.
//  Copyright © 2019 AlexanderN. All rights reserved.
//

import UIKit

protocol CarListViewControllerDelegate: class {
    func getCarModel(carModel: String)
}

class CarListViewController: UIViewController {
    
    //TODO: Develop searching here
    
    @IBOutlet weak var mainTableView: UITableView!
    var carList: [String] = []
    
    weak var delegate: CarListViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        registerCells()
        
        carList = readDataFromCSV(fileName: "csv", fileType: "csv")
        mainTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    
    private func readDataFromCSV(fileName:String, fileType: String) -> [String] {
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
            else {
                return []
        }
        do {
            let contents = try String(contentsOfFile: filepath, encoding: .utf8)
            let contentsArray = cleanRows(file: contents)
            return contentsArray
        } catch {
            print("File Read Error for file \(filepath)")
            return []
        }
    }
    
    private func cleanRows( file: String ) -> [String] {
        let cleanFile = file
        var array = cleanFile.components(separatedBy: [";", "\n"])
        array = array.enumerated().filter { index, element in
            return index % 4 == 0
            }.map { index, element in
                return element
        }
        
        var uniqueArray = Array(Set(array)).sorted()
        uniqueArray.remove(at: 0)
        return uniqueArray
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


extension CarListViewController: UITableViewDelegate, UITableViewDataSource {
    
    fileprivate func registerCells() {
        let carModelTableViewCellNib = UINib(nibName: "CarModelTableViewCell", bundle: Bundle.main)
        mainTableView.register(carModelTableViewCellNib, forCellReuseIdentifier: "CarModelTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarModelTableViewCell", for: indexPath) as! CarModelTableViewCell
        cell.setupCell(carModel: carList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.getCarModel(carModel: carList[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}
