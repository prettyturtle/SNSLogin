//
//  ViewController.swift
//  SNSLogin
//
//  Created by yc on 2022/03/19.
//

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
