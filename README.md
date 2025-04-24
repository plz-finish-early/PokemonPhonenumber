# 🐱 포켓몬 전화번호부

## 📖 목차  
1. [프로젝트 소개](#프로젝트-소개)
2. [주요기능](#주요기능)
3. [Preview](#Preview)
4. [개발기간](#개발기간)
5. [기술스택](#기술스택)
6. [프로젝트 파일 구조](#프로젝트-파일-구조)

    
## 👨‍🏫 프로젝트 소개
- 랜덤으로 이미지를 받아와 해당 이미지에 대한 이름과 연락처를 저장할 수 있는 전화번호부입니다.


## 🛠️ 주요기능

- 랜덤 이미지 생성 버튼을 클릭하면 API를 사용해 랜덤으로 이미지를 받아옵니다.

- 이름과 전화번호를 입력 후 적용 버튼을 누르면 해당 이미지와 함께 이름과 연락처가 저장됩니다.


## 📢 Preview

<img width="431" alt="스크린샷 2025-04-23 20 57 22" src="https://github.com/user-attachments/assets/1c8aa9bb-a48d-43b7-a02b-0c0d057aecbf" />



## ⏲️ 개발기간
- 2025.4.14(월) ~ 2025.04.23(수)

## 📚️ 기술스택

### ✔️ Language
- Swift

### ✔️ Version Control
- Git
### ✔️ IDE
- Xcode 16.2

### ✔️ Framework
- UIKit
- SnapKit

### ✔️ 데이터 처리
- Coredata

### ✔️ API 연동
- URLsession

## 🗂️ 프로젝트 파일 구조
```
📁 PokemonPhonebook
├── 📁 PokemonPhonebook
│   ├── AppDelegate.swift                 
│   ├── Assets.xcassets                 
│   ├── CustomCell.swift                  // 연락처 셀 UI
│   ├── Info.plist                       
│   ├── LaunchScreen.storyboard          
│   ├── PhoneBookViewController.swift    // 연락처 추가 화면
│   ├── PokemonModel.swift               // 포켓몬 API 모델 정의
│   ├── PokemonPhonebook.xcdatamodeld    // CoreData 모델
│   ├── ViewController.swift             // 연락처 리스트 메인 화면
```
