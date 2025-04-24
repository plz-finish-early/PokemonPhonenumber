//
//  AlertError.swift
//  nbcampContactsApp
//
//  Created by Chanho Lee on 4/23/25.
//
protocol AlertError {
    var alertMessage: String { get }
}

enum CustomNetworkError: String, Error, AlertError {
    case invalidURL = "URL 생성에 실패했습니다."
    var alertMessage: String { rawValue }
}

enum ContactsDetailViewError: String, Error, AlertError {
    case nameTextFieldIsEmpty = "이름을 입력해주세요."
    case numberTextFiledIsEmpty = "전화번호를 입력해주세요."
    case faildCovertingProfileImage = "프로필 저장에 실패했습니다."
    
    var alertMessage: String { rawValue }
}
