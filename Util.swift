//
//  Util.swift
//  BoxOffice
//
//  Created by 김인환 on 2021/09/29.
//

import UIKit

fileprivate var aView: UIView?

extension UIViewController {
    func showSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
        indicator.center = aView!.center
        indicator.startAnimating()
        aView?.addSubview(indicator)
        self.view.addSubview(aView!)
    }
    
    func hideSpinner() {
        aView?.removeFromSuperview()
        aView = nil
    }
}
