//
//  ListViewController.swift
//  AppMor
//
//  Created by Den Mor on 24.02.2021.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource {
    
    private var Search = [Movie]()
    @IBOutlet var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let localData = self.readLocalFile(forName: "MoviesList") {
            self.parse(jsonData: localData)
        }
        table.tableFooterView = UIView()
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 85
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
            let decoded_movies = try JSONDecoder().decode(Movies.self,
                                                       from: jsonData)
            
            self.Search = decoded_movies.Search
        
            DispatchQueue.main.async {
                self.table.reloadData()
                self.table.dataSource = self
            }
           
            
        } catch {
            print("decode error")
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Search.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MovieCell else { return UITableViewCell()}
      
        
        let filename = Search[indexPath.row].Poster
        if filename != ""{
            let image = UIImage(named: "Posters/\(filename)")
            cell.posterV.image = image
        } else {
            cell.posterV.image = UIImage()
        }
   

        cell.titleLbl.text = Search[indexPath.row].Title
        cell.yearLbl.text = Search[indexPath.row].Year
        cell.typeLbl.text = Search[indexPath.row].Type
    
        
        return cell
    }
}

