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
    case invalidURL = "유효하지 않는 URL입니다."
    var alertMessage: String { rawValue }
}

enum ContactsDetailViewError: String, Error, AlertError {
    case nameTextFieldIsEmpty = "이름 텍스트필드가 비어있습니다."
    case numberTextFiledIsEmpty = "번호 텍스트필드가 비어있습니다."
    case faildCovertingProfileImage = "프로필 이미지 변경에 실패했습니다."
    
    var alertMessage: String { rawValue }
}
