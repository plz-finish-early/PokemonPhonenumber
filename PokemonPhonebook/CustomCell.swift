//
//  CustomCell.swift
//  PokemonPhonebook
//
//  Created by 전원식 on 4/22/25.
//

import UIKit
import SnapKit

class CustomCell: UITableViewCell {
    let nameLabel = UILabel()
    let iconView = UIImageView()
    let phoneLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        iconView.contentMode = .scaleAspectFit
        iconView.clipsToBounds = true
        iconView.layer.cornerRadius = 30
        iconView.layer.borderColor = UIColor.black.cgColor
        iconView.layer.borderWidth = 1.0
        contentView.addSubview(iconView)

        nameLabel.font = .boldSystemFont(ofSize: 20)
        nameLabel.text = "TT"
        contentView.addSubview(nameLabel)

        phoneLabel.font = .boldSystemFont(ofSize: 20)
        phoneLabel.text = "testPhonelabel"
        contentView.addSubview(phoneLabel)
    }

    private func setupConstraints() {
        iconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(60)
        }

        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
        }

        phoneLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(nameLabel.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(30)
        }
    }
}
