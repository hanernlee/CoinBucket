//
//  LoadingHUD.swift
//  CoinBucket
//
//  Created by Christopher Lee on 17/3/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

class LoadingHUD: UIVisualEffectView {
    let blurEffect = UIBlurEffect(style: .light)
    let vibrancyView: UIVisualEffectView
    
    let frameWidth: CGFloat = 300
    let frameHeight: CGFloat = 150
    
    let labelWidth: CGFloat = 200
    let labelHeight: CGFloat = 50
    
    var shapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        return shapeLayer
    }()
    
    var loadingLayer: CAShapeLayer = {
        let loadingLayer = CAShapeLayer()
        return loadingLayer
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let failLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

    init() {
        vibrancyView = UIVisualEffectView(effect: blurEffect)
        vibrancyView.alpha = 0.1

        super.init(effect: blurEffect)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))

        super.init(coder: aDecoder)

        setup()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if let superview = self.superview {
            vibrancyView.frame = self.bounds
            self.frame = CGRect(x: 0, y: 0, width: frameWidth, height: frameHeight)
            self.layer.cornerRadius = 12.0
            self.layer.masksToBounds = true
            self.center = superview.center
            
            shapeLayer.position = CGPoint(x: frameWidth / 2, y: frameHeight / 2)
            loadingLayer.position = CGPoint(x: frameWidth / 2, y: frameHeight / 2)
        }
    }
    
    func setup() {
        contentView.addSubview(vibrancyView)
        contentView.addSubview(label)
        contentView.addSubview(failLabel)
        setupCircle()
        setupNotificationObservers()
    }
    
    func setupCircle() {
        shapeLayer = createCircleShapeLayer(strokeColor: .lightGray, fillColor: .clear)
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        layer.addSublayer(shapeLayer)

        loadingLayer = createCircleShapeLayer(strokeColor: .orange , fillColor: .clear)
        loadingLayer.strokeEnd = 0.5
        layer.addSublayer(loadingLayer)
    }
    
    func show(withLabel: Bool = false, text: String = "") {
        reset {
            if (withLabel) {
                label.isHidden = false
                label.text = text
                label.frame = CGRect(x: frameWidth / 2 - labelWidth / 2, y: 12, width: labelWidth, height: labelHeight)
                
                shapeLayer.position = CGPoint(x: frameWidth / 2, y: frameHeight - labelHeight)
                loadingLayer.position = CGPoint(x: frameWidth / 2, y: frameHeight - labelHeight)
            }
            
            shapeLayer.isHidden = false
            loadingLayer.isHidden = false
            
            animateLoadingLayer()
        }
        self.isHidden = false
    }
    
    func showFail(text: String = "") {
        reset {
            failLabel.isHidden = false
            shapeLayer.isHidden = true
            loadingLayer.isHidden = true
            
            failLabel.text = text
            failLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        }
        
        self.isHidden = false
        
        
    }
    
    func hide() {
        self.isHidden = true
    }
    
    func reset(completion: () -> Void) {
        failLabel.isHidden = true
        label.isHidden = true
        shapeLayer.position = CGPoint(x: frameWidth / 2, y: frameHeight / 2)
        loadingLayer.position = CGPoint(x: frameWidth / 2, y: frameHeight / 2)
        completion()
    }
    
    // MARK: - Private Methods
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleEnterForeground), name: .UIApplicationWillEnterForeground, object: nil)
    }
    
    private func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer {
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 30, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        let layer = CAShapeLayer()
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 8
        layer.fillColor = fillColor.cgColor
        layer.lineCap = kCALineCapRound
        layer.fillMode = kCAFillModeForwards
        return layer
    }
    
    fileprivate func animateLoadingLayer() {
        let basicAnimation = CABasicAnimation(keyPath: "transform.rotation")
        basicAnimation.byValue = 2 * CGFloat.pi
        basicAnimation.duration = 0.8
        basicAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        basicAnimation.repeatCount = .infinity

        loadingLayer.add(basicAnimation, forKey: "spinAnimation")
    }
    
    // MARK: - #Selector Events
    @objc func handleEnterForeground() {
        animateLoadingLayer()
    }
}
