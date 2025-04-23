//
//  PhoneBookViewController.swift
//  PokemonPhoneBook
//
//  Created by NH on 4/18/25.
//

import UIKit
import CoreData

class PhoneBookViewController: UIViewController {
    public var PhoneBookPhoneNumber: String?
    public var PhoneBookImageUrl: String?
    
    public var isUpdate: Bool = false // 적용 버튼 탭 시, 추가를 할 것인지 업데이트를 할 것인지 정하는 변수
    
    public var PhoneBookName: String? // title 변경에 사용할 변수
    
    private var profileImageUrl: String? // imageUrlString 저장할 프로퍼티 추가

    public let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = 80
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var ramdomImageGenerationButton: UIButton = {
        let button = UIButton()
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(ramdomImageGenerationButtonTapped), for: .touchDown)
        return button
    }()
    
    public let nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    public let phoneNumTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 네비게이션 바 보이게 하기
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        // Title 분기 처리
        if let contactName = PhoneBookName {
            self.navigationItem.title = contactName
        } else {
            self.navigationItem.title = "연락처 추가"
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "적용", style: .done, target: self, action: #selector(didApplyButtonTapped))
        
        setProfileImageView()
        setRamdomImageGenerationButton()
        setNameTextField()
        setPhoneNumTextField()
    }
    
    // MARK: - UI 설정
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
    
    // MARK: - 버튼 이벤트
    @objc
    private func didApplyButtonTapped() {
        print("적용 버튼이 탭 되었습니다.")
        
        // 예외처리: 프로필 업데이트 시, 이미지를 변경하지 않으면 이미지가 비는 현상 수정
        if profileImageUrl == nil {
            profileImageUrl = PhoneBookImageUrl
        }
        
        if isUpdate {
            CoreDataManager.shared.updateData(
                currentImageUrl: PhoneBookImageUrl ?? "",
                updateImageUrl: profileImageUrl ?? "",
                currentName: PhoneBookName ?? "",
                updateName: nameTextField.text ?? "",
                currentPhoneNumber: PhoneBookPhoneNumber ?? "",
                updatePhoneNumber: phoneNumTextField.text ?? ""
            )
        } else {
            CoreDataManager.shared.createData(
                imageUrl: profileImageUrl,
                name: nameTextField.text ?? "",
                phoneNumber: phoneNumTextField.text ?? ""
            )
        }
        self.navigationController?.popViewController(animated: true) // 전 화면으로 돌아가기
        
    }
    
    @objc
    private func ramdomImageGenerationButtonTapped() {
        print("랜덤 이미지를 생성합니다.")
        
        FetchAPI.shared.fetchPokemonImage { [weak self] image, imageUrlStr in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.profileImageView.image = image
                self.profileImageUrl = imageUrlStr // CoreData에 저장
            }
        }
    }
}
