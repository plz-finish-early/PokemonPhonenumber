//
//  AlertError.swift
//  nbcampContactsApp
//
//  Created by Chanho Lee on 4/23/25.
//

// AlertError 프로토콜 정의
protocol AlertError {
    
    //alerMessage get-only 프로퍼티로 정의
    var alertMessage: String { get }
}

//네크워크 에러
enum CustomNetworkError: String, Error, AlertError {
    case invalidURL = "유효하지 않은 URL이 입력되었습니다."
    case failedGeratingRandomURL = "랜덤 URL 생성에 실패했습니다."
    case failedGettingImageURL = "이미지 URL 가져오기에 실패했습니다."
    
    //원시값을 반환하는 변수
    var alertMessage: String {
        return rawValue
    }
}

//ContactDetailView에서 발생하는 에러
enum ContactsDetailViewError: String, Error, AlertError {
    case nameTextFieldIsEmpty = "이름을 입력해주세요."
    case numberTextFiledIsEmpty = "전화번호를 입력해주세요."
    case failedCovertingProfileImage = "프로필 이미지 저장에 실패했습니다."
    
    var alertMessage: String { rawValue }
}

//진화과정에서 발생하는 에러
enum EvolutionError: String, Error, AlertError {
    case NoEvolutionChain = "진화형태가 1개인 포켓몬 입니다."
    case failedGeneratingIndex = "진화에 실패했습니다.\n개발자에게 문의해 주세요."
    case currentChainIsLast = "현재가 최종진화형태입니다."
    
    var alertMessage: String { rawValue }
}
