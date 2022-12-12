# 🌱 새싹 스터디

<img width="1919" alt="SesacMatchingApp_preview" src="https://user-images.githubusercontent.com/88874280/207104157-59c2278c-55b1-4f6b-aae1-9a968ae5ae81.png">

### 현재 사용자 위치에서 스터디를 원하는 사람들을 찾아 매칭해주는 채팅 앱입니다.

- Firebase Auth를 사용하여 사용자 핸드폰을 인증하고, 여러 디바이스에서 로그인 후 사용할 수 있습니다.
- CLLocation을 사용하여 현재 위치를 기준으로 주변에 스터디를 원하는 사람을 찾고, 스터디를 요청 또는 수락할 수 있습니다.
- WebSocket을 사용하여 실시간으로 상대방과 채팅할 수 있습니다.
- StoreKit을 사용하여 인앱 결제로 캐릭터, 배경을 구매할 수 있습니다.
</br><br/>
</br><br/>

## 🛠️ 사용 기술 및 라이브러리

- `Swift`, `UIKit`, `MVVM`, `input•output`, `MapKit`, `CLLocation`, `Network`, `StoreKit`
- `SnapKit`, `RxSwift`, `RxGesture`, `RxKeyboard`, `RxDataSource`, `Firebase`, `Toast-Swift`, `Alamofire`, `Tabman`, `MultiSlider` , `SocketIO`
</br><br/>
</br><br/>

## 🗓️ 개발 기간

- 개발 기간: 2022.11.07 ~ 2022.12.07
- 세부 개발 기간

| 진행사항 | 진행기간 | 세부 내역 |
| --- | --- | --- |
| 회원 인증 및 가입 | 2022.11.07 ~ 2022.11.11 | Onboarding 화면, 회원 인증 및 가입 UI 및 기능 구현 |
| 내 정보 탭 기능 | 2022.11.12 ~ 2022.11.16 | 내 정보 관리 UI 및 화면 구현 |
| 홈 탭 기능 | 2022.11.17 ~ 2022.11.19 | 홈 탭 UI 및 기능 구현, 로직 점검 |
| 새싹 찾기 기능 | 2022.11.20 ~ 2022.11.24 | 스터디 UI 및 검색, 추가 기능, 새싹 찾기 UI 및 기능 구현 |

</br><br/>
</br><br/>

## ✏️ 구현해야 할 기술

- 네트워크 통신 에러에 따른 대응 방안 구축
- Network를 활용한 네트워크 실시간 Monitoring
- 앱 실행 시 사용자 상태에 따른 화면 전환 분기 처리
- Firebase Auth를 활용한 휴대폰 문자 인증 및 로그인
- StackView, SrollView를 활용한 Dynamic Height 구현
- Map내 Custom Annotation 적용
</br><br/>
</br><br/>

## 💡 Trouble Shooting

- 네트워크 통신 중 Study List를 배열로 보내야하는 이슈
    
    → 배열을 Encode할 때 .noBracket으로 Encoding 후 통신하는 방식으로 해결
    

```swift
func asURLRequest() throws -> URLRequest {
        let url = baseURL
        var request = URLRequest(url: url)
        request.method = method
        request.headers = headers

        return try URLEncoding(arrayEncoding: .noBrackets).encode(request, with: parameters)
    }
```
</br><br/>
- 서버와 통신 시 통신 코드가 너무 길어지고, 통신을 할 때 마다 값들을 계속 설정
    
    → URLRequestConvertible Protocol로 Router 생성 및 적용.
    
</br><br/>
- 핸드폰 인증 시 일정 시간이 지나면 인증을 취소 시켜야 하는 이슈
    
    → RxTimer를 사용하여 특정 이벤트에 따라 dispose로 해결.
    

```swift
var timerDisposable: Disposable?

private func resetAndGoTimer() {
        timerDisposable?.dispose()
        timerDisposable = Observable<Int>
            .timer(.seconds(1), period: .seconds(1), scheduler: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { (vc, value) in
                if value > 50, value <= 60 {
                    vc.mainView.timerLabel.text = "00:0\\(60-value)"
                } else if value <= 50 {
                    vc.mainView.timerLabel.text = "00:\\(60-value)"
                } else {
                    UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.authVerificationID.rawValue)
                    vc.timerDisposable?.dispose()
                }
            })
    }
```
</br><br/>
- View 접기/펼치기 동작 시 Layout Error 이슈
    
    → StackView와 [wtfautolayout.com](http://wtfautolayout.com/) 로 해결
    <img width="500" alt="SesacMatchingApp_Issue" src="https://user-images.githubusercontent.com/88874280/207105672-297c030d-6a6e-460e-9297-42feba5f9c0b.png">

</br><br/>
</br><br/>
## 🤔 회고

- 프로젝트를 진행하면서 네트워크 통신 시 Error Handling을 계속 처리해주면서 네트워크 통신 Error 별 처리 및 대응에 조금 능숙해졌다고 생각했다.
- 채팅 기능 중, WebSocket을 사용하여 상대방의 문자를 수신할 수 있지만 송신은 하지 못하기 때문에 네트워크 Post 통신 후 성공 시 처리해주어야 했다. 이 때 발생하는 여러가지 상황들 (통신 시 미리 채팅 버블을 출력 후 통신 실패했을 때 처리 방식 등)을 고민하는 계기가 되었다. 추후 리팩토링 시 이 이슈에 대하여 좀 더 세부적으로 처리해보고 싶었다.
- 채팅 기능 중, WebSocket을 사용하여 사용자의 문자를 송신할 때 id값을 가져올 수 없기 때문에 클라이언트 단에서 우선적으로 id값을 주어야 했다. 여기서 nil값으로 우선 처리하였는데 이 부분이 조금 아쉬웠다. nil값으로 처리하더라도 추후 데이터를 받는 과정에서 id값을 불러와서 교체해주는 방식으로 리팩토링하면 어떨까 생각했다.
</br><br/>
