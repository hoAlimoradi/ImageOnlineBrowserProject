//
//  SearchResultCollectionViewCell.swift
//  Search
//
//  Created by hoseinAlimoradi on 6/27/23.
//

import Foundation
import UIKit
import Commons
import SharedUI

class SearchResultCollectionViewCell: UICollectionViewCell {

    static let identifier = "SearchResultCollectionViewCell"
    
    private enum Constants {
        static var borderWidth = CGFloat(2)
        static var cornerRadius = CGFloat(25)
        static var imageViewLeadingMargin = CGFloat(8)
        static var imageViewWidth = CGFloat(15)
    }
    //private var isSelectedItem: Bool = false
    private lazy var parentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.background
        view.layer.borderColor = Colors.BlackPearl.lightest.cgColor
        view.layer.borderWidth = Constants.borderWidth
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()

    private lazy var nameLabel : UILabel = {
        let lable = UILabel()
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = Fonts.Button.medium
        lable.textColor = Colors.BlackPearl.veryDark
        return lable
    }()
 
    private lazy var imageView : UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "img_logo"))
        imageView.isUserInteractionEnabled = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
  
    func makeSelected() {
        parentView.layer.borderColor = Colors.Primary.primary.cgColor
        parentView.backgroundColor = Colors.Secondary.secondaryLight
    }

    func makeUnSelected() {
        parentView.layer.borderColor = Colors.BlackPearl.lightest.cgColor
        parentView.backgroundColor = Colors.background
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    func setup() {
        backgroundColor = UIColor.clear
 
        contentView.addSubview(parentView)
        parentView.addSubview(imageView)
        parentView.addSubview(nameLabel)
        //parentView.addSubview(button)

        NSLayoutConstraint.activate([
            parentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            parentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            parentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            parentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -16),
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageViewWidth),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageViewWidth),

            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: Constants.imageViewLeadingMargin),
            nameLabel.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -8),
     
  
//            button.topAnchor.constraint(equalTo: parentView.topAnchor),
//            button.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
//            button.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
//            button.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
        ])
    }

    override func prepareForReuse() {
        nameLabel.text = ""
        makeUnSelected()
    }
    
    func config(with model: SearchViewController.SearchTaskCollectionModel) {
        nameLabel.text = model.name
//        imageView.setTokenizedImage(with: model.imageUrlString)
//        if(model.isSelectedItem) {
//            makeSelected()
//        } else {
//            makeUnSelected()
//        }
    }
}



