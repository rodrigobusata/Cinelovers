//
//  UIView.swift
//  BMovies
//
//  Created by Rodrigo Busata on 05/07/19.
//  Copyright © 2019 Busata. All rights reserved.
//

import UIKit

extension UIView {
    
    func addBorder(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func addGradient(colors: [CGColor]) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        layer.colors = colors
        self.layer.addSublayer(layer)
        
        return layer
    }
    
    func addGradientTop() -> CAGradientLayer{
        return self.addGradient(colors: [UIColor.black.withAlphaComponent(0.8).cgColor,
                                         UIColor.black.withAlphaComponent(0.5).cgColor,
                                         UIColor.clear.cgColor])
    }
    
    func addShadow(opacity: Float = 0.5) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 4
    }
}
