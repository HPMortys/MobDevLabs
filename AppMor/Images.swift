//
//  Images.swift
//  AppMor
//
//  Created by Den Mor on 17.04.2021.
//

import Foundation

class Images_data: Codable{
    let hits: [Images]
    
    init(hits: [Images]){
        self.hits = hits
    }
}


class Images: Codable {
    let previewURL : String
    
    
    init(previewURL : String){
        self.previewURL = previewURL
    
        
    }
    
}
