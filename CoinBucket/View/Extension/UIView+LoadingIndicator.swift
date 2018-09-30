//
//  UIView+LoadingIndicator.swift
//  CoinBucket
//
//  Created by Christopher Lee on 30/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

private var _loadingIndicatorAssociationKey = 0

extension UIView {
    private var _loadingIndicatorView: LoadingIndicator? {
        get {
            return objc_getAssociatedObject(self, &_loadingIndicatorAssociationKey) as? LoadingIndicator
        }
        set {
            objc_setAssociatedObject(self, &_loadingIndicatorAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func showLoadingIndicator() {
        configureLoadingIndicator()
    }
    
    public func hideLoadingIndicator() {
        _loadingIndicatorView?.removeFromSuperview()
        _loadingIndicatorView = nil
    }
    
    private func configureLoadingIndicator() {
        let loadingIndicator = LoadingIndicator()

        self._loadingIndicatorView = loadingIndicator
        self.addSubview(loadingIndicator)
        
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loadingIndicator.topAnchor.constraint(equalTo: self.topAnchor),
            loadingIndicator.leftAnchor.constraint(equalTo: self.leftAnchor),
            loadingIndicator.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            loadingIndicator.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
        
        loadingIndicator.containerView.center = self.centerPoint()
    }
}
