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
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(PhoneBookTableViewCell.self, forCellReuseIdentifier: PhoneBookTableViewCell.id)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setTitleLabel()
        setAddButton()
        setTableView()
    }
    
    private func setTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.width.equalTo(80)
            //$0.top.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setAddButton() {
        view.addSubview(addButton)
        
        addButton.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.height.equalTo(titleLabel.snp.height)
            $0.top.equalToSuperview().offset(80)
            //$0.centerY.equalTo(tableView.snp.centerY)
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
    
    @objc
    private func buttonTapped() {
        self.navigationController?.pushViewController(PhoneBookViewController(), animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhoneBookTableViewCell.id, for: indexPath) as? PhoneBookTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
