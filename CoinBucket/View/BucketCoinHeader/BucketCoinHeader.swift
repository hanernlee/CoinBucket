//
//  BucketCoinHeader.swift
//  CoinBucket
//
//  Created by Christopher Lee on 23/11/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

public class BucketCoinHeader: UICollectionViewCell {
    
    // MARK: - Properties
    private var pulsatingLayer: CAShapeLayer!
    private var displayLink: CADisplayLink?
    private var viewModel: BucketCoinHeaderViewModel!

    private var animationStartDate = Date()
    private let animationDuration: Float = 1.5
    private var elapsedTime: Float = 0
    
    private var shapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        return shapeLayer
    }()
    
    private var countLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private var startValue: Float = 0
    public var endValue: Float = 0
    
    public override func prepareForReuse() {
        super.prepareForReuse()

        configure()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        configureCircle()
        configureCountLabel()

        startDisplayLink()
        animateShapeLayer()
        animatePulsatingLayer()
    }
    
    func configure(with viewModel: BucketCoinHeaderViewModel) {
        self.viewModel = viewModel

        self.endValue = viewModel.count
    }
    
    public func startDisplayLink() {
        stopDisplayLink()
        
        animationStartDate = Date()
        
        let link = CADisplayLink(target: self, selector: #selector(handleDisplayLink(displayLink:)))
        link.add(to: .main, forMode: .common)
        displayLink = link
    }
    
    public func stopDisplayLink() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    @objc private func handleDisplayLink(displayLink: CADisplayLink) {
        let now = Date()
        elapsedTime = Float(now.timeIntervalSince(animationStartDate))
        
        guard elapsedTime < animationDuration else {
            return self.countLabel.text = viewModel.configureTotalString(with: endValue)
        }
        
        let percentage = Float(elapsedTime) / animationDuration
        let value = startValue + Float(percentage) * (endValue - startValue)
        self.countLabel.text = viewModel.configureTotalString(with: value)
    }
    
    public func configureCircle() {
        // Create pulsating layer
        pulsatingLayer = createCircleShapeLayer(strokeColor: .clear , fillColor: .lightOrangey)
        layer.addSublayer(pulsatingLayer)
        
        animatePulsatingLayer()
        
        // Create track layer
        let trackLayer = createCircleShapeLayer(strokeColor: .lightGray , fillColor: .white)
        layer.addSublayer(trackLayer)
        
        // Create shape layer
        shapeLayer = createCircleShapeLayer(strokeColor: .orangey, fillColor: .clear)
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayer.strokeEnd = 0
        
        layer.addSublayer(shapeLayer)
    }
    
    public func configureCountLabel() {
        addSubview(countLabel)
        countLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 100)
        countLabel.center = center
    }
    
    private func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer {
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        let layer = CAShapeLayer()
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 20
        layer.fillColor = fillColor.cgColor
        layer.lineCap = CAShapeLayerLineCap.round
        layer.position = center
        return layer
    }
    
    fileprivate func animateShapeLayer() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 1.5
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
    
    fileprivate func animatePulsatingLayer() {
        let basicAnimation = CABasicAnimation(keyPath: "transform.scale")
        basicAnimation.toValue = 1.3
        basicAnimation.duration = 1
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        basicAnimation.autoreverses = true
        basicAnimation.isRemovedOnCompletion = true
        
        pulsatingLayer.add(basicAnimation, forKey: "pulsatingLayer")
    }
}
