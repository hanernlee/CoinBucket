//
//  TallyView.swift
//  CoinBucket
//
//  Created by Christopher Lee on 18/11/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

class TallyView: UIView {
    
    // MARK: - IBOutlets

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var minusCountButton: UIButton!
    @IBOutlet weak var plusCountButton: UIButton!
    @IBOutlet weak var countTextField: UITextField!
    @IBOutlet weak var saveToBucketButton: UIButton!
    @IBOutlet weak var tallyViewBottomConstraint: NSLayoutConstraint!
    
    public var didSaveToBucket: (() -> Void)?
    
    // MARK: - Properties
    
    private var viewModel: TallyViewViewModel!

    // MARK: - Instantiate
    static func instantiate(with viewModel: TallyViewViewModel) -> TallyView? {
        guard let tallyView = Bundle.main.loadNibNamed("TallyView", owner: self, options: nil)?.first as? TallyView else {
            return nil
        }
        tallyView.viewModel = viewModel
        tallyView.configure()
        return tallyView
    }

    // MARK: - Configure
    private func configure() {
        configureButtons()
        configureDescription()
        configureCountLabel()
        configureTextField()
    }
    
    private func configureDescription() {
        descriptionLabel.text = "Your Bucket currently contains \(viewModel.initialCount) \(viewModel.coinName)"
    }
    
    private func configureCountLabel() {
        countTextField.text = "\(viewModel.initialCount)"
    }
    
    private func configureButtons() {
        minusCountButton.layer.cornerRadius = minusCountButton.frame.width / 2
        plusCountButton.layer.cornerRadius = plusCountButton.frame.width / 2
        saveToBucketButton.layer.cornerRadius = 6
        saveToBucketButton.clipsToBounds = true
    }
    
    private func configureTextField() {
        countTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text ?? "0"
        let newCountValue = (text as NSString).floatValue
        viewModel.initialCount = newCountValue
    }
    
    public func reconfigureCount() {
        viewModel.resetCount()
        configureCountLabel()
    }
    
    // MARK: - IBActions
    
    @IBAction func didTapMinusCountButton(_ sender: Any) {
        viewModel.decreaseCount()
        configureCountLabel()
    }
    
    @IBAction func didTapPlusCountButton(_ sender: Any) {
        viewModel.increaseCount()
        configureCountLabel()
    }

    @IBAction func didSaveToBucket(_ sender: Any) {
        viewModel.saveCount()
        configureDescription()
        didSaveToBucket?()
    }
}
