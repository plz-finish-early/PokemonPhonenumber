//
//  ViewController.swift
//  counterApp
//
//  Created by JIN LEE on 4/21/25.
//

import UIKit

class CounterViewController: UIViewController {
    let counter = Counter()
    
    let counterLabel: UILabel = {
        let label = UILabel()
        label.text = "카운트하기"
        return label
    }()
    
    let countButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        //button.addTarget(self, action: #selector(counter.count), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(counterLabel)
        view.addSubview(countButton)
        
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        countButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            counterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            counterLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            countButton.topAnchor.constraint(equalTo:counterLabel.bottomAnchor, constant: 10),
            countButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
}
