//
//  DogDetailImageTableViewCell.swift
//  InterviewProject
//
//  Created by Emelie on 2021-04-28.
//

import UIKit

class DogDetailImageTableViewCell: UITableViewCell {

    static let identifier = "DogDetailImageTableViewCell"
    
    let dogImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        //imageView.image = .....
        //imageView.contentMode = ....
        //imageView.clipsToBounds = ...
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .orange
        contentView.addSubview(dogImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        dogImageView.frame = CGRect(x: 0,
                                    y: 0,
                                    width: contentView.frame.size.width-5,
                                    height: contentView.frame.size.height-5)
    }
    
}
