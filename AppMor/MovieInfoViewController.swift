//
//  MovieInfoViewController.swift
//  AppMor
//
//  Created by Den Mor on 06.03.2021.
//

import UIKit

class MovieInfoViewController: UIViewController {

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
    
    @IBOutlet var awardsLbl: UILabel!
    @IBOutlet var ratingLbl: UILabel!
    @IBOutlet var plotLbl: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        

        let filename = (movie?.Poster)!
        if filename != ""{
            let image = UIImage(named: "Posters/\(filename)")
            infoposter.image = image
        } else {
            infoposter.image = UIImage()
        }



        titleLbl.text = "Title: " + movie!.Title
        YearLbl.text = "Year: " + movie!.Year
        genreLbl.text = "Genre: " + movie!.Genre!
        directorLbl.text = "Director: " + movie!.Director!
        actorsLbl.text = "Actors: " + movie!.Actors!
        countryLbl.text = "Country: " + movie!.Country!
        languageLbl.text = "Language: "  + movie!.Language!
        productionLbl.text = "Production: " + movie!.Production!
        releasedLbl.text = "Realeased: " + movie!.Released!
        runtimeLbl.text = "Runtime: " + movie!.Runtime!
        awardsLbl.text  = "Awards: " + movie!.Awards!
        ratingLbl.text = "Rating: " + movie!.imdbRating!
        plotLbl.text = "Plot: " + movie!.Plot!
        
        
    }
    
}
