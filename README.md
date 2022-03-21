# SNSLogin Practice

## NAVER Login

### Pod Install
- [Naver ID Login SDK for iOS](https://github.com/naver/naveridlogin-sdk-ios)

``` swift
pod 'naveridlogin-sdk-ios'
```
- 나중에 회원 정보를 가져와야 하므로 [Alamofire](https://github.com/Alamofire/Alamofire)도 설치하자
``` swift
pod 'Alamofire'
```
---
### UI구현
- `로그인` 버튼과 `로그아웃` 버튼, 로그인이 완료됐을 때 보여질 `이름`, `이메일`, `아이디(id)` 라벨
![](https://images.velog.io/images/yc1303/post/539eca9e-dc65-4a10-aa81-82b709f366df/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202022-03-21%20%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE%206.10.59.png)
---
### URL Schemes 설정
- Xcode에서 `Project`의 `Targets`에서 `Info`를 선택
![](https://images.velog.io/images/yc1303/post/e2d08903-1988-45ef-9b42-d29831e789c8/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202022-03-21%20%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE%206.19.10.png)
- 하단의 `URL Types`를 열고 다음과 같이 추가한다
![](https://images.velog.io/images/yc1303/post/3ae51e86-c5b8-4561-80e3-d44587db8955/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202022-03-21%20%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE%206.19.54.png)
> `URL Schemes`의 이름은 소문자로 해야 한다
---
### [NAVER Developers](https://developers.naver.com/main/)
- 여기에서 애플리케이션을 등록해준다
![](https://images.velog.io/images/yc1303/post/a608ce26-331b-45b9-b580-0bcd0c84b706/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202022-03-21%20%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE%206.24.26.png)
- 사용 API에서 네이버 로그인을 선택해준다
- 로그인할 때 필요한 정보를 체크
- 로그인 오픈 API 서비스 환경은 iOS로 선택
- `URL Scheme`에 위에서 설정한 URL Scheme을 쓴다
- 등록을 완료하고 내 애플리케이션에 들어가면
- 애플리케이션 정보에 `Client ID`와 `Client Secret`이 있다
---
### Info.plist
- `Info.plist`에 다음과 같이 추가한다
![](https://images.velog.io/images/yc1303/post/4869a33b-8648-400e-a614-20c947a40ef0/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202022-03-21%20%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE%206.33.12.png)
> 근데 이거 없어도 잘 동작하던데...
---
### 상수 설정
- `AppDelegate.swift`에 `NaverThirdPartyLogin`를 `import`한다
- `AppDelegate.swift`의 아무 곳에다가 `kServiceAppUrlScheme`라고 쓰고 `Jump to Definition`한다(아무 곳에 쓴 것은 다시 지워주자)
- 그러면 다음과 같은 코드가 등장한다
![](https://images.velog.io/images/yc1303/post/8902e8b3-1dc2-4a82-83c9-5b20c76213d0/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202022-03-21%20%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE%207.20.41.png)
- `kServiceAppUrlScheme`에는 만들어두었던 `URL Scheme`
- `kConsumerKey`에는 NAVER Developer에 등록했을 때 받았던 `Client ID`
- `kConsumerSecret`에는 NAVER Developer에 등록했을 때 받았던 `Client Secret`
- `kServiceAppName`에는 하고 싶은 이름
---
### AppDelegate.swift 설정
- `AppDelegate.swift`에 `NaverThirdPartyLogin`를 `import`한다
- 이후는 다음 코드를 참고하자
``` swift
import UIKit
import NaverThirdPartyLogin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        // MARK: 네이버 로그인
        let instance = NaverThirdPartyLoginConnection.getSharedInstance()
        // 네이버 앱으로 인증 방식 활성화
        instance?.isNaverAppOauthEnable = true
        // SafariViewController로 인증 방식 활성화
        instance?.isInAppOauthEnable = true
         // 아이폰에서 인증 화면을 세로모드에서만 적용
        instance?.isOnlyPortraitSupportedInIphone()
        
        // 미리 만들어두었던 URL Scheme
        instance?.serviceUrlScheme = kServiceAppUrlScheme
        // 등록한 애플리케이션의 Client ID
        instance?.consumerKey = kConsumerKey
        // 등록한 애플리케이션의 Client Secret
        instance?.consumerSecret = kConsumerSecret
        // 앱 이름
        instance?.appName = kServiceAppName
        // -> 위에서 상수 설정할 때 했던거임
        
        return true
    }
    
    // MARK: 네이버 로그인
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options)
        return true
    }
}
```
---
### SceneDelegate.swift 설정
- 다음 코드를 `SceneDelegate.swift`에 작성하자
- 토근을 요청하는 코드
``` swift
// 네이버 로그인 화면이 새로 등장 -> 토큰을 요청하는 코드
func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    NaverThirdPartyLoginConnection
        .getSharedInstance()
        .receiveAccessToken(URLContexts.first?.url)
}
```
---
### 로그인, 리프레시, 로그아웃, 유저 정보 가져오기
- [유저 정보 가져오기 가이드](https://developers.naver.com/docs/login/profile/profile.md)
- 다음 코드를 확인하자
``` swift
import UIKit
import NaverThirdPartyLogin
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginInstance?.delegate = self
    }
    
    @IBAction func login(_ sender: UIButton) {
        loginInstance?.requestThirdPartyLogin()
    }
    @IBAction func logout(_ sender: UIButton) {
        loginInstance?.requestDeleteToken()
    }
    
    // MARK: 회원 프로필 조회 API
    func getInfo() {
        guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
        
        if !isValidAccessToken {
            return
        }
        
        guard let tokenType = loginInstance?.tokenType else { return }
        guard let accessToken = loginInstance?.accessToken else { return }
        
        let urlStr = "https://openapi.naver.com/v1/nid/me"
        let url = URL(string: urlStr)!
        
        let authorization = "\(tokenType) \(accessToken)"
        
        let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
        
        req.responseJSON { response in
            guard let result = response.value as? [String: Any] else { return }
            guard let object = result["response"] as? [String: Any] else { return }
            guard let name = object["name"] as? String else { return }
            guard let email = object["email"] as? String else { return }
            guard let id = object["id"] as? String else { return }
            
            print(email)
            
            self.nameLabel.text = "\(name)"
            self.emailLabel.text = "\(email)"
            self.idLabel.text = "\(id)"
        }
    }
}

// MARK: - NaverThirdPartyLoginConnectionDelegate
extension ViewController: NaverThirdPartyLoginConnectionDelegate {
    // 로그인에 성공한 경우 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("로그인 성공!!")
        getInfo()
        
    }
    
    // refresh token
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print("리프레시 토큰")
        getInfo()
    }
    
    // 로그아웃
    func oauth20ConnectionDidFinishDeleteToken() {
        print("로그아웃")
        getInfo()
    }
    
    // 모든 에러 처리
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("---ERROR: \(error.localizedDescription)---")
    }
}
```
---
### 시뮬레이터에서 실행이 안될 때
- 실행이 안될 때는 에러의 설명을 구글링해보자
- 나는 엑스코드를 업데이트하니 실기기에서는 된다
---
### 참고
- [NAVER Developer](https://developers.naver.com/main/)
- [김종권의 iOS 앱 개발 알아가기](https://ios-development.tistory.com/142)
