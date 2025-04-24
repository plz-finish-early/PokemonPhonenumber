# nbcampContactsApp
nbcampContactsApp는 Swift 학습을 목적으로 작성된 iOS용 연락처 애플리케이션입니다.

## 프로젝트 개요
-   **프로젝트 이름**: nbcampContactsApp
-   **설명**: 내일배움캠프 iOS 스타터 과정 6주차 앱 개발 숙련 주차의 과제로, Swift 언어 학습의 결과물입니다.
-   **목표**: 화면 전환, 데이터 관리, 네트워크 통신, 메모리 관리 등 데이터 일관성을 유지하며 사용자 경험을 향상시키고, 외부 자원과 데이터를 안정적으로 주고받는 방법 학습

## 주요기능

- API를 통한 네트워크에서 데이터 호출
- CoreData를 활용한 데이터 저장
- TableView leading/trailing SwipeAction을 통한 데이터 변경, 삭제

## 개발기간

2024.04.14(월) ~ 2024.04.24(목)  

## 기술스택

### 언어
| 종류 | 내용 |
|------|------|
| IDE | Xcode16 |
| Language | Swift5 |
| TargetOS | iOS 16 |

### 라이브러리
| 종류 | 내용 |
|------|------|
| UI | UIKit + [SnapKit](https://github.com/SnapKit/SnapKit.git) 5.7.1 |
| Network | [Alamofire](https://github.com/Alamofire/Alamofire) 5.10.2 |
| Data | CoreData |

## 프로젝트 구조 및 역활 

### 파일별 역활

#### View
`ContactsListCell.swift` : UITableView 커스텀 셀

#### ViewController
`ContactsDetailViewController.swift` : 연락처 저장 및 수정 UI 표시 및 연산
`ContactsListViewController.swift` : 연락처 메인 UI 표시 및 연산

#### Model
`AlertError.swift` : 사용자 정의 에러 타입 정의
`Contact.swift` : CoreData 입출력 데이터 모델
`CoreDataManager.swift` : CoreData 입출력 관리
`EvolutionResult.swift`: JSON 디코딩용 구조체, 메서드 정의
`NetworkServices.swift`: JSON 디코딩용 구조체 정의
`RandomResult.swift`: JSON 디코딩용 구조체 정의
`SpeciesResult.swift`: JSON 디코딩용 구조체 정의

### 프로젝트 구조
```
PokemonPhonenumber
└── LCH-1228
   ├── nbcampContactsApp
   │   ├── AppDelegate.swift
   │   ├── Assets.xcassets
   │   ├── Base.lproj
   │   │   └── LaunchScreen.storyboard
   │   ├── Info.plist
   │   ├── Model
   │   │   ├── AlertError.swift
   │   │   ├── Contact.swift
   │   │   ├── CoreDataManager.swift
   │   │   ├── EvolutionResult.swift
   │   │   ├── NetworkServices.swift
   │   │   ├── RandomResult.swift
   │   │   └── SpeciesResult.swift
   │   ├── nbcampContactsApp.xcdatamodeld
   │   ├── SceneDelegate.swift
   │   ├── View
   │   │   └── ContactsListCell.swift
   │   └── ViewController
   │       ├── ContactsDetailViewController.swift
   │       └── ContactsListViewController.swift
   ├── nbcampContactsApp.xcodeproj
   ├── PhoneBook+CoreDataClass.swift
   ├── PhoneBook+CoreDataProperties.swift
   └── ReadMe.md
```
## 샘플이미지
<div style="display: flex; gap: 10px; justify-content: center;">
  <img src="https://github.com/plz-finish-early/PokemonPhonenumber/blob/mnh4140Develop/LCH-1228/SampleImage/ListViewUI.png?raw=true" alt="메인화면" width="30%">
  <img src="https://github.com/plz-finish-early/PokemonPhonenumber/blob/mnh4140Develop/LCH-1228/SampleImage/DetailViewUI.png?raw=true" alt="연락처 추가 수정 화면" width="30%">
  <img src="https://github.com/plz-finish-early/PokemonPhonenumber/blob/mnh4140Develop/LCH-1228/SampleImage/Alert.png?raw=true" alt="Alert예시" width="30%">
</div>

<br/>

<div style="display: flex; gap: 10px; justify-content: center;">
  <img src="https://github.com/plz-finish-early/PokemonPhonenumber/blob/mnh4140Develop/LCH-1228/SampleImage/LeadingSwipeAction.png?raw=true" alt="LeadingSwipeAction" width="45%">
  <img src="https://github.com/plz-finish-early/PokemonPhonenumber/blob/mnh4140Develop/LCH-1228/SampleImage/TrailingSwipeAction.png?raw=true" alt="TrailingSwapeAction" width="45%">
</div>

## 실행방법

1. 레포지토리 클론
```shell
git clone https://github.com/plz-finish-early/PokemonPhonenumber.git
```

2. 프로젝트 파일 실행

**실행시 유의사항**
[iOS18.4 시뮬레이터 오류](https://developer.apple.com/forums/thread/777999)로 추정되는 현상이 있어서 해당 버전에서 정상 동작 안함.
