//
//  ProgressHUD.swift
//  Coinster
//
//  Created by Christopher Lee on 17/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class ProgressHUD: UIVisualEffectView {
    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    let activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .white)
    let label: UILabel = UILabel()
    let blurEffect = UIBlurEffect(style: .dark)
    let vibrancyView: UIVisualEffectView
    
    init(text: String) {
        self.text = text
        vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(effect: blurEffect)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        text = ""
        vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        contentView.addSubview(vibrancyView)
        contentView.addSubview(activityIndictor)
        contentView.addSubview(label)
        activityIndictor.startAnimating()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if let superview = self.superview {
            
            let width = superview.frame.size.width / 2.0
            let height: CGFloat = 50.0
            self.frame = CGRect(
                x: superview.frame.size.width / 2 - width / 2,
                y: superview.frame.height / 3 - height / 2,
                width: width,
                height: height
            )
            vibrancyView.frame = self.bounds
            
            let activityIndicatorSize: CGFloat = 40
            activityIndictor.frame = CGRect(
                x: 5,
                y: height / 2 - activityIndicatorSize / 2,
                width: activityIndicatorSize,
                height: activityIndicatorSize
            )
            
            layer.cornerRadius = 8.0
            layer.masksToBounds = true
            label.numberOfLines = 0
            label.text = text
            label.textAlignment = NSTextAlignment.center
            label.frame = CGRect(
                x: activityIndicatorSize,
                y: 0,
                width: width - activityIndicatorSize - 30,
                height: height
            )
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 14)
        }
    }
    
    func show() {
        self.activityIndictor.isHidden = false
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
    
    func showWithoutSpinner() {
        self.activityIndictor.isHidden = true
        self.isHidden = false
    }
}
