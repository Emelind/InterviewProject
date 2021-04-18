//
//  DetailViewController.swift
//  InterviewProject
//
//  Created by Emelie on 2021-04-18.
//

import UIKit

class DetailViewController: UIViewController {
    
    var imageUrlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.title = "Really cute pug"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let imageUrl = imageUrlString {
            
            let url:NSURL = NSURL(string: imageUrl)!
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
            
            DispatchQueue.global(qos: .userInitiated).async {
                
                let imageData:NSData = NSData(contentsOf: url as URL)!
                
                DispatchQueue.main.async {
                    
                    let image = UIImage(data: imageData as Data)
                    imageView.image = image
                    imageView.contentMode = UIView.ContentMode.scaleAspectFit
                    
                    self.view.addSubview(imageView)
                }
            }
        }
    }
}
