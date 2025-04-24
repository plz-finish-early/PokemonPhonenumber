//
//  ContactsListCell.swift
//  nbcampContactsApp
//
//  Created by Chanho Lee on 4/16/25.
//
import UIKit
import SnapKit

class ContactsListCell: UITableViewCell {
    
    static let identifier = "contactListCell"
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 30
        imageView.layer.borderColor = .init(red: 128/255,
                                            green: 128/255,
                                            blue: 128/255,
                                            alpha: 0.8)
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        [
            profileImage,
            nameLabel,
            numberLabel
        ].forEach{ contentView.addSubview($0) }
        
        profileImage.snp.makeConstraints {
            $0.size.equalTo(60)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(28)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(profileImage.snp.trailing).offset(24)
        }
        
        numberLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-32)
        }
    }
    
    func configureCell(data: Contact) {
        nameLabel.text = data.name
        numberLabel.text = data.phoneNumber
        profileImage.image = UIImage(data: data.profileImage)
    }
}
