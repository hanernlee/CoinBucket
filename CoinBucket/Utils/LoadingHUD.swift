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
            self.frame = CGRect(x: 0, y: 0, width: 300, height: 150)
            self.layer.cornerRadius = 12.0
            self.layer.masksToBounds = true
            self.center = superview.center
            
            shapeLayer.position = CGPoint(x: 300 / 2, y: 150 / 2)
            loadingLayer.position = CGPoint(x: 300 / 2, y: 150 / 2)
            
            animateLoadingLayer()
        }
    }
    
    func setup() {
        contentView.addSubview(vibrancyView)
        setupCircle()
        setupNotificationObservers()
    }
    
    func setupCircle() {
        shapeLayer = createCircleShapeLayer(strokeColor: .lightGray, fillColor: .clear)
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        layer.addSublayer(shapeLayer)

        loadingLayer = createCircleShapeLayer(strokeColor: .blue , fillColor: .clear)
        loadingLayer.strokeEnd = 0.5
        layer.addSublayer(loadingLayer)
    }
    
    func show(withLabel: Bool = false) {
        if (withLabel) {
            contentView.addSubview(label)
//            label.center = CGPoint(x: 300 / 2, y: 150 / 2)
            label.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            label.text = "Hellos"
            print(label )
        }
        
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
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
        basicAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        basicAnimation.repeatCount = .infinity

        loadingLayer.add(basicAnimation, forKey: "spinAnimation")
    }
    
    // MARK: - #Selector Events
    @objc func handleEnterForeground() {
        animateLoadingLayer()
    }
}
