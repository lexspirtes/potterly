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
}

//extension of Date class to create seconds
extension Date {
    func toSeconds() -> Int64 {
        return Int64((self.timeIntervalSince1970).rounded())
    }
    init(seconds:Int64!){
        self = Date(timeIntervalSince1970: TimeInterval(Double.init(seconds)))
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
}
