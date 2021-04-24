//
//  DetailViewController.swift
//  InterviewProject
//
//  Created by Emelie on 2021-04-18.
//

import UIKit

class DetailViewController: UIViewController {
    
    var imageUrlString: String?
    
    private let detailView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is a really \ncute pug!"
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 30)
        label.backgroundColor = .blue
        return label
    }()
    
    private let descLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Doggo ipsum pupper woofer you are doing me a frigthen fluffer borkdrive heckin smol borking doggo with a long snoot for pats, doggorino such treat shoober wrinkler thicc. \n\nVery jealous pupper very good snot noodle horse shooberino you are doing me the shock extremely cuuuuuute, shibe heckin good boys and girls sub woofer heckin angery woofer."
        label.numberOfLines = 0
        label.backgroundColor = .red
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.title = "Really cute pug"
        
        detailView.addSubview(imageView)
        detailView.addSubview(headerLabel)
        detailView.addSubview(descLabel)
        
        view.addSubview(detailView)
        
        setUpAutoLayout()
        
        //self.navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let imageUrl = imageUrlString {
            
            let url:NSURL = NSURL(string: imageUrl)!
            
            DispatchQueue.global(qos: .userInitiated).async {
                
                let imageData:NSData = NSData(contentsOf: url as URL)!
                
                DispatchQueue.main.async {
                    
                    let image = UIImage(data: imageData as Data)
                    self.imageView.image = image
                }
            }
        }
    }
    
    func setUpAutoLayout() {
        
        let safeArea = view.safeAreaLayoutGuide
        let viewFrame = view.bounds
        
        NSLayoutConstraint.activate([
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            detailView.widthAnchor.constraint(equalToConstant: viewFrame.width),
            detailView.heightAnchor.constraint(equalToConstant: viewFrame.height)
        ])
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: viewFrame.width),
            imageView.heightAnchor.constraint(equalToConstant: viewFrame.height/2)
            
        ])
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -40),
            headerLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            descLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 30),
            descLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 20),
            descLabel.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -20)
        ])

    }
}
