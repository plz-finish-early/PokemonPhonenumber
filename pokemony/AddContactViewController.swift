//
//  AddContact.swift
//  pokemony
//
//  Created by JIN LEE on 4/22/25.
//

import UIKit
import CoreData

class AddContactViewController: UIViewController {
    
    var container: NSPersistentContainer!
    
    let nameTextField = UITextField()
    let phoneTextField = UITextField()
    let randomImageButton = UIButton()
    let imageView = UIImageView()
    
    var selectedPokemonImageURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationItem.title = "연락처 추가"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(addContactSave))
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        
        configureUI()
    }
    
    //서버 데이터 불러오는 메서드 여러가지 데이터를 받아올 때 공통적으로 쓰이는 뼈대같은 코드
    private func fetchData<T: Decodable>(url: URL, completion: @escaping (T?) -> Void) {
        let session = URLSession(configuration: .default)
        session.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                print("데이터 로드 실패")
                completion(nil)
                return
            }
            //http status code 성공 범위
            let successRange = 200..<300
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
                guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                    print("JSON 디코딩 실패")
                    completion(nil)
                    return
                }
                completion(decodedData)
            } else {
                print("응답오류")
                completion(nil)
            }
        }.resume()
    }
    
    private func fetchPokemonData() {
        let randomNumber = Int.random(in: 1...100)
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(randomNumber)") else {
            print("잘못된 URL")
            return
        }
        
        fetchData(url: url) { [weak self] (result: PokemonData?) in
            guard let self = self, let imageURLString = result?.sprites.frontDefault, let imageURL = URL(string: imageURLString) else { return }
            
            // 선택된 포키몬 이미지 유알엘 저장
            self.selectedPokemonImageURL = imageURLString
            
            // 비동기로 이미지 다운로드
            URLSession.shared.dataTask(with: imageURL) { data, _, error in
                guard let data = data, error == nil, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }.resume()
        }
    }
    
    func createData(name: String, phoneNumber: String, profileImageURL: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "PhoneBook", in: self.container.viewContext) else { return }
        
        let newPhoneBook = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        newPhoneBook.setValue(name, forKey: PhoneBook.Key.name)
        newPhoneBook.setValue(phoneNumber, forKey: PhoneBook.Key.phoneNumber)
        newPhoneBook.setValue(profileImageURL, forKey: PhoneBook.Key.profileImage)
        
        do {
            try self.container.viewContext.save()
            print("저장 성공")
        } catch {
            print("저장 실패")
        }
    }

    
    @objc func randomImageButtonTapped() {
        fetchPokemonData()
    }
    
    @objc private func addContactSave() {
        createData(name: nameTextField.text ?? "",
                   phoneNumber: phoneTextField.text ?? "",
                   profileImageURL: selectedPokemonImageURL ?? "")
        
        self.navigationController?.popViewController(animated: true)
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
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = 100
        
        randomImageButton.setTitle("랜덤 이미지 불러오기", for: .normal)
        randomImageButton.setTitleColor(.gray, for: .normal)
        randomImageButton.titleLabel?.font = .systemFont(ofSize: 14)
        randomImageButton.addTarget(self, action: #selector(randomImageButtonTapped), for: .touchUpInside)
        
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
