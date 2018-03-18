//
//  CountingLabel.swift
//  CoinBucket
//
//  Created by Christopher Lee on 17/3/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

class CountingLabel: UILabel {
    
    let counterVelocity: Float = 3.0
    
    enum CounterAnimationType {
        case Linear // f(x) = x
        case EaseIn // f(x) = x^3
        case EaseOut // f(x) = (1-x)^3
    }
    
    enum CounterType {
        case Int
        case Float
    }
    
    var startNumber: Float = 0.0
    var endNumber: Float = 0.0
    
    var stateController: StateController!    
    var progress: TimeInterval!
    var duration: TimeInterval!
    var lastUpdate: TimeInterval!
    
    var timer: Timer?
    
    var counterType: CounterType!
    var counterAnimationType: CounterAnimationType!
    
    var currentCounterValue: Float {
        if progress >= duration {
            return endNumber
        }
        
        let percentage = Float(progress/duration)
        let update = updateCounter(counterValue: percentage)
        
        let value = startNumber + (update * (endNumber - startNumber))
        
        return value
    }
    
    func count(fromValue: Float, to toValue: Float, withDuration duration: TimeInterval, andAnimationType animationType: CounterAnimationType, andCounterType counterType: CounterType) {
        
        self.startNumber = fromValue
        self.endNumber = toValue
        self.duration = duration
        self.counterType = counterType
        self.counterAnimationType = animationType
        self.progress = 0
        self.lastUpdate = Date.timeIntervalSinceReferenceDate
        
        invalidateTimer()
        
        if duration == 0 {
            updateText(value: toValue)
            return
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(CountingLabel.updateValue), userInfo: nil, repeats: true)
    }
    
    @objc func updateValue() {
        let now = Date.timeIntervalSinceReferenceDate
        progress = progress + (now - lastUpdate)
        lastUpdate = now
        
        if progress >= duration {
            invalidateTimer()
            progress = duration
        }
        
        updateText(value: currentCounterValue)
    }
    
    func updateText(value: Float) {
        switch counterType! {
        case .Int:
            self.text = "\(Int(value))"
        case .Float:
            let attributedText = NSMutableAttributedString(string: "Total", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.black])
            attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 4)]))
            attributedText.append(NSAttributedString(string: "\(value.formatCurrency(localeIdentifier: "en_US"))", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedStringKey.foregroundColor: UIColor.black]))
            self.attributedText = attributedText
        }
    }
    
    func updateCounter(counterValue: Float) -> Float {
        switch counterAnimationType! {
        case .Linear:
            return counterValue
        case .EaseIn:
            return powf(counterValue, counterVelocity)
        case .EaseOut:
            return 1.0 - powf(1.0 - counterValue, counterVelocity)
        }
    }
    
    func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
}
