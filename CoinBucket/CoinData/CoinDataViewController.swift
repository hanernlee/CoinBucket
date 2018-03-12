//
//  CoinDataViewController.swift
//  CoinBucket
//
//  Created by Christopher Lee on 11/3/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

class CoinDataViewController: UIViewController {
    
    var model: CoinViewModel?
    var stateController: StateController?

    let imageSize: CGFloat = 32

    let topView: UIView = {
        let view = UIView()
        return view
    }()
    
    let priceView: UIView = {
        let view = UIView()
        return view
    }()
    
    let coinImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 30/2
        iv.clipsToBounds = true
        return iv
    }()
    
    let coinTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let percentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let marketCapLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let volumeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let supplyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    let coinDataContainer: UIView = {
        let coinDataContainer = UIView()
        coinDataContainer.backgroundColor = .white
        
        coinDataContainer.layer.cornerRadius = 12.0
        coinDataContainer.layer.borderWidth = 1.0
        coinDataContainer.layer.borderColor = UIColor.clear.cgColor
        coinDataContainer.layer.masksToBounds = true

        coinDataContainer.layer.shadowColor = UIColor.lightGray.cgColor
        coinDataContainer.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        coinDataContainer.layer.shadowRadius = 2.0
        coinDataContainer.layer.shadowOpacity = 1.0
        coinDataContainer.layer.masksToBounds = false
        coinDataContainer.layer.cornerRadius = 12.0

        return coinDataContainer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupCoin()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        coinImageView.frame = CGRect(x: 0, y: topView.frame.height / 2 - imageSize / 2, width: imageSize, height: imageSize)
    }

    // MARK: - Fileprivate Methods
    fileprivate func configureUI() {
        view.backgroundColor = .groupTableViewBackground
        navigationItem.title = "Coin Data"
        
        view.addSubview(coinDataContainer)
        coinDataContainer.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 12, paddingRight: 12, width: 0, height: 0)
        
        coinDataContainer.addSubview(topView)
        topView.anchor(top: coinDataContainer.topAnchor, left: coinDataContainer.leftAnchor, bottom: nil, right: coinDataContainer.rightAnchor, paddingTop: 24, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: coinDataContainer.frame.width, height: 50)
        
        topView.addSubview(coinImageView)
        coinImageView.anchor(top: topView.topAnchor, left: topView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: imageSize, height: imageSize)

        topView.addSubview(coinTitle)
        coinTitle.anchor(top: topView.topAnchor, left: coinImageView.rightAnchor, bottom: topView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        coinDataContainer.addSubview(priceView)
        priceView.anchor(top: topView.bottomAnchor, left: coinDataContainer.leftAnchor, bottom: nil, right: coinDataContainer.rightAnchor, paddingTop: 24, paddingLeft: 24, paddingBottom: 24, paddingRight: 24, width: 0, height: 0)
        
        priceView.addSubview(priceLabel)
        priceLabel.anchor(top: priceView.topAnchor, left: priceView.leftAnchor, bottom: priceView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        priceView.addSubview(percentLabel)
        percentLabel.anchor(top: priceView.topAnchor, left: nil, bottom: priceView.bottomAnchor, right: priceView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        coinDataContainer.addSubview(marketCapLabel)
        marketCapLabel.anchor(top: priceView.bottomAnchor, left: coinDataContainer.leftAnchor, bottom: nil, right: coinDataContainer.rightAnchor, paddingTop: 24, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: 0, height: 0)
        
        coinDataContainer.addSubview(volumeLabel)
        volumeLabel.anchor(top: marketCapLabel.bottomAnchor, left: coinDataContainer.leftAnchor, bottom: nil, right: coinDataContainer.rightAnchor, paddingTop: 24, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: 0, height: 0)
        
        coinDataContainer.addSubview(supplyLabel)
        supplyLabel.anchor(top: volumeLabel.bottomAnchor, left: coinDataContainer.leftAnchor, bottom: nil, right: coinDataContainer.rightAnchor, paddingTop: 24, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: 0, height: 0)


    }
    
    fileprivate func setupCoin() {
        var percentChangeColor: UIColor

        guard let currency = stateController?.currency else { return }
        
        guard let model = model else { return }
        print(model)
        coinImageView.loadImageUsingCacheWithURLString(model.imageUrl, placeHolder: nil) { (bool) in
            //@TODO handle success
        }
        
        let attributedText = NSMutableAttributedString(string: model.name, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 30)])
        attributedText.append(NSAttributedString(string: " (\(model.symbol))", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        coinTitle.attributedText = attributedText
        
        priceLabel.attributedText = setupAttributedText(firstString: "Price", secondString: "\(currency.name) \(model.price.formatCurrency(localeIdentifier: "en_US"))", color: .gray)
        
        if model.percentChange24h > 0 {
            percentChangeColor = .green
        } else {
            percentChangeColor = .red
        }
        percentLabel.attributedText = setupAttributedText(firstString: "%", secondString: "\(model.percentChange24h)%", color: percentChangeColor)
        
        marketCapLabel.attributedText = setupAttributedText(firstString: "Market Cap", secondString: "\(currency.name) \(model.marketCap.formatCurrency(localeIdentifier: "en_US"))", color: .gray)
        
        volumeLabel.attributedText = setupAttributedText(firstString: "Volume (24h)", secondString: "\(currency.name) \(model.volume.formatCurrency(localeIdentifier: "en_US"))", color: .gray)

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let formattedNumber = numberFormatter.string(from: model.availableSupply)
        supplyLabel.attributedText = setupAttributedText(firstString: "Circulating Supply", secondString: "\(String(describing: formattedNumber!)) \(model.symbol)", color: .gray)
    }
    
    fileprivate func setupAttributedText(firstString: String, secondString: String, color: UIColor) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: firstString, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 24)])
        attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 4)]))
        attributedText.append(NSAttributedString(string: secondString, attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]))
        return attributedText
    }
}
