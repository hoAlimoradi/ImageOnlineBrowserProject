//
//  HomeCollectionViewCell.swift
//  Home
//
//  Created by hoseinAlimoradi on 7/8/23.
//
import Foundation
import UIKit
import Commons
import SharedUI
 
class HomeCollectionViewCell: UICollectionViewCell {

    static let identifier = "HomeCollectionViewCell"
    
    private enum Constants {
        static var borderWidth = CGFloat(2)
        static var cornerRadius = CGFloat(25)
        static var imageViewLeadingMargin = CGFloat(8)
        static var imageViewWidth = CGFloat(15)
    }
     
    private lazy var parentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.background
        view.layer.borderColor = Colors.BlackPearl.lightest.cgColor
        view.layer.borderWidth = Constants.borderWidth
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()

    private lazy var titleLabel : UILabel = {
        let lable = UILabel()
        lable.textAlignment = .left
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = Fonts.Button.medium
        lable.textColor = Colors.BlackPearl.veryDark
        return lable
    }()
    
    private lazy var idLabel : UILabel = {
        let lable = UILabel()
        lable.textAlignment = .left
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = Fonts.Button.medium
        lable.textColor = Colors.BlackPearl.veryDark
        return lable
    }()
 
    private lazy var descriptionLabel : UILabel = {
        let lable = UILabel()
        lable.textAlignment = .left
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = Fonts.Button.medium
        lable.textColor = Colors.BlackPearl.veryDark
        return lable
    }()
  
    private lazy var isPrivateLabel : UILabel = {
        let lable = UILabel()
        lable.textAlignment = .left
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = Fonts.Button.medium
        lable.textColor = Colors.BlackPearl.veryDark
        return lable
    }()
 
    private lazy var mediaCountLabel : UILabel = {
        let lable = UILabel()
        lable.textAlignment = .left
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = Fonts.Button.medium
        lable.textColor = Colors.BlackPearl.veryDark
        return lable
    }()
 
    private lazy var photosCountLabel : UILabel = {
        let lable = UILabel()
        lable.textAlignment = .left
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = Fonts.Button.medium
        lable.textColor = Colors.BlackPearl.veryDark
        return lable
    }()
    
    private lazy var videosCountLabel : UILabel = {
        let lable = UILabel()
        lable.textAlignment = .left
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = Fonts.Button.medium
        lable.textColor = Colors.BlackPearl.veryDark
        return lable
    }()
   
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
        parentView.addSubview(idLabel)
        parentView.addSubview(titleLabel)
        parentView.addSubview(descriptionLabel)
        parentView.addSubview(isPrivateLabel)
        parentView.addSubview(mediaCountLabel)
        parentView.addSubview(photosCountLabel)
        parentView.addSubview(videosCountLabel)

        NSLayoutConstraint.activate([
            parentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            parentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            parentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            parentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            idLabel.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 15),
            idLabel.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 8),
            idLabel.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -8),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -8),
            
            isPrivateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            isPrivateLabel.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 8),
            isPrivateLabel.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -8),
 
            mediaCountLabel.topAnchor.constraint(equalTo: isPrivateLabel.bottomAnchor, constant: 10),
            mediaCountLabel.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 8),
            mediaCountLabel.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -8),
            
            photosCountLabel.topAnchor.constraint(equalTo: mediaCountLabel.bottomAnchor, constant: 10),
            photosCountLabel.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 8),
            photosCountLabel.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -8),
            
            videosCountLabel.topAnchor.constraint(equalTo: photosCountLabel.bottomAnchor, constant: 10),
            videosCountLabel.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 8),
            videosCountLabel.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -8),
        ])
    }

    override func prepareForReuse() {
        idLabel.text = ""
        titleLabel.text = ""
        descriptionLabel.text = ""
        isPrivateLabel.text = ""
        mediaCountLabel.text = ""
        photosCountLabel.text = ""
        videosCountLabel.text = ""
    }
    
    func config(with model: HomeViewController.HomeCollectionModel) {
        idLabel.text = "id : \(model.id)"
        titleLabel.text = "title : \(model.title)"
        descriptionLabel.text = "description : \(model.description)"
        isPrivateLabel.text = "isPrivate : \(model.isPrivate)"
        mediaCountLabel.text = "mediaCount : \(model.mediaCount)"
        photosCountLabel.text = "photosCount : \(model.photosCount)"
        videosCountLabel.text = "videosCount : \(model.videosCount)"
    }
}

