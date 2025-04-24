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
    case invalidURL = "유효하지 않은 URL이 입력되었습니다."
    case failedGeratingRandomURL = "랜덤 URL 생성에 실패했습니다."
    case failedGettingImageURL = "이미지 URL 가져오기에 실패했습니다."
    
    var alertMessage: String { rawValue }
}

enum ContactsDetailViewError: String, Error, AlertError {
    case nameTextFieldIsEmpty = "이름을 입력해주세요."
    case numberTextFiledIsEmpty = "전화번호를 입력해주세요."
    case failedCovertingProfileImage = "프로필 이미지 저장에 실패했습니다."
    
    var alertMessage: String { rawValue }
}

enum EvolutionError: String, Error, AlertError {
    case NoEvolutionChain = "진화형태가 1개인 포켓몬 입니다."
    case failedGeneratingIndex = "진화에 실패했습니다.\n개발자에게 문의해 주세요."
    case currentChainIsLast = "현재가 최종진화형태입니다."
    
    var alertMessage: String { rawValue }
}
