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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    
        loadData()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: 140, height: 140)
        
        let myCollectionView:UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView.backgroundColor = UIColor.white
        self.view.addSubview(myCollectionView)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        myCell.backgroundColor = UIColor.blue
        
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("User tapped on item \(indexPath.row)")
    }
    
    func loadData() {
        
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random/50") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data  = data else { return }
            do {
                let decoder = JSONDecoder()
                self.apiData = try decoder.decode(ApiData.self, from: data)
                print(self.apiData.message)
                
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

