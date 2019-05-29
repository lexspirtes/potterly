//
//  RootViewModel.swift
//  potterly
//
//  Created by Lex Spirtes on 5/29/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import Foundation
import RxSwift

class RootViewModel {
    
}

public class SimpleLine: UIView  {
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        backgroundColor = .white
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setLineWidth(4.0)
        context.setStrokeColor(UIColor.darkGray.cgColor)
        context.move(to: CGPoint(x: 40, y: 40))
        context.addLine(to: CGPoint(x: 280, y: 300))
        context.strokePath()
    }
}

extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
        case .bottom:
            border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
        case .right:
            border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        addSublayer(border)
    }
}

extension UIButton {
    
    func centerVertically(padding: CGFloat = 6.0) {
        guard
            let imageViewSize = self.imageView?.frame.size,
            let titleLabelSize = self.titleLabel?.frame.size else {
                return
        }
        
        let totalHeight = imageViewSize.height + titleLabelSize.height + padding
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageViewSize.height),
            left: 0.0,
            bottom: 0.0,
            right: -titleLabelSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: -imageViewSize.width,
            bottom: -(totalHeight - titleLabelSize.height),
            right: 0.0
        )
        
        self.contentEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: titleLabelSize.height,
            right: 0.0
        )
    }
    
    func addTextSpacing(spacing: CGFloat){
        let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text!)!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: attributedString.length - 1))
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
}

extension UILabel {
    /// Applies letter spacing
    func addTextSpacing(spacing: CGFloat) {
        let attributedString = NSMutableAttributedString(string: (self.text)!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: attributedString.length - 1))
        self.attributedText = attributedString
        }
    
    func formatLabel(text: String, spacing: CGFloat = 0.7, font: String = "Karla-Regular", fontSize: CGFloat = 12, textColor: UIColor = .white) {
        self.text = text
        self.font = UIFont(name: font, size: fontSize)
        self.textColor = textColor
        self.addTextSpacing(spacing: spacing)
    }
}

struct colors {
    var lightPurple = UIColor(red:0.82, green:0.81, blue:0.87, alpha:1.0)
    var darkBlue = UIColor(red:0.13, green:0.10, blue:0.25, alpha:1.0)
}
