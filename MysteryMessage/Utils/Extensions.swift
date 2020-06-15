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
    static let optionViewBgColor = #colorLiteral(red: 0.8290143013, green: 0.8291541934, blue: 0.8289958835, alpha: 1)
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

// Comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

extension UIImage {
    
    public class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("image doesn't exist")
            return nil
        }
        
        return UIImage.animatedImageWithSource(source)
    }
    
    public class func gifImageWithURL(_ gifUrl:String) -> UIImage? {
        guard let bundleURL = URL(string: gifUrl)
            else {
                print("image named \"\(gifUrl)\" doesn't exist")
                return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("image named \"\(gifUrl)\" into NSData")
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    public class func gifImageWithName(_ name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
                print("SwiftGif: This image named \"\(name)\" does not exist")
                return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(
            CFDictionaryGetValue(cfProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()),
            to: CFDictionary.self)
        
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as! Double
        
        if delay < 0.1 {
            delay = 0.1
        }
        
        return delay
    }
    
    class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        if a < b {
            let c = a
            a = b
            b = c
        }
        
        var rest: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b!
            } else {
                a = b
                b = rest
            }
        }
    }
    
    class func gcdForArray(_ array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        
        return gcd
    }
    
    class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
            let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
                source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        let animation = UIImage.animatedImage(with: frames,
            duration: Double(duration) / 1000.0)
        
        return animation
    }
}
