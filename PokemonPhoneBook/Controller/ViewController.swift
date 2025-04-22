//
//  ViewController.swift
//  PokemonPhoneBook
//
//  Created by NH on 4/18/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "친구 목록"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.titleLabel?.textAlignment = .center
        //button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PhoneBookTableViewCell.self, forCellReuseIdentifier: PhoneBookTableViewCell.id)
        return tableView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 네비게이션 바 숨기기
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        CoreDataManager.shared.readAllData()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setTitleLabel()
        setAddButton()
        setTableView()
    }
    
    // MARK: - UI 설정
    private func setTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setAddButton() {
        view.addSubview(addButton)
        
        addButton.addTarget(self, action: #selector(buttonTapped), for: .touchDown)
        
        addButton.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.height.equalTo(titleLabel.snp.height)
            $0.top.equalToSuperview().offset(80)
            $0.trailing.equalToSuperview()
            
        }
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    // MARK: - 버튼 이벤트
    @objc
    private func buttonTapped() {
        self.navigationController?.pushViewController(PhoneBookViewController(), animated: true)
    }
}

// MARK: - 테이블 뷰 델리게이트 설정
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.phoneBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhoneBookTableViewCell.id, for: indexPath) as? PhoneBookTableViewCell else { return UITableViewCell() }
        
        let phoneBook = CoreDataManager.shared.phoneBooks[indexPath.row]
        
        let imageData = phoneBook.value(forKey: "image") as? Data
        let image = imageData.flatMap { UIImage(data: $0) }
        let name = phoneBook.value(forKey: "name") as? String ?? ""
        let phoneNumber = phoneBook.value(forKey: "phoneNumber") as? String ?? ""
        
        cell.configureCell(image: image, name: name, phoneNumber: phoneNumber)
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
