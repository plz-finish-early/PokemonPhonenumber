//
//  AddContact.swift
//  pokemony
//
//  Created by JIN LEE on 4/22/25.
//

import UIKit

class AddContactViewController: UIViewController {
    
    let nameTextField = UITextField()
    let phoneTextField = UITextField()
    let randomImageButton = UIButton()
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationItem.title = "연락처 추가"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(addContactSave))
        
        configureUI()
        
    }
    
    @objc private func addContactSave() {
        
    }
    
    private func configureUI() {
        [
            imageView,
            randomImageButton,
            phoneTextField,
            nameTextField
        ].forEach { view.addSubview($0) }
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        randomImageButton.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            randomImageButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            randomImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameTextField.centerXAnchor.constraint(equalToSystemSpacingAfter: imageView.centerXAnchor, multiplier: 1),
            nameTextField.topAnchor.constraint(equalTo: randomImageButton.bottomAnchor,constant: 30),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            phoneTextField.centerXAnchor.constraint(equalToSystemSpacingAfter: imageView.centerXAnchor, multiplier: 1),
            phoneTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            phoneTextField.heightAnchor.constraint(equalToConstant: 40),
            phoneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
            
        ])
        
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = 100
        
        randomImageButton.setTitle("랜덤 이미지 불러오기", for: .normal)
        randomImageButton.setTitleColor(.gray, for: .normal)
        randomImageButton.titleLabel?.font = .systemFont(ofSize: 14)
        
        nameTextField.placeholder = "이름을 입력하세요."
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.borderColor = UIColor.gray.cgColor
        nameTextField.layer.cornerRadius = 8
        
        phoneTextField.placeholder = "전화번호를 입력하세요."
        phoneTextField.layer.borderWidth = 1
        phoneTextField.layer.borderColor = UIColor.gray.cgColor
        phoneTextField.layer.cornerRadius = 8
    }
}
