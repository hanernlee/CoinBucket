//
//  ProgressHUD.swift
//  CoinBucket
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
    
    let label: UILabel = UILabel()
    let labelView: UIView = UIView()
    let blurEffect = UIBlurEffect(style: .prominent)
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
        contentView.addSubview(labelView)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if let superview = self.superview {
            
            let width = superview.bounds.width / 2
            let height: CGFloat = 50.0
            self.frame = CGRect(
                x: 0,
                y: 0,
                width: superview.bounds.width,
                height: superview.bounds.height
            )
            vibrancyView.frame = self.bounds

            layer.cornerRadius = 8.0
            layer.masksToBounds = true
            
            labelView.frame = CGRect(
                x: superview.frame.width / 2 - width / 2,
                y: superview.frame.height / 2,
                width: width,
                height: height
            )
            labelView.backgroundColor = .gray
            UIView.animate(withDuration: 1.0, delay: 0.0, options:[UIViewAnimationOptions.repeat, UIViewAnimationOptions.autoreverse], animations: {
                self.labelView.backgroundColor = UIColor.gray
                self.labelView.backgroundColor = UIColor.black
                self.labelView.backgroundColor = UIColor.gray
            }, completion: nil)
            
            labelView.layer.cornerRadius = 12.0
            labelView.layer.masksToBounds = true
            labelView.addSubview(label)
            
            label.numberOfLines = 0
            label.text = text
            label.textAlignment = NSTextAlignment.center
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 14)
            label.frame = CGRect(
                x: labelView.frame.width / 2 - width / 2,
                y: 0,
                width: width,
                height: height
            )
        }
    }
    
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
}
