//
//  DetailViewController.swift
//  InterviewProject
//
//  Created by Emelie on 2021-04-18.
//

import UIKit

class DogDetailViewController: UIViewController {
    
    var imageUrlString: String?
    
    //TEST TABLEVIEW
    private var tableView: UITableView = {
        let tableView = UITableView()

        tableView.backgroundColor = .blue
        return tableView
    }()
    
//    private let detailView: UIView = {
//        let view = UIView()
//        view.clipsToBounds = true
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
//    private let imageView: UIImageView = {
//        let view = UIImageView()
//        view.contentMode = .scaleAspectFill
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
//    let gradientView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()

//    private let gradient: CAGradientLayer = {
//        let gradient = CAGradientLayer()
//        gradient.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
//        gradient.locations = [0.2, 0.5]
//        return gradient
//    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addSubViews()
        
        setUpAutoLayout()
        
        //TEST TABLEVIEW
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.tintColor = .systemPink
        navigationItem.largeTitleDisplayMode = .never
        title = "Really cute pug"
        
        loadImage()

    }
    
    //TEST TABLEVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func loadImage() {
        
        if let imageUrl = imageUrlString {

            let url:NSURL = NSURL(string: imageUrl)!

            DispatchQueue.global(qos: .userInitiated).async {

                let imageData:NSData = NSData(contentsOf: url as URL)!

                DispatchQueue.main.async {

                    let image = UIImage(data: imageData as Data)
                    //self.imageView.image = image
                }
            }
        }
    }
    
    private func addSubViews() {

//        detailView.addSubview(imageView)
//        view.addSubview(detailView)
//        gradientView.frame = view.frame
//        gradient.frame = gradientView.frame
//        gradientView.layer.insertSublayer(gradient, at: 0)
//        imageView.addSubview(gradientView)
//        imageView.bringSubviewToFront(gradientView)
//
//        detailView.addSubview(headerLabel)
//
//        detailView.addSubview(descLabel)
    }
    
    private func setUpAutoLayout() {
        
        let safeArea = view.safeAreaLayoutGuide
        let viewFrame = view.bounds
        
        NSLayoutConstraint.activate([
//            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            detailView.topAnchor.constraint(equalTo: safeArea.topAnchor),
//            detailView.widthAnchor.constraint(equalToConstant: viewFrame.width),
//            detailView.heightAnchor.constraint(equalToConstant: viewFrame.height),
//
//            imageView.widthAnchor.constraint(equalToConstant: viewFrame.width),
//            imageView.heightAnchor.constraint(equalToConstant: viewFrame.height/2),
//
//            headerLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -40),
//            headerLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 20),
//            headerLabel.widthAnchor.constraint(equalToConstant: 250),
//            headerLabel.heightAnchor.constraint(equalToConstant: 100),
//
//            descLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 30),
//            descLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 20),
//            descLabel.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -20)
        ])
    }
}

extension DogDetailViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            tableView.register(DogDetailImageTableViewCell.self, forCellReuseIdentifier: DogDetailImageTableViewCell.identifier)
            let cell = tableView.dequeueReusableCell(withIdentifier: DogDetailImageTableViewCell.identifier, for: indexPath) as! DogDetailImageTableViewCell
            return cell
        
        case 1:
            tableView.register(DogDetailHeaderLabelTableViewCell.self, forCellReuseIdentifier: DogDetailHeaderLabelTableViewCell.identifier)
            let cell = tableView.dequeueReusableCell(withIdentifier: DogDetailHeaderLabelTableViewCell.identifier, for: indexPath) as! DogDetailHeaderLabelTableViewCell
            return cell
        
        case 2:
            tableView.register(DogDetailDescLabelTableViewCell.self, forCellReuseIdentifier: DogDetailDescLabelTableViewCell.identifier)
            let cell = tableView.dequeueReusableCell(withIdentifier: DogDetailDescLabelTableViewCell.identifier, for: indexPath) as! DogDetailDescLabelTableViewCell
            return cell
            
        default:
            tableView.register(DogDetailImageTableViewCell.self, forCellReuseIdentifier: DogDetailImageTableViewCell.identifier)
            let cell = tableView.dequeueReusableCell(withIdentifier: DogDetailImageTableViewCell.identifier, for: indexPath) as! DogDetailImageTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}



//    private let descLabel: UILabel = {
//       let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Doggo ipsum pupper woofer you are doing me a frigthen fluffer borkdrive heckin smol borking doggo with a long snoot for pats, doggorino such treat shoober wrinkler thicc. \n\nVery jealous pupper very good snot noodle horse shooberino you are doing me the shock extremely cuuuuuute, shibe heckin good boys and girls sub woofer heckin angery woofer."
//        label.numberOfLines = 0
//        label.textColor = .darkText
//        return label
//    }()
//    private let headerLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "This is a really cute pug!"
//        label.numberOfLines = 0
//        label.font = .boldSystemFont(ofSize: 30)
//        label.textColor = .black
//        return label
//    }()
