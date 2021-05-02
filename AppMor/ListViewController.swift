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
    
    @IBOutlet weak var indicator_table: UIActivityIndicatorView!
    
    var Search = [Movie]()
    private var url_data = URL(string: "")
  
    
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

        self.indicator_table.isHidden = true
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

        
        cell.titleLbl.text = info_arr[indexPath.row].Title
        cell.yearLbl.text = info_arr[indexPath.row].Year
        cell.typeLbl.text = info_arr[indexPath.row].Type
        if let url_data: URL = URL(string: info_arr[indexPath.row].Poster){
                cell.loadImage(from: url_data)
        }
        
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
   
      
            var url_string = "http://www.omdbapi.com/?apikey=7e9fe69e&i=\(info_arr[table.indexPathForSelectedRow!.row].imdbID)"
            url_string = url_string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let url_segue = URL(string: url_string) ?? URL(string: "")
            if let destionation = segue.destination as? MovieInfoViewController{
          
                destionation.url_data_segue = url_segue
               
            }
            

            

            
        
        }
    }
    
    
    
    
    func fetchData(onCompletion: @escaping ([Movie]) -> ()) {
        if self.url_data != nil {
            URLSession.shared.dataTask(with: self.url_data!) { data, response, error in
            if error == nil, let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200{
              if let data = data {
                do {
                    let res = try JSONDecoder().decode(Movies.self, from: data)
                    if res.Response == "True"{
                        onCompletion(res.Search!)
                    }
                    
                  } catch let error {
                     print(error)
                  }
               }
            }
           }.resume()
        }
    }
  
    
    // search TODO
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            self.indicator_table.isHidden = true
        }
        else {
            searching = true
            if searchText.count > 3 {
                self.indicator_table.isHidden = false
                self.indicator_table.startAnimating()
                var url_string = "http://www.omdbapi.com/?apikey=7e9fe69e&s=\(searchText)&page=1"
                url_string = url_string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                self.url_data = URL(string: url_string) ?? URL(string: "")
               
                
                let getdataFunc = { (fetchData: [Movie]) in
                    DispatchQueue.main.async {
                        self.searchTitle = fetchData
                        self.indicator_table.stopAnimating()
                        self.indicator_table.isHidden = true
                        self.table.reloadData()
                    }
                }
                fetchData(onCompletion: getdataFunc)
                
            }
            else {
                self.searchTitle.removeAll()
                self.table.reloadData()
            }
            
        }
    }
    
    
    private func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.indicator_table.isHidden = true
        self.searchTitle.removeAll()
        self.table.reloadData()
    }
    
    
    //add new movie
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
    
}


