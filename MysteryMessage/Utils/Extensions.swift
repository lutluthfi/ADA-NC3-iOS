//
//  Extensions.swift
//  MysteryMessage
//
//  Created by Muhammad Nobel Shidqi on 11/06/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

extension UIColor {
    static let receiverBoxColor = #colorLiteral(red: 0.6350682378, green: 0.6351773739, blue: 0.6350538731, alpha: 1)
    static let senderBoxColor = #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
    static let bgColor = #colorLiteral(red: 0.119528152, green: 0.1204516068, blue: 0.1263914108, alpha: 1)
}

extension UIViewController {
    func hideNavbar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func makeNavbarTransparent() {
        let navbar = self.navigationController?.navigationBar
        navbar?.backgroundColor = .clear
        navbar?.setBackgroundImage(UIImage(), for: .default)
        navbar?.shadowImage = UIImage()
    }
    
    func heightForLabel(withText text:String) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 140, height: CGFloat.zero))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "Helvetica", size: 16)
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}

extension UIView {
    enum CornerType {
        case topLeft,topRight,bottomLeft,bottomRight,all
    }
    
    func configureRoundedCorners(for corners: [CornerType], withRadius radius: CGFloat) {
        var selectedCorners = [CACornerMask]()
        corners.forEach { (corner) in
            switch corner {
                case .bottomLeft:
                    selectedCorners.append(.layerMinXMaxYCorner)
                case .bottomRight:
                    selectedCorners.append(.layerMaxXMaxYCorner)
                case .topLeft:
                    selectedCorners.append(.layerMinXMinYCorner)
                case .topRight:
                    selectedCorners.append(.layerMaxXMinYCorner)
                case .all:
                    selectedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner]
            }
        }
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = CACornerMask(selectedCorners)
    }
    
    func setAnchor(top: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat = 0, paddingRight: CGFloat = 0, paddingBottom: CGFloat = 0, paddingLeft:CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
    }
    
    func setSize(width: CGFloat? = nil, height: CGFloat? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func setCenterXAnchor(in view: UIView, constant: CGFloat? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let constant = constant {
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
        } else {
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
    }
    
    func setCenterYAnchor(in view: UIView, constant: CGFloat? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let constant = constant {
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        } else {
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
    }
    
    func setCenterXYAnchor(in view: UIView) {
        setCenterXAnchor(in: view)
        setCenterYAnchor(in: view)
    }
}
