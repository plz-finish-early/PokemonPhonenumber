//
//  PhoneBookListViewController.swift
//  pokemony
//
//  Created by JIN LEE on 4/21/25.
//

import UIKit

class PhoneBookListViewController: UIViewController {
    
    let topButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("추가", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        return button
    }()
    
    let topLabel: UILabel = {
        let label = UILabel()
        label.text = "친구 목록"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let phoneBookListTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(PhoneBookListCell.self, forCellReuseIdentifier: PhoneBookListCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        topButton.addTarget(self, action: #selector(addContactPop), for: .touchUpInside)
        
        phoneBookListTableView.delegate = self
        phoneBookListTableView.dataSource = self
    }
    
    @objc func addContactPop() {
        let secondVC = AddContactViewController()
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        [topLabel, topButton, phoneBookListTableView].forEach {
            view.addSubview($0)
        }
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topButton.translatesAutoresizingMaskIntoConstraints = false
        phoneBookListTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),

            topButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            topButton.centerYAnchor.constraint(equalTo: topLabel.centerYAnchor),
            
            phoneBookListTableView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 20),
            phoneBookListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            phoneBookListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            phoneBookListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor) // ⭐️
        ])
        
    }
}

extension PhoneBookListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView:UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhoneBookListCell.identifier, for: indexPath) as? PhoneBookListCell else { return UITableViewCell() }
        return cell
    }
}
