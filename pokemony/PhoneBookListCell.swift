//
//  PhoneBookListCell.swift
//  pokemony
//
//  Created by JIN LEE on 4/21/25.
//

import UIKit

class PhoneBookListCell: UITableViewCell {
    
    static let identifier: String = "PhoneBookListCell"
    
    let photoImageView = UIImageView()
    let nameLabel = UILabel()
    let phoneNumberLabel = UILabel()
    let horizontalStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        
        [photoImageView, nameLabel, phoneNumberLabel].forEach { contentView.addSubview($0) }
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        photoImageView.image = UIImage(systemName: "person.circle")
        photoImageView.frame.size = CGSize(width: 50, height: 50)
        
        nameLabel.text = "Name"
        nameLabel.textColor = .black
        nameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        nameLabel.numberOfLines = 0
        
        phoneNumberLabel.text = "010-5000-5000"
        phoneNumberLabel.font = .systemFont(ofSize: 17)
        phoneNumberLabel.textColor = .black
        phoneNumberLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            photoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: 50),
            photoImageView.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            phoneNumberLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 16),
            phoneNumberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            phoneNumberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
