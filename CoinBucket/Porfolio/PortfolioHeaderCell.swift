//
//  PortfolioHeaderCell.swift
//  CoinBucket
//
//  Created by Christopher Lee on 6/3/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

class PortfolioHeaderCell: UICollectionViewCell {
    var savedCoins = [Coin]() {
        didSet {
            getTotalCoin()
            configureUI()
        }
    }
    
    var pulsatingLayer: CAShapeLayer!
    
    let totalPriceLabel: CountingLabel = {
        let countingLabel = CountingLabel()
        countingLabel.textAlignment = .center
        countingLabel.numberOfLines = 0
        countingLabel.font = UIFont.boldSystemFont(ofSize: 16)
        return countingLabel
    }()

    var shapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        return shapeLayer
    }()
    
    var totalPrice: NSDecimalNumber = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupNotificationObservers()
        setupCircle()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleEnterForeground), name: .UIApplicationWillEnterForeground, object: nil)
    }
    
    private func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer {
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        let layer = CAShapeLayer()
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 20
        layer.fillColor = fillColor.cgColor
        layer.lineCap = kCALineCapRound
        layer.position = center
        return layer
    }
    
    // MARK: - Fileprivate Methods
    fileprivate func setupCircle() {
        // Create pulsating layer
        pulsatingLayer = createCircleShapeLayer(strokeColor: .clear , fillColor: .lightBlue)
        layer.addSublayer(pulsatingLayer)

        animatePulsatingLayer()

        // Create track layer
        let trackLayer = createCircleShapeLayer(strokeColor: .lightGray , fillColor: .orange)
        layer.addSublayer(trackLayer)
        
        // Create shape layer
        shapeLayer = createCircleShapeLayer(strokeColor: .blue, fillColor: .clear)
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayer.strokeEnd = 0
        
        layer.addSublayer(shapeLayer)
    }

    fileprivate func getTotalCoin() {
        for coin in savedCoins {
            let quantity = NSDecimalNumber(string: coin.quantity)
            let decPrice = NSDecimalNumber(string: coin.price)
            let price = NSDecimalNumber(string: decPrice.toDecimals())
            let totalPriceNSDecimal = ((quantity as Decimal) * (price as Decimal)) as NSDecimalNumber
            
            totalPrice = ((totalPrice as Decimal) + (totalPriceNSDecimal as Decimal)) as NSDecimalNumber
        }
        animateShapeLayer()
        animatePulsatingLayer()
    }
    
    fileprivate func configureUI() {
        configureTotalPrice()
    }
    
    fileprivate func configureTotalPrice() {
        let totalPriceFloat = Float(truncating: totalPrice)
        
        addSubview(totalPriceLabel)
        totalPriceLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 100)
        totalPriceLabel.center = center
        totalPriceLabel.count(fromValue: 0, to: totalPriceFloat, withDuration: 2, andAnimationType: .EaseOut, andCounterType: .Float)
    }
    
    fileprivate func animateShapeLayer() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
    
    fileprivate func animatePulsatingLayer() {
        let basicAnimation = CABasicAnimation(keyPath: "transform.scale")
        basicAnimation.toValue = 1.3
        basicAnimation.duration = 0.8
        basicAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        basicAnimation.autoreverses = true
        basicAnimation.repeatCount = .infinity

        pulsatingLayer.add(basicAnimation, forKey: "pulsatingLayer")
    }
    
    // MARK: - #Selector Events
    @objc func handleEnterForeground() {
        animatePulsatingLayer()
    }
}

