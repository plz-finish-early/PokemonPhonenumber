//
//  PhoneBookListCell.swift
//  pokemony
//
//  Created by JIN LEE on 4/21/25.
//

import UIKit
import CoreData

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
    
    // ViewController에서 데이터를 받아 UI를 업데이트하는 메서드
    func configure(with phoneBook: PhoneBook) {
            nameLabel.text = phoneBook.name
            phoneNumberLabel.text = phoneBook.phoneNumber
            
            if let imageURL = phoneBook.profileImage, let url = URL(string: imageURL) {
                URLSession.shared.dataTask(with: url) { data, _, error in
                    guard let data = data, error == nil, let image = UIImage(data: data) else { return }
                    DispatchQueue.main.async {
                        self.photoImageView.image = image
                    }
                }.resume()
            }
        }
    
    func configureUI() {
        
        [photoImageView, nameLabel, phoneNumberLabel].forEach { contentView.addSubview($0) }
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        photoImageView.frame.size = CGSize(width: 50, height: 50)
        photoImageView.layer.borderColor = UIColor.gray.cgColor
        photoImageView.layer.borderWidth = 1
        photoImageView.layer.cornerRadius = 50 / 2
        
        nameLabel.textColor = .black
        nameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        nameLabel.numberOfLines = 0
        
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
