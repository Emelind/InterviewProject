//
//  DetailViewController.swift
//  InterviewProject
//
//  Created by Emelie on 2021-04-18.
//

import UIKit

class DogDetailViewController: UIViewController {
    
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
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .black
        return label
    }()
    
    private let descLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Doggo ipsum pupper woofer you are doing me a frigthen fluffer borkdrive heckin smol borking doggo with a long snoot for pats, doggorino such treat shoober wrinkler thicc. \n\nVery jealous pupper very good snot noodle horse shooberino you are doing me the shock extremely cuuuuuute, shibe heckin good boys and girls sub woofer heckin angery woofer."
        
        // Adjusting font size if text exceeds the boundings, as I could not get scrollview to work
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.tintColor = .systemPink
        navigationItem.largeTitleDisplayMode = .never
        title = "Really cute pug"
        
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
            detailView.heightAnchor.constraint(equalToConstant: viewFrame.height),

            imageView.widthAnchor.constraint(equalToConstant: viewFrame.width),
            imageView.heightAnchor.constraint(equalToConstant: viewFrame.height/2),

            headerLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -40),
            headerLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 20),

            descLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 30),
            descLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 20),
            descLabel.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -20)
        ])
    }
}
