//
//  PhoneBookListViewController.swift
//  pokemony
//
//  Created by JIN LEE on 4/21/25.
//

import UIKit
import CoreData

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
    
    let phoneBookListTableView = UITableView()
    
    // 추가: Core Data용 Fetched Results Controller
    lazy var fetchedResultsController: NSFetchedResultsController<PhoneBook> = {
        let fetchRequest: NSFetchRequest<PhoneBook> = PhoneBook.fetchRequest()
        // 이름 순 정렬
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        controller.delegate = self
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        performFetch()
        
        topButton.addTarget(self, action: #selector(addContactPop), for: .touchUpInside)
        
        phoneBookListTableView.delegate = self
        phoneBookListTableView.dataSource = self
    }
    
    @objc func addContactPop() {
        let secondVC = AddContactViewController()
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    private func performFetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("패치 실패: \(error)")
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        [topLabel, topButton, phoneBookListTableView].forEach {
            view.addSubview($0)
        }
        
        phoneBookListTableView.backgroundColor = .white
        phoneBookListTableView.register(PhoneBookListCell.self, forCellReuseIdentifier: PhoneBookListCell.identifier)
        
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
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhoneBookListCell.identifier, for: indexPath) as? PhoneBookListCell else { return UITableViewCell() }
        // 현재 행에 해당하는 PhoneBook 객체 가져오기
        let phoneBook = fetchedResultsController.object(at: indexPath)
        cell.configure(with: phoneBook) // 셀에 데이터 전달
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedContact = fetchedResultsController.object(at: indexPath)
        let addVC = AddContactViewController()
        addVC.contactToEdit = selectedContact // 데이터 전달
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let contactToDelete = fetchedResultsController.object(at: indexPath)
            context.delete(contactToDelete)
            do {
                try context.save()
            } catch {
                print("삭제 실패: \(error)")
            }
        }
    }
}

extension PhoneBookListViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        phoneBookListTableView.reloadData()
    }
}
