//
//  DogDetailHeaderLabelTableViewCell.swift
//  InterviewProject
//
//  Created by Emelie on 2021-04-28.
//

import UIKit

class DogDetailHeaderLabelTableViewCell: UITableViewCell {

    static let identifier = "DogDetailHeaderLabelTableViewCell"
    
    let dogHeaderLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemPink
        label.text = "This is a really cute pug!"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .orange
        contentView.addSubview(dogHeaderLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dogHeaderLabel.frame = CGRect(x: 20,
                                    y: 0,
                                    width: contentView.frame.size.width/1.5,
                                    height: contentView.frame.size.height)
    }

}
