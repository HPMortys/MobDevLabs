//
//  Movie.swift
//  AppMor
//
//  Created by Den Mor on 24.02.2021.
//

import Foundation

class Movies: Codable{
    let Search: [Movie]
    
    init(Search: [Movie]){
        self.Search = Search
    }
}


class Movie: Codable {
    let Title : String
    let Year: String
    let imdbID: String
    let `Type`: String
    let Poster: String
    
    
    init(Title : String, Year: String, imdbID: String, Type: String, Poster: String){
        self.Title = Title
        self.Year = Year
        self.imdbID = imdbID
        self.Type = Type
        self.Poster = Poster
    }
    
}
