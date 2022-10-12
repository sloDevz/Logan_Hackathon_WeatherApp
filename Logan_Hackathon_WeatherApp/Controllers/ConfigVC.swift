//
//  ConfigVC.swift
//  Logan_Hackathon_WeatherApp
//
//  Created by DONGWOOK SEO on 2022/10/10.
//

import UIKit
import MessageUI

class ConfigVC: UIViewController {
    
    @IBOutlet weak var myLocationToggle: UIButton!
    
    let weatherDataManager = DataManager()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        
        let searchBar = UISearchBar()
        searchBar.placeholder = "지역 찾기"
        self.navigationItem.titleView = searchBar
        myLocationToggle.setTitle("", for: .normal)
        let isOn = weatherDataManager.isMyLocationOn()
        if  isOn {
            myLocationToggle.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }else {
            myLocationToggle.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        }
        
    }
    
    @IBAction func privacyPolicyButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func aboutDeveloperButtonTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "📌", message: "개발자 정보\n\n이름: Logan (서동욱) \nE-mail: onec555@gmail.com", preferredStyle: .alert)

        let sucess = UIAlertAction(title: "확인", style: .default) { action in
        print("확인버튼 눌렸습니다.")
        }

        alert.addAction(sucess)

        present(alert, animated: true)
    }
    
    
    func popAlertSomeSec(title: String, message: String, interval: Double){

                    // 이 메세지 부분에 내가 원하는 문구를 넣으면 된다.
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

            // 만약 이 코드를 실행시키는 곳이 ViewController가 아니라면 임의로 뷰 컨트롤러를 설정해서 present하자.
            self.present(alert, animated: true, completion: nil)

                    // TimeInterval 값을 조정해서 얼마나 떠 있게 할 지 조정하면 된다.
            Timer.scheduledTimer(withTimeInterval: interval, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
        }
    

}


extension ConfigVC: MFMailComposeViewControllerDelegate {

    
    @IBAction func askInfoButtonTapped(sender: UIButton) {
        print(#function)
  // 1
        guard MFMailComposeViewController.canSendMail() else {
            popAlertSomeSec(title: "오 류", message: "이메일이 등록되지 않았습니다 이메일을 등록후 이용해주세요.", interval: 2)
            return
        }
        
  // 2
        let emailTitle = "날씨앱 문의" // 메일 제목
        let messageBody =
        """
        OS Version: \(UIDevice.current.systemVersion)
        Device: (디바이스 알아내는 기능)
        메일 내용 템플릿
        """
        
  // 3
        let toRecipents = ["onec555@gmail.com"]
        let mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setSubject(emailTitle)
        mc.setMessageBody(messageBody, isHTML: false)
        mc.setToRecipients(toRecipents)
        
        self.present(mc, animated: true, completion: nil)
    }
    
    // 4
    @objc(mailComposeController:didFinishWithResult:error:)
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult,error: Error?) {
            controller.dismiss(animated: true)
    }
}


