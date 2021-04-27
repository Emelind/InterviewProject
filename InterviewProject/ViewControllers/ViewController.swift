//
//  ViewController.swift
//  InterviewProject
//
//  Created by Emelie on 2021-04-14.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var apiData = ApiData()
    
    var myCollectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        
        // Try to get title in DetailVC to go back to small, when jumping between VCs
        //navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Pugs"
        
        // Large title only works correctly first time. When jumping between VCs, title display differs from time to time.. ? Below, try to fix. Not working.
        //self.navigationController?.navigationBar.prefersLargeTitles = true
        //navigationItem.largeTitleDisplayMode = .always
        
        setUpCollectionView()
        
        self.view.addSubview(myCollectionView!)
        
        loadData()

    }
    
    private func setUpCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: (view.frame.width-60)/2, height: (view.frame.width-60)/2)
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView!.dataSource = self
        myCollectionView!.delegate = self
        myCollectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView!.backgroundColor = .white
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.apiData.message.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath)
        myCell.backgroundColor = .black
        myCell.clipsToBounds = true
        myCell.layer.cornerRadius = 10
        
        let imageUrlString = self.apiData.message[indexPath.row]
        
        let imageUrl:NSURL = NSURL(string: imageUrlString)!
        
        let imageView = UIImageView(frame: CGRect(x:0, y:0, width:myCell.frame.size.width, height:myCell.frame.size.height))
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let imageData:NSData = NSData(contentsOf: imageUrl as URL)!
            
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                imageView.image = image
                imageView.contentMode = .scaleAspectFill
                myCell.addSubview(imageView)
            }
        }
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let imageUrlString = self.apiData.message[indexPath.row]
        
        let detailViewController = DetailViewController()
        detailViewController.imageUrlString = imageUrlString
        self.navigationController?.pushViewController(detailViewController, animated: true)

    }
    
    func loadData() {
        
        if(apiData.count <= 0) {
            guard let url = URL(string: "https://dog.ceo/api/breeds/image/random/50") else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data  = data else { return }
                do {
                    let decoder = JSONDecoder()
                    self.apiData = try decoder.decode(ApiData.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.myCollectionView!.reloadData()
                    }
                } catch let err {
                    print("Err", err)
                }
            }.resume()
            
        } else {
            print("Count: \(apiData.count)")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Did receive memory warning")
    }
}

