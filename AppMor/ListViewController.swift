//
//  ListViewController.swift
//  AppMor
//
//  Created by Den Mor on 24.02.2021.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource {
    
    private var books = [Book]()
    @IBOutlet var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let localData = self.readLocalFile(forName: "BooksList") {
            self.parse(jsonData: localData)
        }
        table.tableFooterView = UIView()
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 600
    }
    
    func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
   
    
    func parse(jsonData: Data) {
        do {
            let decoded_books = try JSONDecoder().decode(Books.self,
                                                       from: jsonData)
            self.books = decoded_books.books
            
            DispatchQueue.main.async {
                self.table.reloadData()
                self.table.dataSource = self
            }
           
            
        } catch {
            print("decode error")
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell") as? BookCell else { return UITableViewCell()}
        
        
        let filename = books[indexPath.row].image
        if filename != ""{
            let image = UIImage(named: "Images/\(filename)")
            cell.imageV.image = image
        } else {
            cell.imageV.image = UIImage()
        }
        

        cell.titleLbl.text = books[indexPath.row].title
        cell.subtitleLbl.text = books[indexPath.row].subtitle
        cell.priceLbl.text = books[indexPath.row].price
    
        
        return cell
    }
}

