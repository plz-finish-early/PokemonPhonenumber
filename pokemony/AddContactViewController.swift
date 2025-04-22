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
    let ramdomImageButton = UIButton()
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationItem.title = "연락처 추가"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(addContactSave))
        
    }
    
    @objc private func addContactSave() {
        
    }
    
    private func configureUI() {
        [
            imageView,
            ramdomImageButton,
            phoneTextField,
            nameTextField
        ].forEach { view.addSubview($0) }
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        ramdomImageButton.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
        ])
        
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFit
        
    }
}
