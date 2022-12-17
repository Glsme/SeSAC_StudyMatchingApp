# 🌱 새싹 스터디

<img width="1919" alt="SesacMatchingApp_preview" src="https://user-images.githubusercontent.com/88874280/207104157-59c2278c-55b1-4f6b-aae1-9a968ae5ae81.png">

### 현재 사용자 위치에서 스터디를 원하는 사람들을 찾아 매칭해주는 채팅 앱입니다.

- Firebase Auth를 사용하여 사용자 핸드폰을 인증하고, 여러 디바이스에서 로그인 후 사용할 수 있습니다.
- FCM을 사용하여 Push를 수신할 수 있습니다.
- 네트워크 통신을 하여 각 상황에서 사용자의 정보 및 다양한 데이터를 핸들링할 수 있습니다.
- CLLocation을 사용하여 현재 위치를 기준으로 주변에 스터디를 원하는 사람을 찾고, 스터디를 요청 또는 수락할 수 있습니다.
- WebSocket을 사용하여 실시간으로 상대방과 채팅할 수 있습니다.
- StoreKit을 사용하여 인앱 결제로 캐릭터, 배경을 구매할 수 있습니다.
</br><br/>
</br><br/>

## 🛠️ 사용 기술 및 라이브러리

- `Swift`, `MVVM`, `UIKit`, `input•output`, `MapKit`, `CLLocation`, `Network`, `StoreKit` , `APNs`
- `RxSwift`, `RxCocoa`, `RxGesture`, `RxKeyboard`, `RxDataSource`, `FirebaseAuth`, `FirebaseMessaging`, `SnapKit`, `Toast-Swift`, `Alamofire`, `Tabman`, `MultiSlider` , `SocketIO`
</br><br/>
</br><br/>

## 🗓️ 개발 기간

- 개발 기간: 2022.11.07 ~ 2022.12.07 (1개월)
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
- StoreKit을 활용한 인앱 결제 시스템
</br><br/>
</br><br/>

## 💡 Trouble Shooting

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

- Map에서 사용자가 위치를 변경할 때 API를 호출해야하는 이슈
    
    → 위치를 옮기고 나서 0.8초 후에 사용자의 위치 파악 후 API를 호출하는 방식으로 해결.
    

```swift
func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if !animated {
            let lat = mapView.region.center.latitude
            let long = mapView.region.center.longitude
            
            DispatchQueue.global().async { [weak self] in
                guard let self = self else { return }
                usleep(800000)
                if lat == mapView.region.center.latitude, long == mapView.region.center.longitude {
                    self.searchData()
                }
            }
        }
    }
```

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

- 스터디 수락 버튼 탭 시 Chatting화면으로 넘어가야 하는 이슈
    
    → PopupView를 Dismiss 후 CompletionHandler를 통해 TopViewController를 찾고 Push 해주는 방식 적용.
    

```swift
self.dismiss(animated: false) {
                        let chatVC = ChattingViewController()
                        chatVC.viewModel.data = data
                        guard let vc = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
                        vc.transViewController(ViewController: chatVC, type: .push)
}
```

</br><br/>
</br><br/>
## 🤔 회고

- 프로젝트를 진행하면서 네트워크 통신 시 Error Handling을 계속 처리해주면서 네트워크 통신 Error 별 처리 및 대응에 조금 능숙해졌다고 생각했다. 하지만 각 API별로 중복되는 Error Code에 대해서 처리를 좀 더 깔끔하게 해주면 어땠을까 생각했다.
- 채팅 기능 중, WebSocket을 사용하여 상대방의 문자를 수신할 수 있지만 송신은 하지 못하기 때문에 네트워크 Post 통신 후 성공 시 처리해주어야 했다. 이 때 발생하는 여러가지 상황들 (통신 시 미리 채팅 버블을 출력 후 통신 실패했을 때 처리 방식 등)을 고민하는 계기가 되었다. 추후 리팩토링 시 이 이슈에 대하여 좀 더 세부적으로 처리해보고 싶었다.
- 채팅 기능 중, WebSocket을 사용하여 사용자의 문자를 송신할 때 id값을 가져올 수 없기 때문에 클라이언트 단에서 우선적으로 id값을 주어야 했다. 여기서 nil값으로 우선 처리하였는데 이 부분이 조금 아쉬웠다. nil값으로 처리하더라도 추후 데이터를 받는 과정에서 id값을 불러와서 교체해주는 방식으로 리팩토링하면 어떨까 생각했다.
- 현재 핸드폰 인증 UI에서 Timer가 1분 동안 인증 체크 후, 시간이 만료되면 인증 번호를 재전송 해야하는 방식이다. 하지만 Foreground에서만 Timer가 동작하기때문에, 사용자가 앱을 Background로 이동했다가 다시 Foreground로 이동했을 때 그 시간을 체크하지 못한 채 Timer가 동작한다. 만약 Background에서도 Timer가 동작하려면 Background에서 Forground로 왔을 때 시간을 체크 후 Timer에 반영시키면 어떨까 생각했다.
- 새싹샵 UI에서 Tabman Library를 사용하여 2개의 ViewController를 사용하고 있다. 이 중 첫 번째로 보여지는 ViewController는 Tabman을 사용하는 ViewController의`viewDidLoad()`가 실행됨에 따라 같이 `viewDidLoad()`가 실행되지만, 두번째 ViewController는 사용자가 화면을 옮기지 않는 이상 `viewDidLoad()`가 실행되지 않는다. 따라서 첫 번째 ViewController의 `ViewDidLoad()`가 실행될 때 두 번째 ViewController의 `viewDidLoad()`를 실행해줌으로 이슈를 해결하였는데, 이 방법이 과연 맞는 방법인지 생각했다.
</br><br/>
