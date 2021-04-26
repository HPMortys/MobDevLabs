//
//  ListViewController.swift
//  AppMor
//
//  Created by Den Mor on 24.02.2021.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    
    @IBOutlet var table: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var Search = [Movie]()
    private var searching = false
    private var searchTitle  = [Movie]()
    
    

    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    @objc private func addTarget(){
        performSegue(withIdentifier: "addForm", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let localData = self.readLocalFile(forName: "MoviesList") {
            self.parse(jsonData: localData)
        }
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 85
        
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTarget))
              
    }
    
    
    
    func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "txt"),
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
            }
           
            
        } catch {
            print("decode error")
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchTitle.count
        } else { return Search.count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MovieCell else { return UITableViewCell()}
      
        var info_arr = [Movie]()
        
        if searching{
            info_arr = searchTitle
        }
        else {
            info_arr = Search
        }
        
        
    
        let filename = info_arr[indexPath.row].Poster
        if filename != ""{
            let image = UIImage(named: "Posters/\(filename)")
            cell.posterV.image = image
        } else {
            cell.posterV.image = UIImage()
        }
   
        
        cell.titleLbl.text = info_arr[indexPath.row].Title
        cell.yearLbl.text = info_arr[indexPath.row].Year
        cell.typeLbl.text = info_arr[indexPath.row].Type
        
       
        
        return cell
    }
    
    
    // segue TODO
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var info_arr = [Movie]()
        if searching{
            info_arr = searchTitle
        }
        else {
            info_arr = Search
        }
        
        if (info_arr[(table.indexPathForSelectedRow?.row)!].imdbID) != "noid"{
            performSegue(withIdentifier: "showDetails", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        var info_arr = [Movie]()
        if searching{
            info_arr = searchTitle
        }
        else {
            info_arr = Search
        }
        
    
        if segue.identifier == "showDetails"
        {
        if let localData = self.readLocalFile(forName: "Programming assignment 4 1/\(info_arr[(table.indexPathForSelectedRow?.row)!].imdbID)") {
            
            
            do {
                let decoded_movie = try JSONDecoder().decode(Movie.self,
                                                           from: localData)
                
                if let destionation = segue.destination as? MovieInfoViewController{
                    destionation.movie = decoded_movie       }
        
            } catch {
                print("decode error")
            }
        }
        }
    }
    
    
    // delete TODO
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            table.beginUpdates()
            if searching{
                searchTitle.remove(at: indexPath.row)
                table.deleteRows(at: [indexPath], with: .fade)
            }else {
                Search.remove(at: indexPath.row)
                table.deleteRows(at: [indexPath], with: .fade)
            }
            table.endUpdates()
        }
    }
    
    
    // search TODO
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            searching = false
        }
        else {
            searchTitle = Search.filter({$0.Title.prefix(searchText.count) == searchText})
            searching = true
        }
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false 
    }
    
    
    //add new movie
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
    
}


