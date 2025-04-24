//
//  ContactsDetailViewController.swift
//  nbcampContactsApp
//
//  Created by Chanho Lee on 4/16/25.
//
import UIKit
import SnapKit
import Alamofire

class ContactsDetailViewController: UIViewController {
    
    private var data: [Contact] = []
    
    private var imageName = ""
    
    var indexPath = IndexPath() {
        didSet {
            data = CoreDataManager.shared.getAllData().sorted{
                $0.name < $1.name
            }
        }
    }
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        let colorConfig = UIImage.SymbolConfiguration(hierarchicalColor: .blue)
        if let image = UIImage(systemName: "questionmark.circle.fill", withConfiguration: colorConfig) {
            imageView.image = image
        } else {
            imageView.image = UIImage(systemName: "questionmark.circle.fill")
        }
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 75
        imageView.layer.borderColor = .init(red: 128/255,
                                            green: 128/255,
                                            blue: 128/255,
                                            alpha: 0.8)
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var getImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "이름을 입력하세요",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        textField.textColor = .label
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let numberTextField: UITextField = {
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
    
}

extension ContactsDetailViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad[ContactsDetail]")
        configureUI()
        configureNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        configureNavigationBar()
    }
    
    func configureEditUI() {
        nameTextField.text = data[indexPath.row].name
        numberTextField.text = data[indexPath.row].phoneNumber
        profileImage.image = UIImage(data: data[indexPath.row].profileImage)
        
        configureNavigationBar(title: data[indexPath.row].name, buttonTitle: "수정", action: #selector(editButtonTapped))
    }
}

private extension ContactsDetailViewController {
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        [
            profileImage,
            getImageButton,
            nameTextField,
            numberTextField,
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
    
    private func configureNavigationBar(title: String = "포켓몬 추가",
                                        buttonTitle: String = "저장",
                                        action: Selector = #selector(addButtonTapped)) {
        if !self.isViewLoaded {
            self.loadViewIfNeeded()
        }
        navigationItem.title = title
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle,
                                                            style: .plain,
                                                            target: self,
                                                            action: action)
    }
    
    private func fetchImageData() {
        let networkServices = NetworkServices()
        networkServices.fetchRandomData {  [weak self] (result: Result<RandomResult, Error>) in
            switch result {
            case .success(let result):
                do {
                    guard let imageURL = URL(string: result.sprites.other.officialArtwork.frontDefault) else {
                        throw CustomNetworkError.failedGettingImageURL
                    }
                    AF.request(imageURL).response { [weak self] response in
                        if let data = response.data, let image = UIImage(data: data) {
                            self?.profileImage.image = image
                        }
                    }
                    self?.imageName = result.species.name
                } catch {
                    guard let error = error as? CustomNetworkError else { return }
                    self?.showAlert(error)
                }
            case .failure(let error):
                guard let error = error as? CustomNetworkError else {
                    print(error)
                    return
                }
                self?.showAlert(error)
            }
        }
        
    }
    
    private func showAlert(_ error: Error) {
        guard let alertError = error as? AlertError else { return }
        let alert = UIAlertController(title: nil, message: alertError.alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)
    }
    
    @objc private func addButtonTapped() {
        print("addButtonTapped")
        do {
            guard let name = nameTextField.text, !name.isEmpty else {
                throw ContactsDetailViewError.nameTextFieldIsEmpty
            }
            guard let number = numberTextField.text, !number.isEmpty else {
                throw ContactsDetailViewError.numberTextFiledIsEmpty
            }
            
            guard let profileImageData = profileImage.image!.pngData() else {
                throw ContactsDetailViewError.failedCovertingProfileImage
            }
            
            let newContact = Contact(uuid: UUID(),
                                     name: name,
                                     phoneNumber: number,
                                     profileImage: profileImageData,
                                     imageName: imageName)
            
            CoreDataManager.shared.createData(contact: newContact)
            
            navigationController?.popViewController(animated: true)
        } catch {
            guard let error = error as? ContactsDetailViewError else { return }
            showAlert(error)
        }
        
    }
    
    @objc private func editButtonTapped() {
        print("editButtonTapped")
        
        let currentData = data[indexPath.row]
        do {
            guard let name = nameTextField.text, !name.isEmpty else {
                throw ContactsDetailViewError.nameTextFieldIsEmpty
            }
            guard let number = numberTextField.text, !number.isEmpty else {
                throw ContactsDetailViewError.numberTextFiledIsEmpty
            }
            
            guard let profileImageData = profileImage.image!.pngData() else {
                throw ContactsDetailViewError.failedCovertingProfileImage
            }
            let editedContact = Contact(uuid: currentData.uuid,
                                        name: name,
                                        phoneNumber: number,
                                        profileImage: profileImageData,
                                        imageName: currentData.imageName)
            
            CoreDataManager.shared.updateData(contact: editedContact)
        } catch {
            guard let error = error as? ContactsDetailViewError else { return }
            showAlert(error)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func randomButtonTapped() {
        print("randomButtonTapped")
        fetchImageData()
    }
}
