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
    
    var PG: String?
    var Released: String?
    var Runtime: String?
    var Genre: String?
    var Director: String?
    var Writer: String?
    var Actors: String?
    var Plot: String?
    var Language: String?
    var Country: String?
    var Awards: String?
    var imdbRating: String?
    var imdbVotes: String?
    var Production: String?
    
    init(Title : String, Year: String, imdbID: String, Type: String, Poster: String,
    PG: String = "",
     Released: String = "",
     Runtime: String = "",
     Genre: String = "",
     Director: String = "",
     Writer: String = "",
     Actors: String = "",
     Plot: String = "",
     Language: String = "",
     Country: String = "",
     Awards: String = "",
     imdbRating: String = "",
     imdbVotes: String = "",
     Production: String = ""
    
    ){
        self.Title = Title
        self.Year = Year
        self.imdbID = imdbID
        self.Type = Type
        self.Poster = Poster
        self.PG = PG
        self.Released = Released
        self.Runtime = Runtime
        self.Genre = Genre
        self.Director = Director
        self.Writer = Writer
        self.Actors = Writer
        self.Plot = Plot
        self.Language = Language
        self.Country = Country
        self.Awards = Awards
        self.imdbRating = imdbID
        self.imdbVotes = imdbVotes
        self.Production = Production
        
    }
    
}
