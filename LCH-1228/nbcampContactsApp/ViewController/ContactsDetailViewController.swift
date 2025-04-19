//
//  ContactsDetailViewController.swift
//  nbcampContactsApp
//
//  Created by Chanho Lee on 4/16/25.
//
import UIKit
import SnapKit

class ContactsDetailViewController: UIViewController {
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        let colorConfig = UIImage.SymbolConfiguration(hierarchicalColor: .blue)
        if let image = UIImage(systemName: "questionmark.circle.fill", withConfiguration: colorConfig) {
            imageView.image = image
        } else {
            imageView.image = UIImage(systemName: "questionmark.circle.fill")
        }
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 75
        imageView.layer.borderColor = .init(red: 128/255, green: 128/255, blue: 128/255, alpha: 0.8)
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var getImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("랜덤 가챠 시작!!", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "이름을 입력하세요",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        textField.textColor = .label
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let numberTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "전화번호를 입력하세요",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        textField.textColor = .label
        textField.borderStyle = .roundedRect
        textField.keyboardType = .phonePad
        return textField
    }()
    
    var currentUUID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad[ContactsDetail]")
        configureUI()
        configureAddNav()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        configureAddNav()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        [
            profileImage,
            getImageButton,
            nameTextField,
            numberTextField
        ].forEach{ view.addSubview($0) }
        
        profileImage.snp.makeConstraints {
            $0.size.equalTo(150)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        
        getImageButton.snp.makeConstraints {
            $0.width.equalTo(profileImage.snp.width)
            $0.height.equalTo(20)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(profileImage.snp.bottom).offset(8)
        }
        
        nameTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(getImageButton.snp.bottom).offset(32)
        }
        
        numberTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nameTextField.snp.bottom).offset(12)
        }
    }
    
    func configureAddNav() {
        navigationItem.title = "포켓몬 추가"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addButtonTapped))
    }
    
    func configureEditNav(title: String, buttonName: String) {
        navigationItem.title = title
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonName,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(editButtonTapped))
    }
    
    private func fetchData<T>(url: URL, completion: @escaping (T?) -> Void) {
        let session = URLSession(configuration: .default)
        session.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data, error == nil else {
                print("데이터 받아오기 실패")
                completion(nil)
                return
            }
            
            let successHttpResponeRange = 200..<300
            if let response = response as? HTTPURLResponse, successHttpResponeRange.contains(response.statusCode) {
                completion(data as? T)
            } else {
                print("응답 오류")
                completion(nil)
            }
        }.resume()
    }
    
    private func fetchImageData() {
        let ramdomNumber = Int.random(in: 1...1025)
        
        var urlComponent = URLComponents(string: "https://pokeapi.co")
        urlComponent?.path = "/api/v2/pokemon/\(ramdomNumber)"
        guard let url = urlComponent?.url else {
            print("url 생성 실패")
            return
        }
        fetchData(url: url) { [weak self] (result: Data?) in
            guard let self, let result else { return }
            
            guard let decodedData = try? JSONDecoder().decode(ImageData.self, from: result) else {
                print("JSON 디코딩 실패")
                return
            }
            
            guard let imageUrl = URL(string: decodedData.sprites.other.home.frontDefault) else {
                print("이미지 url 생성 실패")
                return
            }
            
            fetchData(url: imageUrl) { [weak self] (result: Data?) in
                guard let self, let result else { return }
                
                if let image = UIImage(data: result) {
                    DispatchQueue.main.async {
                        self.profileImage.image = image
                    }
                }
            }
        }
    }
    
    @objc private func addButtonTapped() {
        print("addButtonTapped")
        
        guard let name = nameTextField.text, nameTextField.text != nil else {
            print("이름 비어서 저장 못함")
            return
        }
        guard let number = numberTextField.text, numberTextField.text != nil else {
            print("번호 비어서 저장 못함")
            return
        }
        
        guard let profileImageData = profileImage.image!.pngData() else {
            print("이미지 변환실패")
            return
        }
        CoreDataManager.shard.createData(name: name, phoneNumber: number, profileImage: profileImageData)
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func editButtonTapped() {
        print("editButtonTapped")
        
        guard let uuid = UUID(uuidString: currentUUID) else {
            print("UUID 변환 실패")
            return
        }
        
        guard let name = nameTextField.text, nameTextField.text != nil else {
            print("이름 비어서 저장 못함")
            return
        }
        guard let number = numberTextField.text, numberTextField.text != nil else {
            print("번호 비어서 저장 못함")
            return
        }
        
        guard let profileImageData = profileImage.image!.pngData() else {
            print("이미지 변환실패")
            return
        }
        
        CoreDataManager.shard.updateData(uuid: uuid, updateName: name, updatephoneNumber: number, updateProfileImage: profileImageData)
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func randomButtonTapped() {
        print("randomButtonTapped")
        fetchImageData()
    }
}
