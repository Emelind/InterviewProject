//
//  DogDetailTableHeader.swift
//  InterviewProject
//
//  Created by Emelie on 2021-05-04.
//

import Foundation
import UIKit

class DogDetailTableHeader: UITableViewHeaderFooterView {
    
    static let identifier = "TableHeader"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let gradientView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let gradient: CAGradientLayer = {
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
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        gradientView.layer.insertSublayer(gradient, at: 0)
        
        imageView.addSubview(gradientView)
        imageView.bringSubviewToFront(gradientView)
        
        contentView.addSubview(imageView)
        contentView.addSubview(headerLabel)
    }
    
    func configure(image: UIImage) {
        imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("layout subviews")
        
        let frame = CGRect(x: 0,
                           y: 0,
                           width: UIScreen.main.bounds.size.width,
                           height: 400)
        imageView.frame = frame
        gradientView.frame = frame
        gradient.frame = frame
        
        headerLabel.frame = CGRect(x: 20,
                                   y: 300,
                                   width: contentView.frame.size.width/1.5,
                                   height: 150)
    }
    
    func scroll(contentOffset: CGPoint) {
        let y = 300 - (contentOffset.y + 300)
        let height = min(max(y, 60), 400)
        let newFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        imageView.frame = newFrame
        gradient.frame = newFrame
        gradientView.frame = newFrame
        headerLabel.frame = CGRect(x: 20, y: height - 30, width: 200, height: 22)
        
    }
}
