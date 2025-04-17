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
        imageView.image = UIImage(systemName: "questionmark.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 75
        imageView.layer.borderColor = .init(red: 128/255, green: 128/255, blue: 128/255, alpha: 0.8)
        imageView.layer.borderWidth = 2
        return imageView
    }()
    
    private lazy var getImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("랜덤 가챠 시작!!", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름을 입력하세요"
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let numberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "전화번호를 입력하세요"
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad[ContactsDetail]")
        configureUI()
        configureNav()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
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
    
    private func configureNav() {
        navigationItem.title = "포켓몬 추가"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "적용",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(editButtonTapped))
    }
    
    private func fetchData<T: Decodable>(url: URL, completion: @escaping (T?) -> Void) {
        let session = URLSession(configuration: .default)
        session.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data, error == nil else {
                print("데이터 받아오기 실패")
                completion(nil)
                return
            }
            
            let successHttpResponeRange = 200..<300
            if let response = response as? HTTPURLResponse, successHttpResponeRange.contains(response.statusCode) {
                guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                    print("JSON 디코딩 실패")
                    completion(nil)
                    return
                }
                completion(decodedData)
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
        
        fetchData(url: url) { [weak self] (result: ImageData?) in
            guard let self, let result else {
                print("2")
                return
            }
            guard let imageUrl = URL(string: result.sprites.other.home.frontDefault) else { return }
            
            if let data = try? Data(contentsOf: imageUrl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.profileImage.image = image
                    }
                }
            }
        }
    }
    
    /*
    private func fetchImageData(completion: @escaping (ImageData?) -> Void) {
        let ramdomNumber = Int.random(in: 1...1025)
        
        var urlComponent = URLComponents(string: "https://pokeapi.co")
        urlComponent?.path = "/api/v2/pokemon/\(ramdomNumber)"
        guard let url = urlComponent?.url else {
            print("url 생성 실패")
            completion(nil)
            return
        }
        print(url)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let urlSession = URLSession(configuration: .default)
        urlSession.dataTask(with: urlRequest) { data, response, error in
            guard let data, error == nil else {
                print("데이터 받아오기 실패")
                completion(nil)
                return
            }
            
            let successHttpRespone = 200..<300
            if let response = response as? HTTPURLResponse {
                if successHttpRespone.contains(response.statusCode) {
                    guard let decodedData = try? JSONDecoder().decode(ImageData.self, from: data) else {
                        print("JSON 디코딩 실패")
                        completion(nil)
                        return
                    }
                    completion(decodedData)
                }
            } else {
                print("응답 오류")
                completion(nil)
            }
        }.resume()
    }
    */
    @objc private func editButtonTapped() {
        print("editButtonTapped")
    }
    
    @objc private func randomButtonTapped() {
        print("randomButtonTapped")
        fetchImageData()
    }
}
