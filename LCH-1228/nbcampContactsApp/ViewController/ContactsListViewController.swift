//
//  ContactsListViewController.swift
//  nbcampContactsApp
//
//  Created by Chanho Lee on 4/16/25.
//

import UIKit
import SnapKit

class ContactsListViewController: UIViewController {
    
    private var data: [Contact] = []
        
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
        reloadData()
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
    
    private func reloadData() {
        data = CoreDataManager.shard.getAllData().sorted{
            $0.name < $1.name
        }
        contactList.reloadData()
    }
    
    @objc private func showContactsDetailView() {
        navigationController?.pushViewController(ContactsDetailViewController(), animated: false)
    }
}

extension ContactsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contactsDetailViewController = ContactsDetailViewController()
        contactsDetailViewController.indexPath = indexPath
        
        contactsDetailViewController.configureEditUI()
        
        navigationController?.pushViewController(contactsDetailViewController, animated: false)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "방생하기") { [weak self] (UIContextualAction, UIView, result: @escaping (Bool) -> Void) in
            print("방생하기 실행됨")
            
            guard let self = self else {
                result(false)
                return
            }
            let targetContact = data[indexPath.row]
            CoreDataManager.shard.deleteData(contact: targetContact)
            reloadData()
            result(true)
        }
        print("방생하기 버튼 표시")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
    
extension ContactsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactsListCell.identifier, for: indexPath) as? ContactsListCell else {
            return UITableViewCell()
        }
        
        cell.nameLabel.text = data[indexPath.row].name
        cell.numberLabel.text = data[indexPath.row].phoneNumber
        cell.profileImage.image = UIImage(data: data[indexPath.row].profileImage)
        
        return cell
    }
}
