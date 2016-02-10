//
//  UIView.swift
//  YVSwitch
//
//  Created by Yuliia Veresklia on 1/31/16.
//  Copyright © 2016 yveres. All rights reserved.
//

import UIKit

extension UIView {
    
    var yv_width: CGFloat {
        
        set {self.bounds.size.width = newValue}
        get {return CGRectGetWidth(self.bounds)}
    }
    
    var yv_height: CGFloat {
        
        set {self.bounds.size.height = newValue}
        get {return CGRectGetHeight(self.bounds)}
    }
    
    var yv_left: CGFloat {
        
        set {self.bounds.origin.x = newValue}
        get {return CGRectGetMinX(self.bounds)}
    }
    
    var yv_right: CGFloat {
        
        set {self.bounds.origin.x = newValue - self.bounds.size.width}
        get {return CGRectGetMaxX(self.bounds)}
    }
    
    var yv_top: CGFloat {
        
        set {self.bounds.origin.y = newValue}
        get {return CGRectGetMinY(self.bounds)}
    }
    
    var yv_bottom: CGFloat {
        
        set {self.bounds.origin.y = newValue - self.bounds.size.height}
        get {return CGRectGetMaxY(self.bounds)}
    }
    
    var yv_midX: CGFloat {
        
        return CGRectGetMidX(self.bounds)
    }
    
    var yv_midY: CGFloat {
        
        return CGRectGetMidY(self.bounds)
    }
}
