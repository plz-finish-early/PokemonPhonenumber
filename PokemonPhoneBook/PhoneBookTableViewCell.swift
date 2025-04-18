//
//  PhoneBookTableViewCell.swift
//  PokemonPhoneBook
//
//  Created by NH on 4/18/25.
//

import UIKit

class PhoneBookTableViewCell: UITableViewCell {
    static let id = "PhoneBookTableViewCell"
    
    let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 30
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let phoneNumLabel: UILabel = {
        let label = UILabel()
        label.text = "010-1111-2222"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        [
            pokemonImageView,
            nameLabel,
            phoneNumLabel
        ].forEach { contentView.addSubview($0) }
        
        pokemonImageView.snp.makeConstraints {
            $0.width.height.equalTo(60)
            $0.leading.equalToSuperview().offset(30)
            $0.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(pokemonImageView.snp.trailing).offset(20)
            $0.centerY.equalToSuperview()
        }
       
        phoneNumLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(30)
            //$0.leading.equalTo(nameLabel.snp.trailing).offset(50)
        }
    }
    
}
