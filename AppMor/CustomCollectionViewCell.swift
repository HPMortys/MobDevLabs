//
//  CustomCollectionViewCell.swift
//  AppMor
//
//  Created by Den Mor on 12.04.2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var task: URLSessionDataTask!
    
    func loadImage(from url: URL) {
        self.indicator.stopAnimating()
        
        if let task = task{
            task.cancel()
        }
        
        task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard
                let data = data,
                let newImage = UIImage(data: data)
            
            else {
                print("error")
                return
            }
            
            DispatchQueue.main.async {
                self.imageView.image = newImage
                self.indicator.isHidden = true
                self.indicator.stopAnimating()
            }
        }
        
        task.resume()
        
    }
}
