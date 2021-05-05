//
//  DetailViewController.swift
//  InterviewProject
//
//  Created by Emelie on 2021-04-18.
//

import UIKit

class DogDetailViewController: UIViewController {
    
    var imageUrlString: String?
    
//    let imageView: UIImageView = {
//        let imageView = UIImageView()
//
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        return imageView
//    }()
//
//    let lblName:UILabel = {
//        let lblName = UILabel()
//        lblName.frame = CGRect(x: 20, y: 100, width: 200, height: 22)
//        lblName.text = "Steve Jobs"
//        lblName.textColor = UIColor.white
//        lblName.font = UIFont.systemFont(ofSize: 26)
//        lblName.clipsToBounds = true
//        return lblName
//    }()

    private let tableView: UITableView = {
        let table = UITableView()
        table.separatorColor = .clear
        table.register(DogDetailDescLabelTableViewCell.self,
                       forCellReuseIdentifier: DogDetailDescLabelTableViewCell.identifier)
        table.register(DogDetailTableHeader.self,
                       forHeaderFooterViewReuseIdentifier: DogDetailTableHeader.identifier)
        return table
    }()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
//        view.addSubview(imageView)
//        imageView.addSubview(lblName)
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.tintColor = .systemPink
        navigationItem.largeTitleDisplayMode = .never
        title = "Really cute pug"

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
        
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DogDetailTableHeader.identifier) as! DogDetailTableHeader
        header.scroll(contentOffset: scrollView.contentOffset)
        print("scroll: \(scrollView.contentOffset)")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DogDetailTableHeader.identifier) as! DogDetailTableHeader

        if let imageUrl = imageUrlString {
            let url:NSURL = NSURL(string: imageUrl)!
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData:NSData = NSData(contentsOf: url as URL)!
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData as Data)
                    header.configure(image: image!)
                }
            }
        }
        return header
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
//    private func loadImage() {
//
//        if let imageUrl = imageUrlString {
//
//            let url:NSURL = NSURL(string: imageUrl)!
//
//            DispatchQueue.global(qos: .userInitiated).async {
//
//                let imageData:NSData = NSData(contentsOf: url as URL)!
//
//                DispatchQueue.main.async {
//
//                    let image = UIImage(data: imageData as Data)
//
//                    //self.imageView.image = image
//                }
//            }
//        }
//    }
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

// constraints
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
// add subviews
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


//    private func setUpAutoLayout() {
//
//        let safeArea = view.safeAreaLayoutGuide
//        let viewFrame = view.bounds
//
//        NSLayoutConstraint.activate([
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
//            tableView.widthAnchor.constraint(equalToConstant: viewFrame.width),
//            tableView.heightAnchor.constraint(equalToConstant: viewFrame.height)
//        ])
//    }


//cellforrowat:
//        switch indexPath.row {
//        case 0:
//            tableView.register(DogDetailImageTableViewCell.self, forCellReuseIdentifier: DogDetailImageTableViewCell.identifier)
//            let cell = tableView.dequeueReusableCell(withIdentifier: DogDetailImageTableViewCell.identifier, for: indexPath) as! DogDetailImageTableViewCell
//            if let imageUrl = imageUrlString {
//                let url:NSURL = NSURL(string: imageUrl)!
//                DispatchQueue.global(qos: .userInitiated).async {
//                    let imageData:NSData = NSData(contentsOf: url as URL)!
//                    DispatchQueue.main.async {
//                        let image = UIImage(data: imageData as Data)
//                        cell.dogImageView.image = image
//                    }
//                }
//            }
//            return cell
//
//        case 1:
//            tableView.register(DogDetailHeaderLabelTableViewCell.self, forCellReuseIdentifier: DogDetailHeaderLabelTableViewCell.identifier)
//            let cell = tableView.dequeueReusableCell(withIdentifier: DogDetailHeaderLabelTableViewCell.identifier, for: indexPath) as! DogDetailHeaderLabelTableViewCell
//            return cell
//
//        case 2:
//            tableView.register(DogDetailDescLabelTableViewCell.self, forCellReuseIdentifier: DogDetailDescLabelTableViewCell.identifier)
//            let cell = tableView.dequeueReusableCell(withIdentifier: DogDetailDescLabelTableViewCell.identifier, for: indexPath) as! DogDetailDescLabelTableViewCell
//            return cell
//
//        default:
//            tableView.register(DogDetailImageTableViewCell.self, forCellReuseIdentifier: DogDetailImageTableViewCell.identifier)
//            let cell = tableView.dequeueReusableCell(withIdentifier: DogDetailImageTableViewCell.identifier, for: indexPath) as! DogDetailImageTableViewCell
//            return cell
//        }
