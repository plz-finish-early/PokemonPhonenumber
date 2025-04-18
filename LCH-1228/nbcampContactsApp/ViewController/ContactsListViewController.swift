//
//  ContactsListViewController.swift
//  nbcampContactsApp
//
//  Created by Chanho Lee on 4/16/25.
//

import UIKit
import SnapKit

class ContactsListViewController: UIViewController {
        
    private lazy var contactList: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactsListCell.self, forCellReuseIdentifier: ContactsListCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("vewDidLoad[ViewController]")

        configureUI()
        configureNav()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        contactList.reloadData()
    }
    
    private func configureUI() {
        [
            contactList,
        ].forEach{ view.addSubview($0) }
        
        contactList.snp.makeConstraints {
            $0.size.equalToSuperview()
            $0.center.equalToSuperview()
        }
    }
    
    private func configureNav() {
        navigationItem.title = "포켓몬 목록"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(showContactsDetailView))
    }
    
    @objc private func showContactsDetailView() {
        navigationController?.pushViewController(ContactsDetailViewController(), animated: false)
    }
}

extension ContactsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ContactsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = CoreDataManager.shard.getAllData()
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactsListCell.identifier, for: indexPath) as? ContactsListCell else {
            return UITableViewCell()
        }
        let data = CoreDataManager.shard.getAllData().sorted{
            $0.name < $1.name
        }
        cell.nameLabel.text = data[indexPath.row].name
        cell.numberLabel.text = data[indexPath.row].phoneNumber
        cell.profileImage.image = UIImage(data: data[indexPath.row].profileImage)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = CoreDataManager.shard.getAllData().sorted{
            $0.name < $1.name
        }
        let contactsDetailViewController = ContactsDetailViewController()
        
        contactsDetailViewController.currentUUID = data[indexPath.row].uuid.uuidString
        contactsDetailViewController.nameTextField.text = data[indexPath.row].name
        contactsDetailViewController.numberTextField.text = data[indexPath.row].phoneNumber
        contactsDetailViewController.profileImage.image = UIImage(data: data[indexPath.row].profileImage)
        
        if !contactsDetailViewController.isViewLoaded {
            contactsDetailViewController.loadViewIfNeeded()
        }
        contactsDetailViewController.configureEditNav(title: data[indexPath.row].name, buttonName: "수정")
        
        navigationController?.pushViewController(contactsDetailViewController, animated: false)
    }
}
