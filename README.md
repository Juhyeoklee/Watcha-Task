# Watcha-Task

## 개발 환경
- Xcode 12.4
- Swift 5.3

## 구현 화면

### 1. 검색
![](https://media.giphy.com/media/XqanwxK8YmRAEEcNW5/giphy.gif)

### 2. 상세화면

![](https://media.giphy.com/media/RLglSPc2WME20uL9SF/giphy.gif)

### 3. Favorites 화면

![](https://media.giphy.com/media/5nFEHTYcCJQOu9lYA7/giphy.gif)


## 주요 클래스

### GiphyAPIService
  
- Giphy API를 호출하는 Class  

### DataManager
- CoreData를 관리하는 Class

## 사용 오픈소스

```
pod 'Alamofire', '~> 5.4.1'
pod 'Kingfisher', '~> 5.15.8'
pod 'SwiftyJSON', '~> 5.0.0'
```

### Alamofire

- 간단한 HTTP 통신 코드 작성을 위해 사용

### Kingfisher

- Image 데이터 통신 및 캐싱을 위해 사용

### SwiftyJSON

- json 데이터에서 필요한 데이터를 간단하게 맵핑하기 위해 사용