//
//  DetailViewController.swift
//  InterviewProject
//
//  Created by Emelie on 2021-04-18.
//

import UIKit

class DogDetailViewController: UIViewController {
    
    var imageUrlString: String?
    
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let headerGradientView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let headerGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
        gradient.locations = [0.1, 0.9]
        return gradient
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "This is a really cute pug!"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.separatorColor = .clear
        table.register(DogDetailDescLabelTableViewCell.self,
                       forCellReuseIdentifier: DogDetailDescLabelTableViewCell.identifier)
        return table
    }()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        setUpHeaderView()
        
        view.addSubview(tableView)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.tintColor = .systemPink
        navigationItem.largeTitleDisplayMode = .never
        title = "Really cute pug"
    }
    
    func setUpHeaderView() {
        
        if let imageUrl = imageUrlString {
            let url:NSURL = NSURL(string: imageUrl)!
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData:NSData = NSData(contentsOf: url as URL)!
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData as Data)
                    self.headerImageView.image = image
                }
            }
        }
        
        headerGradientView.layer.insertSublayer(headerGradient, at: 0)
        
        headerImageView.addSubview(headerGradientView)
        headerImageView.bringSubviewToFront(headerGradientView)
        
        headerImageView.addSubview(headerLabel)
        
        let headerFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: 400)
        headerImageView.frame = headerFrame
        headerGradient.frame = headerFrame
        headerGradientView.frame = headerFrame
        
        let headerLabelFrame = CGRect(x: 20, y: 300, width: view.frame.width/1.5, height: 100)
        headerLabel.frame = headerLabelFrame
        
        tableView.tableHeaderView = headerImageView
    }
}

extension DogDetailViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DogDetailDescLabelTableViewCell.identifier, for: indexPath) as! DogDetailDescLabelTableViewCell
        return cell
    }
}
