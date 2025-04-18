//
//  PhoneBookViewController.swift
//  PokemonPhoneBook
//
//  Created by NH on 4/18/25.
//

import UIKit

class PhoneBookViewController: UIViewController {
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = 80
        return imageView
    }()
    
    private let ramdomImageGenerationButton: UIButton = {
        let button = UIButton()
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .center
        //button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let phoneNumTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.navigationItem.title = "연락처 추가"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "적용", style: .done, target: self, action: #selector(Tapped))
        
        setProfileImageView()
        setRamdomImageGenerationButton()
        setNameTextField()
        setPhoneNumTextField()
    }
    
    private func setProfileImageView() {
        self.view.addSubview(profileImageView)
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(18)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(160)
        }
    }
    
    private func setRamdomImageGenerationButton() {
        self.view.addSubview(ramdomImageGenerationButton)
        
        ramdomImageGenerationButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setNameTextField() {
        self.view.addSubview(nameTextField)
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(ramdomImageGenerationButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setPhoneNumTextField() {
        self.view.addSubview(phoneNumTextField)
        
        phoneNumTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc
      private func Tapped() {
        print("적용 버튼이 탭 되었습니다.")
      }
}
