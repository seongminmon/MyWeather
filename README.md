
# CityWeather
도시를 검색하여 선택한 도시의 날씨 정보를 알려주는 서비스

![1](https://github.com/user-attachments/assets/2f1d19cf-bb0b-4595-9f31-0c5c2f93c86d) | ![2](https://github.com/user-attachments/assets/04016a51-5287-4860-96f4-3ba5b08107d3) | ![4](https://github.com/user-attachments/assets/cd6497be-8e66-467a-bb87-02fda369d3a2) | ![5](https://github.com/user-attachments/assets/c41d1a67-6d51-4a8d-ab8d-bdeb0d05e867)
---|---| ---| ---|

## 프로젝트 환경

- 개발 인원: iOS 1
- 개발 기간: 24.07.12 ~ 24.07.21 (10일)
- 최소 버전: iOS 15.0

## 기술 스택

- 🎨 View Drawing - `UIKit`  
- 🏛️ Architecture - `MVVM`  
- ♻️ Asynchronous - `GCD / CompletionHandler`  
- 📡 Network - `Alamofire`  
- 🏞️ Image Loader - `Kingfisher`  
- 🎸 기타 - `SnapKit` `Then`

## 주요 기능
- 현재 기온과 날씨
- 3시간 간격의 일기예보
- 5일 간의 일기예보
- 지도의 좌표를 통해 도시 선택
- 도시 이름으로 검색

## 주요 기술

### MVVM 아키텍처
- Custom Observable을 통한 Input / Output 패턴 사용
- View와 ViewModel을 주입 받는 Generic 타입의 BaseViewController 사용
- DI를 통한 의존성 분리

### 네트워크
- baseURL, parameters 등으로 구성된 Custom 라우터 패턴을 사용해 네트워크 통신 관리
- API 모델과 Presentation 모델을 구분
- ViewModel에서 API 모델에서 Presentation 모델로 변환하여 사용

### UI
- UIVisualEffectView를 활용한 자연스러운 UI 구현
- StackView를 CollectionView와 TableView로 리팩토링하여 중복되는 UI 인스턴스 감소

### Local Json
- 도시 리스트를 Local Json 파일로 관리
- Bundle.main을 통해 파일을 불러오고 Data 형태로 변경
- JSONDecoder를 통해 불러온 Data를 Decodable을 채택한 모델로 역직렬화하여 사용
