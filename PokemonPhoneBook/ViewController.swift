//
//  ViewController.swift
//  PokemonPhoneBook
//
//  Created by NH on 4/18/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let testLabel: UILabel = {
       let label = UILabel()
        label.text = "Hello"
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(testLabel)
        
        testLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(200)
            $0.horizontalEdges.equalToSuperview()
        }
    }
}

