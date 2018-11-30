//
//  SettingViewController.swift
//  CoinBucket
//
//  Created by Christopher Lee on 25/11/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit
import MessageUI

public class SettingViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    private let alertController: UIAlertController = {
        let alert = UIAlertController(title: "Mail Error", message: "Unabler to send mail. Please set up a mail account and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }()

    private var viewModel: SettingViewModel!
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Configure
    private func configure() {
        configureNavigationBar()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "SettingMailCell", bundle: nil), forCellReuseIdentifier: CustomCellIdentifier.settingMailCell)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Settings"
    }
    
    // MARK: - Instantiate

    public static func instantiate() -> SettingViewController {
        let viewController = SettingViewController.instantiateFromStoryboard()
        viewController.viewModel = SettingViewModel()
        return viewController
    }
    
    private func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.delegate = self
            mail.setToRecipients(["hanernlee@gmail.com"])
            mail.setSubject("CoinBucket Query")
            mail.setMessageBody("Hello!", isHTML: false)
            
            self.present(mail, animated: true)
        } else {
            self.present(alertController, animated: true)
        }
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCellIdentifier.settingMailCell, for: indexPath) as? SettingMailCell else {
            return UITableViewCell()
        }

        return cell
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Contact"
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sendEmail()
    }
}

extension SettingViewController: MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension SettingViewController: Storyboardable {}
