//
//  LoadingIndicator.swift
//  CoinBucket
//
//  Created by Christopher Lee on 30/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

class LoadingIndicator: UIView {
    
    // MARK: - Private Properties

    private var circleShapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    
    private var loadingShapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    
    public var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .groupTableViewBackground
        containerView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
        return containerView
    }()
    
    
    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure

    private func configure() {
        configureCircleShapeLayer()
        configureLoadingShapeLayer()
        animateLoadingLayer()
        self.addSubview(containerView)
    }
    
    private func configureCircleShapeLayer() {
        circleShapeLayer = createCircleShapeLayer(strokeColor: .gray, fillColor: .clear)
        circleShapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        circleShapeLayer.position = containerView.center
        containerView.layer.addSublayer(circleShapeLayer)
    }
    
    private func configureLoadingShapeLayer() {
        loadingShapeLayer = createCircleShapeLayer(strokeColor: .orange , fillColor: .clear)
        loadingShapeLayer.strokeEnd = 0.5
        loadingShapeLayer.position = containerView.center
        containerView.layer.addSublayer(loadingShapeLayer)
    }
    
    // MARK: - Helper methods

    private func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer {
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 30, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        let layer = CAShapeLayer()
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 8
        layer.fillColor = fillColor.cgColor
        layer.lineCap = CAShapeLayerLineCap.round
        layer.fillMode = CAMediaTimingFillMode.forwards
        return layer
    }
    
    // MARK: - Animate loading layer

    public func animateLoadingLayer() {
        let basicAnimation = CABasicAnimation(keyPath: "transform.rotation")
        basicAnimation.byValue = 2 * CGFloat.pi
        basicAnimation.duration = 0.8
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        basicAnimation.repeatCount = .infinity
        loadingShapeLayer.add(basicAnimation, forKey: "spinAnimation")
    }
}
