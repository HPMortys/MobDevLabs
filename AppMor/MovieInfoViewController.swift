//
//  MovieInfoViewController.swift
//  AppMor
//
//  Created by Den Mor on 06.03.2021.
//

import UIKit

class MovieInfoViewController: UIViewController {

    var task: URLSessionDataTask!

    
    @IBOutlet var infoposter: UIImageView!
    
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var YearLbl: UILabel!
    @IBOutlet var genreLbl: UILabel!
    @IBOutlet var directorLbl: UILabel!
    @IBOutlet var actorsLbl: UILabel!
    @IBOutlet var countryLbl: UILabel!
    @IBOutlet var languageLbl: UILabel!
    @IBOutlet var productionLbl: UILabel!
    @IBOutlet var releasedLbl: UILabel!
    @IBOutlet var runtimeLbl: UILabel!
    
    @IBOutlet weak var indicator_segue: UIActivityIndicatorView!
    @IBOutlet var awardsLbl: UILabel!
    @IBOutlet var ratingLbl: UILabel!
    @IBOutlet var plotLbl: UILabel!
    
    var movie: Movie?
    var url_data_segue = URL(string: "")
    
    func loadImage(from url: URL) {
        
        if let task = task{
            task.cancel()
        }
        
        task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard
                let data = data, error == nil,
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let newImage = UIImage(data: data)
            
            else {
                print("error")
                return
            }
            
            DispatchQueue.main.async {
                self.infoposter.image = newImage
        
              
            }
        }
        
        task.resume()
        
    }
    
    
    func fetchDataSegue(onCompletion: @escaping (Movie) -> ()) {
        if self.url_data_segue != nil {
            URLSession.shared.dataTask(with: self.url_data_segue!) { data, response, error in
            if error == nil, let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200{
              if let data = data {
                do {
                    let res = try JSONDecoder().decode(Movie.self, from: data)
                   
                        onCompletion(res)
                    
                  } catch let error {
                     print(error)
                  }
               }
            }
           }.resume()
        }
    }
    
    override func viewDidLoad() {
        self.indicator_segue.isHidden = false
        self.indicator_segue.startAnimating()
        let getdataFuncSegue = { (fetchDataSegue: Movie) in
            DispatchQueue.main.async {
                if let url_poster = URL(string: fetchDataSegue.Poster){
                    self.loadImage(from: url_poster)
                }
            
                self.titleLbl.text = "Title: \(fetchDataSegue.Title)"
                self.YearLbl.text = "Year: \(fetchDataSegue.Year)"
                self.genreLbl.text = "Genre: \(fetchDataSegue.Genre ?? "")"
                self.directorLbl.text = "Director: \(fetchDataSegue.Director ?? "")"
                self.actorsLbl.text = "Actors: \(fetchDataSegue.Actors ?? "")"
                self.countryLbl.text = "Country: \(fetchDataSegue.Country ?? "")"
                self.languageLbl.text = "Language: \(fetchDataSegue.Language ?? "")"
                self.productionLbl.text = "Production: \(fetchDataSegue.Production ?? "")"
                self.releasedLbl.text = "Realeased: \(fetchDataSegue.Released ?? "")"
                self.runtimeLbl.text = "Runtime: \(fetchDataSegue.Runtime ?? "")"
                self.awardsLbl.text  = "Awards:  \(fetchDataSegue.Awards ?? "")"
                self.ratingLbl.text = "Rating: \(fetchDataSegue.imdbRating ?? "")"
                self.plotLbl.text = "Plot: \(fetchDataSegue.Plot ?? "")"
                
                
                self.indicator_segue.stopAnimating()
                self.indicator_segue.isHidden = true
                
            }
            
           
        }
        fetchDataSegue(onCompletion: getdataFuncSegue)

    }

}
