//
//  GradientView.swift
//  BMovies
//
//  Created by Rodrigo Busata on 05/08/19.
//  Copyright © 2019 Busata. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    var gradientLayer: CAGradientLayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.gradientLayer?.frame = self.layer.frame
    }
}
