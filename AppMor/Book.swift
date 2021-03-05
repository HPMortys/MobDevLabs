//
//  Book.swift
//  AppMor
//
//  Created by Den Mor on 24.02.2021.
//

import Foundation

class Books: Codable{
    let books: [Book]
    
    init(books: [Book]){
        self.books = books
    }
}


class Book: Codable {
    let title : String
    let subtitle: String
    let isbn13: String
    let price: String
    let image: String

    
    init(title : String, subtitle: String, isbn13: String, price: String, image: String ){
        self.title = title
        self.subtitle = subtitle
        self.isbn13 = isbn13
        self.price = price
        self.image = image
    }
    
}
