//
//  DetailViewController.swift
//  InterviewProject
//
//  Created by Emelie on 2021-05-09.
//

import UIKit

class DogDetailViewController: UIViewController, UIScrollViewDelegate {
    
    var imageUrlString: String?
    
    let dogDetailScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private let dogDetailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let dogDetailImageGradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dogDetailGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
        gradient.locations = [0.1, 0.9]
        return gradient
    }()
    
    private let dogDetailHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "This is a really cute pug!"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dogDetailTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Doggo ipsum pupper woofer you are doing me a frigthen fluffer borkdrive heckin smol borking doggo with a long snoot for pats, doggorino such treat shoober wrinkler thicc. \n\nVery jealous pupper very good snot noodle horse shooberino you are doing me the shock extremely cuuuuuute, shibe heckin good boys and girls sub woofer heckin angery woofer.\n\nVery jealous pupper very good snot noodle horse shooberino you are doing me the shock extremely cuuuuuute, shibe heckin good boys and girls sub woofer heckin angery woofer.\n\nVery jealous pupper very good snot noodle horse shooberino you are doing me the shock extremely cuuuuuute, shibe heckin good boys and girls sub woofer heckin angery woofer."
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dogDetailScrollView.delegate = self
        dogDetailScrollView.frame = view.frame
        
        loadImage()
        addSubviews()
        addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.tintColor = .systemPink
        navigationItem.largeTitleDisplayMode = .never
        title = "Really cute pug"
    }
    
    private func loadImage() {
        if let imageUrl = imageUrlString {
            let url:NSURL = NSURL(string: imageUrl)!
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData:NSData = NSData(contentsOf: url as URL)!
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData as Data)
                    self.dogDetailImageView.image = image
                }
            }
        }
    }
    
    private func addSubviews() {
        dogDetailImageGradientView.layer.insertSublayer(dogDetailGradient, at: 0)
        dogDetailImageView.addSubview(dogDetailImageGradientView)
        dogDetailImageView.bringSubviewToFront(dogDetailImageGradientView)
        dogDetailImageView.addSubview(dogDetailHeaderLabel)
        
        dogDetailScrollView.addSubview(dogDetailImageView)
        dogDetailScrollView.addSubview(dogDetailTextLabel)
        
        view.addSubview(dogDetailScrollView)
    }
    
    private func addConstraints() {
        dogDetailImageView.topAnchor.constraint(equalTo: dogDetailScrollView.topAnchor).isActive = true
        dogDetailImageView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        dogDetailImageView.heightAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true
        
        dogDetailImageGradientView.topAnchor.constraint(equalTo: dogDetailScrollView.topAnchor).isActive = true
        dogDetailImageGradientView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        dogDetailImageGradientView.heightAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true
        
        let gradientFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/2)
        dogDetailGradient.frame = gradientFrame
        
        dogDetailHeaderLabel.widthAnchor.constraint(equalToConstant: view.frame.width/1.5).isActive = true
        dogDetailHeaderLabel.leadingAnchor.constraint(equalTo: dogDetailImageView.leadingAnchor, constant: 20).isActive = true
        dogDetailHeaderLabel.bottomAnchor.constraint(equalTo: dogDetailImageView.bottomAnchor).isActive = true
        
        dogDetailTextLabel.topAnchor.constraint(equalTo: dogDetailImageView.bottomAnchor, constant: 20).isActive = true
        dogDetailTextLabel.leadingAnchor.constraint(equalTo: dogDetailScrollView.leadingAnchor, constant: 20).isActive = true
        dogDetailTextLabel.trailingAnchor.constraint(equalTo: dogDetailScrollView.trailingAnchor, constant: -20).isActive = true
        dogDetailTextLabel.widthAnchor.constraint(equalToConstant: view.frame.width-40).isActive = true
        dogDetailTextLabel.bottomAnchor.constraint(equalTo: dogDetailScrollView.bottomAnchor).isActive = true
    }
}
