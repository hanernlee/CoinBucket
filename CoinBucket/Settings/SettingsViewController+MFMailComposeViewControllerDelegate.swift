//
//  SettingsViewController+MFMailComposeViewControllerDelegate.swift
//  CoinBucket
//
//  Created by Christopher Lee on 23/3/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit
import MessageUI

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["hanernlee@gmail.com"])
            mail.setSubject("CoinBucket Query")
            mail.setMessageBody("Hello!", isHTML: false)
            
            present(mail, animated: true)
        } else {
            present(alertController, animated: true)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
