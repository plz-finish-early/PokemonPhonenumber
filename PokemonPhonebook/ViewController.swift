//
//  ViewController.swift
//  PokemonPhonebook
//
//  Created by 전원식 on 4/22/25.
//

import UIKit
import SnapKit
import CoreData

class ViewController: UIViewController {
    
    private var contactList: [CDContactEntity] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configure()
        setupTableView()
        addButton.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchContacts()
    }


    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(mainLabel)
        view.addSubview(addButton)
        view.bringSubviewToFront(addButton)
    }

    private func configure() {
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }

        addButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
            make.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(30)
        }

        tableView.rowHeight = 80
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
    }

    private var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    private var mainLabel: UILabel = {
        let mainLabel = UILabel()
        mainLabel.font = .boldSystemFont(ofSize: 30)
        mainLabel.text = "친구 목록"
        return mainLabel
    }()

    private var addButton: UIButton = {
        let addButton = UIButton()
        addButton.setTitle("추가", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 15)
        addButton.setTitleColor(.black, for: .normal)
        return addButton
    }()
    
    @objc func didTapAdd() {
        let vc = PhoneBookViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func fetchContacts() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<CDContactEntity> = CDContactEntity.fetchRequest()
        
        do {
            contactList = try context.fetch(request)
            tableView.reloadData()
        } catch {
            print("연락처 불러오기 실패: \(error.localizedDescription)")
        }
    }

    
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell else {
            return UITableViewCell()
        }
        
        let contact = contactList[indexPath.row]
        cell.nameLabel.text = contact.name
        cell.phoneLabel.text = contact.phoneNumber
        
        if let imageData = contact.imageData {
            cell.iconView.image = UIImage(data: imageData)
        } else {
            cell.iconView.image = UIImage(systemName: "person.circle")
        }

        return cell
    }
    
    
}
