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
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        //imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let gradientView: UIView = {
        let view = UIView()
        //view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
        gradient.locations = [0.1, 0.9]
        return gradient
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        gradientView.layer.insertSublayer(gradient, at: 0)
        
        dogImageView.addSubview(gradientView)
        dogImageView.bringSubviewToFront(gradientView)
        
        contentView.backgroundColor = .red
        contentView.addSubview(dogImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let frame = CGRect(x: 0,
                           y: 0,
                           width: contentView.frame.size.width,
                           height: contentView.frame.size.height)
        
        dogImageView.frame = frame
        gradientView.frame = frame
        gradient.frame = frame
    }
}
