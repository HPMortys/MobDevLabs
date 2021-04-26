//
//  MovieAddForm.swift
//  AppMor
//
//  Created by Den Mor on 19.03.2021.
//

import UIKit

class MovieAddForm: UIViewController {



    @IBOutlet weak var addTitleLbl: UITextField!
    @IBOutlet weak var addTypeLbl: UITextField!
    @IBOutlet weak var addYearLbl: UITextField!
    
  
    
    

    var activeTextField : UITextField? = nil
    

    @IBAction func addMovieBtn(_ sender: UIButton) {
        let addMovie_val = Movie(Title: addTitleLbl.text ?? "", Year: addYearLbl.text ?? "", imdbID: "noid", Type: addTypeLbl.text ?? "None", Poster: "")
        
        let valid_year = Int(addMovie_val.Year) != nil
        let valid_title = addMovie_val.Title.replacingOccurrences(of: " ", with: "") != ""
        
        if valid_year && valid_title{
            guard let new_movie = navigationController?.viewControllers.first as? ListViewController else { return }
            new_movie.Search.append(addMovie_val)
            _ = navigationController?.popViewController(animated: true)
        }
        else{
            if !valid_title{
                addTitleLbl.text = ""
                addTitleLbl.placeholder = "title value is invalid"
            }
            if !valid_year{
                addYearLbl.text = ""
                addYearLbl.placeholder = "year value is invalid"
            }
        }
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

   
}


