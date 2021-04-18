//
//  ViewController.swift
//  InterviewProject
//
//  Created by Emelie on 2021-04-14.
//

import UIKit

//  api avail at https://dog.ceo/api/breeds/image/random/50
//The basic feature set of the app is: 
//- Get list of dog photos from the JSON API  - Show a gallery view of all dog photos 
//- Show a detail view for a single dog photo - Make the app as user-friendly as you can.




class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var apiData = ApiData()
    
    var myCollectionView: UICollectionView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pugs"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 180, height: 180)
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView!.dataSource = self
        myCollectionView!.delegate = self
        myCollectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView!.backgroundColor = .white
        self.view.addSubview(myCollectionView!)
        
        loadData()

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.apiData.message.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath)
        myCell.backgroundColor = .black
        
        myCell.layer.cornerRadius = 10
        
        let imageUrlString = self.apiData.message[indexPath.row]
        
        let imageUrl:NSURL = NSURL(string: imageUrlString)!
        
        let imageView = UIImageView(frame: CGRect(x:0, y:0, width:myCell.frame.size.width, height:myCell.frame.size.height))
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let imageData:NSData = NSData(contentsOf: imageUrl as URL)!
            
            DispatchQueue.main.async {
                
                let image = UIImage(data: imageData as Data)
                imageView.image = image
                imageView.contentMode = .scaleAspectFit
                myCell.addSubview(imageView)
            }
        }
        
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("User tapped on item \(indexPath.row)")
        
        let imageUrlString = self.apiData.message[indexPath.row]
        
        let detailViewController = DetailViewController()
        detailViewController.imageUrlString = imageUrlString
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
        print("Image url = \(imageUrlString)")
    }
    
    func loadData() {
        
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random/50") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data  = data else { return }
            do {
                let decoder = JSONDecoder()
                self.apiData = try decoder.decode(ApiData.self, from: data)
                print(self.apiData.message)
                
                DispatchQueue.main.async {
                    self.myCollectionView!.reloadData()
                }

            } catch let err {
                print("Err", err)
            }
        }.resume()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

