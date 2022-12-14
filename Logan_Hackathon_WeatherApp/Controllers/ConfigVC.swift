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
    
    let dataManager = DataManager()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        
        myLocationToggle.setTitle("", for: .normal)
        let isOn = dataManager.isMyLocationOn()
        if  isOn {
            myLocationToggle.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }else {
            myLocationToggle.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        }
        
    }
    
    @IBAction func privacyPolicyButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func aboutDeveloperButtonTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "๐", message: "๊ฐ๋ฐ์ ์ ๋ณด\n\n์ด๋ฆ: Logan (์๋์ฑ) \nE-mail: onec555@gmail.com", preferredStyle: .alert)

        let sucess = UIAlertAction(title: "ํ์ธ", style: .default)

        alert.addAction(sucess)

        present(alert, animated: true)
    }
    
    
    func popAlertSomeSec(title: String, message: String, interval: Double){

                    // ์ด ๋ฉ์ธ์ง ๋ถ๋ถ์ ๋ด๊ฐ ์ํ๋ ๋ฌธ๊ตฌ๋ฅผ ๋ฃ์ผ๋ฉด ๋๋ค.
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

            // ๋ง์ฝ ์ด ์ฝ๋๋ฅผ ์คํ์ํค๋ ๊ณณ์ด ViewController๊ฐ ์๋๋ผ๋ฉด ์์๋ก ๋ทฐ ์ปจํธ๋กค๋ฌ๋ฅผ ์ค์ ํด์ presentํ์.
            self.present(alert, animated: true, completion: nil)

                    // TimeInterval ๊ฐ์ ์กฐ์ ํด์ ์ผ๋ง๋ ๋  ์๊ฒ ํ  ์ง ์กฐ์ ํ๋ฉด ๋๋ค.
            Timer.scheduledTimer(withTimeInterval: interval, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
        }
    

}


extension ConfigVC: MFMailComposeViewControllerDelegate {

    
    @IBAction func askInfoButtonTapped(sender: UIButton) {
        print(#function)
  // 1
        guard MFMailComposeViewController.canSendMail() else {
            popAlertSomeSec(title: "์ค ๋ฅ", message: "์ด๋ฉ์ผ์ด ๋ฑ๋ก๋์ง ์์์ต๋๋ค ์ด๋ฉ์ผ์ ๋ฑ๋กํ ์ด์ฉํด์ฃผ์ธ์.", interval: 2)
            return
        }
        
  // 2
        let emailTitle = "๋ ์จ์ฑ ๋ฌธ์" // ๋ฉ์ผ ์ ๋ชฉ
        let messageBody =
        """
        OS Version: \(UIDevice.current.systemVersion)
        Device: (๋๋ฐ์ด์ค ์์๋ด๋ ๊ธฐ๋ฅ)
        ๋ฉ์ผ ๋ด์ฉ ํํ๋ฆฟ
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


