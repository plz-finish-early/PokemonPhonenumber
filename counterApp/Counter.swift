//
//  Counter.swift
//  counterApp
//
//  Created by JIN LEE on 4/21/25.
//

import UIKit

class Counter: ObservableObject {
    
    @objc func count() {
        var countedNumber: Int = 0
        var oddNumber = 0
        var evenNumber = 0
        
        countedNumber += 1
          
        if countedNumber % 2 == 0 {
            evenNumber += 1
            print("\(countedNumber)번째 클릭, 짝수(총 \(oddNumber)번")
        } else {
            oddNumber += 1
            print("\(countedNumber)번째 클릭, 홀수(총 \(oddNumber)번")
        }
    }
}
