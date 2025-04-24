//
//  ContactsListViewController.swift
//  nbcampContactsApp
//
//  Created by Chanho Lee on 4/16/25.
//

import UIKit
import SnapKit
import Alamofire

class ContactsListViewController: UIViewController {
    
    private var data: [Contact] = []
    
    private lazy var contactList: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactsListCell.self,
                           forCellReuseIdentifier: ContactsListCell.identifier)
        return tableView
    }()
}

extension ContactsListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("vewDidLoad[ViewController]")
        
        configureUI()
        configureNav()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadData()
    }
}

private extension ContactsListViewController {
    
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
    
    // 데이터 정렬 및 재로딩을 위한 메서드
    private func reloadData() {
        data = CoreDataManager.shared.getAllData().sorted{
            $0.name < $1.name
        }
        contactList.reloadData()
    }
    
    //진화시 기존에 이미지가 없을 경우 랜덤이미지 생성을 위한 메서드
    private func getRandomImage(contact: Contact) {
        let networkServices = NetworkServices()
        
        //API로 부터 Image URL 정보를 받기 위한 메서드 호출
        networkServices.fetchRandomData {  [weak self] (result: Result<RandomResult, Error>) in
            switch result {
            case .success(let result):
                do {
                    guard let imageURL = URL(string: result.sprites.other.officialArtwork.frontDefault) else {
                        throw CustomNetworkError.failedGettingImageURL
                    }
                    
                    //API로부터 전달받은 Image URL 정보로 이미지 호출
                    AF.request(imageURL).response { [weak self] response in
                        if let data = response.data, let image = UIImage(data: data)?.pngData() {
                            let newContact = Contact(uuid: contact.uuid,
                                                     name: contact.name,
                                                     phoneNumber: contact.phoneNumber,
                                                     profileImage: image,
                                                     imageName: result.species.name)
                            
                            //전달 받은 이미지와 포켓몬 이름으로 기존 데이터 업데이트
                            CoreDataManager.shared.updateData(contact: newContact)
                            self?.reloadData()
                        }
                    }
                } catch {
                    guard let error = error as? CustomNetworkError else { return }
                    self?.showAlert(error)
                }
            case .failure(let error):
                guard let error = error as? CustomNetworkError else {
                    print(error)
                    return
                }
                self?.showAlert(error)
            }
        }
    }
    
    //진화기능을 위한 메서드
    private func makeEvolve(contact: Contact) {
        let imageName = contact.imageName
        guard imageName != "" else {
            print("이름이 없어 랜덤으로 생성")
            getRandomImage(contact: contact)
            return
        }
        
        let networkServices = NetworkServices()
        
        //API로 부터 이름을 기준으로 진화정보를 받는 메서드 호출
        networkServices.fetchEvolutionData(name: imageName) { [weak self] response in
            switch response {
            case .success(let result):
                do {
                    //진화 단계 배열
                    let evolutionStepArray = makeEvolutionArray(from: result.chain)
                    
                    //진화 단계가 1개만 있을경우 예외처리
                    guard evolutionStepArray.count != 1 else {
                        throw EvolutionError.NoEvolutionChain
                    }
                    
                    //진화 단계 인덱스 생성 실패시 예외처리
                    guard let index = evolutionStepArray.firstIndex(of: [imageName]) else {
                        throw EvolutionError.failedGeneratingIndex
                    }
                    
                    //진화 단계가 마지막일 경우 예외처리
                    guard evolutionStepArray.count - 1 != index else {
                        throw EvolutionError.currentChainIsLast
                    }
                    
                    //진화 후 이름
                    var evolvedName: String?
                    let evolvedNameArray = evolutionStepArray[index + 1]
                    
                    //진화시 다음단계가 여러개인 경우 랜덤한 값으로 설정
                    evolvedName = evolvedNameArray.randomElement()
                    
                    guard let evolvedName = evolvedName else {
                        print("이름 추출 실패")
                        return
                    }
                    
                    //API로 부터 진화 후 이름을 기준으로 ImageURL 정보를 받기위한 메서드
                    networkServices.fetchDataByName(name: evolvedName) { [weak self] response in
                        
                        switch response {
                        case .success(let callImageresult):
                            do {
                                guard let imageURL = URL(string: callImageresult.sprites.other.officialArtwork.frontDefault) else {
                                    throw CustomNetworkError.failedGettingImageURL
                                }
                                
                                //API로부터 전달받은 Image URL 정보로 이미지 호출
                                AF.request(imageURL).response { [weak self] response in
                                    if let data = response.data, let evolvedimage = UIImage(data: data)?.pngData() {
                                        let newContact = Contact(uuid: contact.uuid,
                                                                 name: contact.name,
                                                                 phoneNumber: contact.phoneNumber,
                                                                 profileImage: evolvedimage,
                                                                 imageName: evolvedName)
                                        
                                        //전달 받은 이미지와 포켓몬 이름으로 기존 데이터 업데이트
                                        CoreDataManager.shared.updateData(contact: newContact)
                                        self?.reloadData()
                                    }
                                }
                            } catch {
                                guard let error = error as? CustomNetworkError else { return }
                                self?.showAlert(error)
                            }
                        case .failure(let error):
                            guard let error = error as? EvolutionError else {
                                print(error)
                                return
                            }
                            self?.showAlert(error)
                        }
                    }
                } catch {
                    guard let error = error as? EvolutionError else { return }
                    self?.showAlert(error)
                }
            case .failure(let error):
                guard let error = error as? EvolutionError else {
                    print(error)
                    return
                }
                self?.showAlert(error)
            }
        }
    }
    
    //예외처리 Alert 표시를 위한 메서드
    private func showAlert(_ error: Error) {
        guard let alertError = error as? AlertError else { return }
        let alert = UIAlertController(title: nil, message: alertError.alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)
    }
    
    //추가 버튼 클릭시 동작
    @objc private func showContactsDetailView() {
        navigationController?.pushViewController(ContactsDetailViewController(), animated: false)
    }
}

extension ContactsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //ContactsDetailViewController 인스턴스 생성
        let contactsDetailViewController = ContactsDetailViewController()
        
        //선택된 Cell의 indexPath 전달
        contactsDetailViewController.indexPath = indexPath
        
        //전달받은 indexPath로 UI설정
        contactsDetailViewController.configureEditUI()
        
        navigationController?.pushViewController(contactsDetailViewController, animated: false)
    }
    
    // TableView leadingSwipeAction에 진화 버튼 정의
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let upgrade = UIContextualAction(style: .normal, title: "진화하기") { [weak self] (UIContextualAction, UIView, result: @escaping (Bool) -> Void) in
            print("진화하기 실행됨")
            guard let self = self else {
                result(false)
                return
            }
            let targetContact = data[indexPath.row]
            makeEvolve(contact: targetContact)
            result(true)
        }
        upgrade.backgroundColor = .systemOrange
        
        print("leadinSwipeAction 버튼 표시")
        
        return UISwipeActionsConfiguration(actions: [upgrade])
    }
    
    // TableView trailingSwipeAction에 삭제 버튼 정의
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "방생하기") { [weak self] (UIContextualAction, UIView, result: @escaping (Bool) -> Void) in
            print("방생하기 실행됨")
            
            guard let self = self else {
                result(false)
                return
            }
            let targetContact = data[indexPath.row]
            CoreDataManager.shared.deleteData(contact: targetContact)
            reloadData()
            result(true)
        }
        print("leadinSwipeAction 버튼 표시")
        
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
        
        cell.configureCell(data: data[indexPath.row])
        
        return cell
    }
}
