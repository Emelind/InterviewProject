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
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let gradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
        gradient.locations = [0.2, 0.5]
        return gradient
    }()
        
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is a really \ncute pug!"
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .black
        return label
    }()
    
    
    // TRY TO ADD SCROLL
//    private let scrollView: UIScrollView = {
//        let view = UIScrollView()
//        view.backgroundColor = .blue
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    private let descLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Doggo ipsum pupper woofer you are doing me a frigthen fluffer borkdrive heckin smol borking doggo with a long snoot for pats, doggorino such treat shoober wrinkler thicc. \n\nVery jealous pupper very good snot noodle horse shooberino you are doing me the shock extremely cuuuuuute, shibe heckin good boys and girls sub woofer heckin angery woofer."
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0
        label.numberOfLines = 10
        

        label.textColor = .darkText
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addSubViews()
        
        setUpAutoLayout()
    }
    
    // Try to get title in ViewController to go back to large
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.tintColor = .systemPink
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        self.title = "Really cute pug"
        
        loadImage()
    }
    
    private func loadImage() {
        
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
    
    private func addSubViews() {
        
        detailView.addSubview(imageView)
        view.addSubview(detailView)
        gradientView.frame = view.frame
        gradient.frame = gradientView.frame
        gradientView.layer.insertSublayer(gradient, at: 0)
        imageView.addSubview(gradientView)
        imageView.bringSubviewToFront(gradientView)
        
        
        // TRY TO ADD SCROLL
        //scrollView.frame = view.bounds
        //scrollView.contentSize = descLabel.bounds.size
        //scrollView.autoresizingMask = .flexibleHeight
        //scrollView.addSubview(descLabel)
        //detailView.addSubview(scrollView)
        
        detailView.addSubview(headerLabel)
        
        detailView.addSubview(descLabel)
    }
    
    private func setUpAutoLayout() {
        
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
        
        // TRY TO ADD SCROLL
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 30),
//            scrollView.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 20),
//            scrollView.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -20),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
        
        NSLayoutConstraint.activate([
            descLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 30),
            descLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 20),
            descLabel.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -20)
        ])
    }
}
