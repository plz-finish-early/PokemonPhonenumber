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
    
    private lazy var ramdomImageGenerationButton: UIButton = {
        let button = UIButton()
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(ramdomImageGenerationButtonTapped), for: .touchDown)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 네비게이션 바 보이게 하기
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

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
      private func Tapped() {
        print("적용 버튼이 탭 되었습니다.")
      }
    
    @objc
      private func ramdomImageGenerationButtonTapped() {
        print("랜덤 이미지를 생성합니다.")
          fetchPokemonImage()
      }
    
    // MARK: - API 데이터 가져오기
    private func fetchData<T: Decodable>(url: URL, completion: @escaping (T?) -> Void) {
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data, error == nil else {
                print("데이터 로드 실패")
                completion(nil)
                return
            }
            let successRange = 200..<300
            
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
                guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                    print(response.statusCode, "JSON 디코딩 실패")
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
    
    private func fetchPokemonImage() {
        let ramdomNumber = String(Int.random(in: 1...1000))
        let urlComponents = URLComponents(string: "https://pokeapi.co/api/v2/pokemon/\(ramdomNumber)")
        
        guard let url = urlComponents?.url else {
            print("잘못된 URL")
            return
        }
        
        fetchData(url: url) { [weak self] (result: PokemonImageResult?) in
            guard let self, let result else { return }
            
            
            guard let imageUrl = URL(string: "\(result.sprites.frontDefault)") else {
                print("이미지 불러오기 실패")
                return
            }
            
            if let data = try? Data(contentsOf: imageUrl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.profileImageView.image = image
                    }
                }
            }
        }
    }
}
