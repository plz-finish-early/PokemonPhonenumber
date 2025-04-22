//
//  PhoneBookViewController.swift
//  PokemonPhonebook
//
//  Created by 전원식 on 4/23/25.
//

import UIKit
import SnapKit

class PhoneBookViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        configure()

        
    }
    
    
    private var profileIamgeView: UIImageView = {
        let profileIamgeView = UIImageView()
        profileIamgeView.layer.cornerRadius = 100
        profileIamgeView.layer.borderColor = UIColor.black.cgColor
        profileIamgeView.layer.borderWidth = 1
        return profileIamgeView
    }()
    
    private var randomImageAddButton: UIButton = {
        let randomImageAddButton = UIButton()
        randomImageAddButton.setTitle("랜덤 이미지 생성", for: .normal)
        randomImageAddButton.setTitleColor(.black, for: .normal)
        return randomImageAddButton
    }()
    
    private var nameTextView: UITextView = {
        let nameTextView = UITextView()
        nameTextView.backgroundColor = .white
        nameTextView.layer.borderColor = UIColor.lightGray.cgColor
        nameTextView.layer.borderWidth = 1
        nameTextView.layer.cornerRadius = 8
        return nameTextView
    }()
    
    private var phoneNumTextView: UITextView = {
        let phoneNumTextView = UITextView()
        phoneNumTextView.backgroundColor = .white
        phoneNumTextView.layer.borderColor = UIColor.lightGray.cgColor
        phoneNumTextView.layer.borderWidth = 1
        phoneNumTextView.layer.cornerRadius = 8
        return phoneNumTextView
    }()
    
    
    
    private func configure() {
        
        profileIamgeView.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.centerX.equalToSuperview()
        }
        
        randomImageAddButton.snp.makeConstraints { make in
            make.top.equalTo(profileIamgeView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            
        }
        
        nameTextView.snp.makeConstraints { make in
            make.top.equalTo(randomImageAddButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
        
        phoneNumTextView.snp.makeConstraints { make in
            make.top.equalTo(nameTextView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
    }
    
    
    
    
    
    private func setupView() {
        
        view.addSubview(profileIamgeView)
        view.addSubview(randomImageAddButton)
        view.addSubview(nameTextView)
        view.addSubview(phoneNumTextView)
     
   
    }
}
