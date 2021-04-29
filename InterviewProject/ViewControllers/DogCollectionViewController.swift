//
//  ViewController.swift
//  InterviewProject
//
//  Created by Emelie on 2021-04-14.
//

import UIKit

class DogCollectionViewController: UIViewController {
    
    var dogs = Dog()

    private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0),
                                              collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "Pugs"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        loadData()
    }
    

    func loadData() {
        
        if(dogs.count <= 0) {
            
            guard let url = URL(string: "https://dog.ceo/api/breeds/image/random/50") else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data  = data else { return }
                do {
                    let decoder = JSONDecoder()
                    self.dogs = try decoder.decode(Dog.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.setUpCollectionView()
                    }
                } catch let err {
                    print("Err", err)
                }
            }.resume()
        }
    }
    
    private func setUpCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: (view.frame.width-60)/2, height: (view.frame.width-60)/2)

        collectionView.frame = view.frame
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DogCell")
        
        view.addSubview(collectionView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Did receive memory warning")
    }
}

//MARK: UICOllectionViewDelegate
extension DogCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let dogCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DogCell", for: indexPath as IndexPath)
        dogCell.backgroundColor = .black
        dogCell.clipsToBounds = true
        dogCell.layer.cornerRadius = 10
        
        let imageUrlString = dogs.message[indexPath.row]
        
        let imageUrl:NSURL = NSURL(string: imageUrlString)!
        
        let imageView = UIImageView(frame: CGRect(x:0, y:0, width:dogCell.frame.size.width, height:dogCell.frame.size.height))
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let imageData:NSData = NSData(contentsOf: imageUrl as URL)!
            
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                imageView.image = image
                imageView.contentMode = .scaleAspectFill
                dogCell.addSubview(imageView)
            }
        }
        return dogCell
    }
}

//MARK: UICollectionViewDataSource
extension DogCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let imageUrlString = dogs.message[indexPath.row]
        
        let dogDetailViewController = DogDetailViewController()
        dogDetailViewController.imageUrlString = imageUrlString
        navigationController?.pushViewController(dogDetailViewController, animated: true)

    }
}



