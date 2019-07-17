//
//  Extensions.swift
//  potterly
//
//  Created by Alexandra Spirtes on 6/6/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import UIKit
import CoreData

//custom color definitions
extension UIColor {
    struct customColors {
        static let lilac = UIColor(red:0.82, green:0.81, blue:0.87, alpha:1.0)
        static let midnight = UIColor(red:0.13, green:0.10, blue:0.25, alpha:1.0)
        static let mauve = UIColor(red:0.44, green:0.37, blue:0.51, alpha:1.0)
        static let lighty = UIColor(red:0.95, green:0.95, blue:0.97, alpha:1.0)
        static let appleBlue = UIColor(red:0.0, green:0.47, blue:1.0, alpha:1.0)
        static let appleHighlight = UIColor(red:0.0, green:0.47, blue:1.0, alpha:0.4)
        
    }
}

extension String {
    func date(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        let date = dateFormatter.date(from: self)
        return date
    }
    
    func attrBoldString(color: UIColor) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self, attributes:
            [NSAttributedString.Key.font:UIFont(name: "Karla-Bold", size: 18.0)!,
             NSAttributedString.Key.kern: CGFloat(0.7),
             NSAttributedString.Key.foregroundColor: color
            ])
    }
    
    func attrString(color: UIColor) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self, attributes:
            [NSAttributedString.Key.font:UIFont(name: "Karla-Regular", size: 18.0)!,
             NSAttributedString.Key.kern: CGFloat(0.7),
             NSAttributedString.Key.foregroundColor: color
            ])
    }
    
    func attrSmallString(color: UIColor, bold: Bool) -> NSMutableAttributedString {
        let font: String
        if bold == true {
            font = "Karla-Bold"
        }
        else {
            font = "Karla-Regular"
        }
        return NSMutableAttributedString(string: self, attributes:
            [NSAttributedString.Key.font:UIFont(name: font, size: 16.0)!,
             NSAttributedString.Key.kern: CGFloat(0.3),
             NSAttributedString.Key.foregroundColor: color
            ])
    }
}

//extensions of UIImage in order to get plus button logo with custom button action
extension UIImage {
    
    public convenience init?(systemItem sysItem: UIBarButtonItem.SystemItem, renderingMode:UIImage.RenderingMode = .automatic) {
        guard let sysImage = UIImage.imageFromSystemItem(sysItem, renderingMode: renderingMode)?.cgImage else {
            return nil
        }
        
        self.init(cgImage: sysImage)
    }
    
    public class func imageFromSystemItem(_ systemItem: UIBarButtonItem.SystemItem, renderingMode:UIImage.RenderingMode = .automatic) -> UIImage? {
        
        let tempItem = UIBarButtonItem(barButtonSystemItem: systemItem, target: nil, action: nil)
        
        // add to toolbar and render it
        let bar = UIToolbar()
        bar.setItems([tempItem], animated: false)
        bar.snapshotView(afterScreenUpdates: true)
        
        // got image from real uibutton
        let itemView = tempItem.value(forKey: "view") as! UIView
        
        for view in itemView.subviews {
            if view is UIButton {
                let button = view as! UIButton
                let image = button.imageView!.image!
                image.withRenderingMode(renderingMode)
                return image
            }
        }
        
        return nil
    }
    
    func imageToData() -> Data? {
        return self.jpegData(compressionQuality: 1.0) ?? nil
    }
}

//extension of Date class to create seconds
extension Date {
        static func - (lhs: Date, rhs: Date) -> TimeInterval {
            return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
        }
    }


//takes status and returns as enum for realm entry
extension Status {
    func getEnum() -> Int {
        if self == Status.trim {
            return 0
        }
        else if self == Status.dry {
            return 1
        }
        else if self == Status.bisqued {
            return 2
        }
        else if self == Status.glazed {
            return 3
        }
        else {
            return 4
        }
    }
}


//trying to resize
extension UIImage {
    class func resize(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    class func scale(image: UIImage, by scale: CGFloat) -> UIImage? {
        let size = image.size
        let scaledSize = CGSize(width: size.width * scale, height: size.height * scale)
        return UIImage.resize(image: image, targetSize: scaledSize)
    }
    
}

extension Date {
    func removeTimeStamp() -> Date {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
            fatalError("Failed to strip time from Date object")
        }
        return date
    }
}
