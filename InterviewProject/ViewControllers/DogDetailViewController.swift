//
//  DetailViewController.swift
//  InterviewProject
//
//  Created by Emelie on 2021-04-18.
//

import UIKit

class DogDetailViewController: UIViewController {
    
    var imageUrlString: String?
    
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
    
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        view.addSubview(tableView)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.tintColor = .systemPink
        navigationItem.largeTitleDisplayMode = .never
        title = "Really cute pug"
        
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
