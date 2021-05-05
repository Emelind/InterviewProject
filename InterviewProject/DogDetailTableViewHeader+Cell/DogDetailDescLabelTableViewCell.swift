//
//  DogDetailDescLabelTableViewCell.swift
//  InterviewProject
//
//  Created by Emelie on 2021-04-28.
//

import UIKit

class DogDetailDescLabelTableViewCell: UITableViewCell {

    static let identifier = "DogDetailDescLabelTableViewCell"
    
    let dogDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Doggo ipsum pupper woofer you are doing me a frigthen fluffer borkdrive heckin smol borking doggo with a long snoot for pats, doggorino such treat shoober wrinkler thicc. \n\nVery jealous pupper very good snot noodle horse shooberino you are doing me the shock extremely cuuuuuute, shibe heckin good boys and girls sub woofer heckin angery woofer."
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(dogDescriptionLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let labelSize = dogDescriptionLabel.sizeThatFits(contentView.frame.size)

        dogDescriptionLabel.frame = CGRect(x: 20,
                                    y: 400,
                                    width: contentView.frame.size.width-40,
                                    height: labelSize.height)
    }
}
