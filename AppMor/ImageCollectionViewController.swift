//
//  ImageCollectionViewController.swift
//  AppMor
//
//  Created by Den Mor on 11.04.2021.
//

import UIKit

class ImageCollectionViewController: UIViewController{
  
    @IBOutlet weak var collectionView: UICollectionView!
        
    var dataModel: [AnyObject] = []
    
    @objc private func addImageTarget(){
        showImagePickerController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.collectionViewLayout = ImageCollectionViewController.createLayout()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addImageTarget))
        let getdataFunc = { (fetchData: [Images]) in
            DispatchQueue.main.async {
                self.dataModel = fetchData
                self.collectionView.reloadData()
            }
        }
        
        fetchData(onCompletion: getdataFunc)
    }
     
    func fetchData(onCompletion: @escaping ([Images]) -> ()) {
        if let url = URL(string: "https://pixabay.com/api/?key=19193969-87191e5db266905fe8936d565&q=small+animals&image_type=photo&per_page=18") {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                do {
                    let res = try JSONDecoder().decode(Images_data.self, from: data)
            
                    onCompletion(res.hits)
                    
                  } catch let error {
                     print(error)
                  }
               }
           }.resume()
        }
    }
    
    static func createLayout () -> UICollectionViewCompositionalLayout{
        // items
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(1)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2, leading: 2, bottom: 2, trailing: 2
        )
        //------
         let verticalStackItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1/2)            )
         )
        
        verticalStackItem.contentInsets = NSDirectionalEdgeInsets(
            top: 2, leading: 2, bottom: 2, trailing: 2
        )
        //------
        let tripleItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .fractionalHeight(1)
        ))
        
        tripleItem.contentInsets = NSDirectionalEdgeInsets(
            top: 2, leading: 2, bottom: 2, trailing: 2
        )
        
        //group
        let tripleHorizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1/4)
        ), subitem: tripleItem,
        count: 3)
        
        let VerticalStackGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(2/5),
            heightDimension: .fractionalWidth(4/5)
        ),
        subitem: verticalStackItem,
        count: 2)
        
        let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(3/5),
                    heightDimension: .fractionalWidth(4/5)),
               subitems: [item,
                    tripleHorizontalGroup])
        
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(4/5)
        ), subitems: [group, VerticalStackGroup]
        )
        
        //section
        let section = NSCollectionLayoutSection(group: horizontalGroup)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
}
    

extension ImageCollectionViewController: UICollectionViewDataSource {
        
    //count images
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel.count
    }

    //cell View
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as? CustomCollectionViewCell {

            cell.imageView.contentMode = .scaleAspectFit
            
            if let data_from_list = dataModel[indexPath.row] as? Images{
                if let url_data: URL = URL(string: data_from_list.previewURL){
                        cell.loadImage(from: url_data)
                }
            }else if let data_from_list = dataModel[indexPath.row] as? UIImage{
                cell.imageView.image = data_from_list
            }
            
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 0
            cell.backgroundColor = .black
            
            return cell
        }
        return UICollectionViewCell()
    }
}

//Picker
extension ImageCollectionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showImagePickerController(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            dataModel.append(originalImage)
            self.collectionView.reloadData()
        }

        dismiss(animated: true, completion: nil)
    }
}
