//
//  ViewController.swift
//  YWSwitch
//
//  Created by Yuliia Veresklia on 2/10/16.
//  Copyright © 2016 Yuliia Veresklia. All rights reserved.
//

import UIKit

let switchHeight: CGFloat = 45.0
let switchWidth: CGFloat = 75.0
let switchBottomPadding: CGFloat = 100.0

final class ViewController: UIViewController {
    
    private var customSwith: YVSwitch?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setup()
    }
}

private extension ViewController {
    
    func setup() {
        
        customSwith = YVSwitch()
        
        let xPosition = CGRectGetMidX(view.bounds) - switchWidth / 2
        let yPosition = CGRectGetHeight(view.bounds) - switchHeight - switchBottomPadding
        
        customSwith?.frame = CGRectMake(xPosition, yPosition, switchWidth, switchHeight)
        
        customSwith?.onTintColor = UIColor.YVBlueColor()
        customSwith?.offTintColor = UIColor.YVLightGreenColor()
        
        customSwith?.thumbOnTintColor = UIColor.YVOrangeColor()
        customSwith?.thumbOffTintColor = UIColor.YVOrangeColor()
        
        customSwith?.offBorderColor = UIColor.YVBlueColor()
        customSwith?.borderWidth = 2.0
        
        customSwith?.cornerRadius = 10.0
        customSwith?.thumbCornerRadius = 10.0
        
        customSwith?.addTarget(self, action: "frameSwitchValueChanged:", forControlEvents: .ValueChanged)
        
        view.addSubview(customSwith!)
    }
    
    @IBAction func storyboardSwitchValueChanged(sender: YVSwitch) {
        
        print("Storyboard switch instance value changed to: \(sender.on)")
    }
    
    @objc func frameSwitchValueChanged(sender: YVSwitch) {
        
        print("Frame switch instance value changed to \(sender.on)")
    }
}

