//
//  Loadable.swift
//  Nizo-Viper
//
//  Created by Nizamet Özkan on 23.10.2024.
//

import UIKit

@MainActor
protocol Loadable: AnyObject {
    func showLoading()
    func hideLoading()
}

extension Loadable where Self: UIViewController {
    func showLoading() {
        self.view.isUserInteractionEnabled = false
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.center = self.view.center
        loadingIndicator.tag = 999
        self.view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
    }

    func hideLoading() {
        if let loadingIndicator = self.view.viewWithTag(999) as? UIActivityIndicatorView {
            loadingIndicator.stopAnimating()
            loadingIndicator.removeFromSuperview()
        }
        self.view.isUserInteractionEnabled = true
    }
}
