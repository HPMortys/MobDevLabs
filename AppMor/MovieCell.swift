//
//  MovieCell.swift
//  AppMor
//
//  Created by Den Mor on 03.03.2021.
//

import UIKit

class MovieCell: UITableViewCell {
 
    @IBOutlet var posterV: UIImageView!
 
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var yearLbl: UILabel!
    @IBOutlet var typeLbl: UILabel!
    
    var task: URLSessionDataTask!
    let imageCache = NSCache<AnyObject, AnyObject>()    
    
    func loadImage(from url: URL) {
        posterV.image = nil
//        self.indicator.stopAnimating()
        
        if let task = task{
            task.cancel()
        }
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage{
            self.posterV.image = imageFromCache
            return
        }
        
        task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard
                let data = data, error == nil,
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let newImage = UIImage(data: data)
            
            else {
                print("error1")
                return
            }
            
            self.imageCache.setObject(newImage, forKey:  url.absoluteString as AnyObject)
            
            DispatchQueue.main.async {
                self.posterV.image = newImage
//                self.indicator.isHidden = true
//                self.indicator.stopAnimating()
            }
        }
        
        task.resume()
        
    }
    
}
