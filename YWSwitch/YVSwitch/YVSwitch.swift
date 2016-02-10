//
//  YVSwitch.swift
//  YVSwitch
//
//  Created by Yuliia Veresklia on 1/30/16.
//  Copyright © 2016 yveres. All rights reserved.
//

import UIKit

@IBDesignable class YVSwitch: UIControl {
  
  @IBInspectable var cornerRadius: CGFloat = 0.0
  @IBInspectable var thumbCornerRadius: CGFloat = 0.0
  @IBInspectable var borderWidth: CGFloat = 0.0
  @IBInspectable var onBorderColor: UIColor?
  @IBInspectable var offBorderColor: UIColor?
  @IBInspectable var onTintColor: UIColor?
  @IBInspectable var offTintColor: UIColor?
  @IBInspectable var thumbShadowColor: UIColor?
  @IBInspectable var thumbImage: UIImage?
  @IBInspectable var thumbOnTintColor: UIColor?
  @IBInspectable var thumbOffTintColor: UIColor?
  @IBInspectable var thumbWidthAddition: CGFloat = 0.0
  @IBInspectable var on: Bool = false
  
  private var thumbPath: UIBezierPath?
  private var point: CGPoint!
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    
    backgroundColor = UIColor.clearColor()
    
    point = pointFromTouch(CGPointMake(xInset, yInset))
  }
  
  required init?(coder aDecoder: NSCoder) {
    
    super.init(coder: aDecoder)
    
    backgroundColor = UIColor.clearColor()
    
    point = pointFromTouch(CGPointMake(xInset, yInset))
  }
  
  override func drawRect(rect: CGRect) {
    
    super.drawRect(rect)
    
    let context = UIGraphicsGetCurrentContext()
    let outerRect: CGRect = self.bounds
    let outerPath = createRoundedRectForRect(outerRect, radius: cornerRadius);
    
    let ontintColor = onTintColor != nil ? onTintColor : DefaultOnTintColor
    let offtintColor = offTintColor != nil ? offTintColor : DefaultOffTintColor
    let tintColor = on == true ? ontintColor : offtintColor
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, tintColor?.CGColor);
    CGContextAddPath(context, outerPath);
    
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    drawBorder(rect, ctx: context!)
    drawHandle(context!)
  }
  
  // MARK: - Touch track
  
  override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
    
    super.beginTrackingWithTouch(touch, withEvent: event)
    
    point = pointFromTouch(touch.locationInView(self))
    setNeedsDisplay()
    
    return true
  }
  
  override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
    
    super.continueTrackingWithTouch(touch, withEvent: event)
    
    point = pointFromGoingOnTouch(touch.locationInView(self))
    setNeedsDisplay()
    
    return true
  }
  
  override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
    
    super.endTrackingWithTouch(touch, withEvent: event)
    
    point = pointFromTouch(touch?.locationInView(self))
    setNeedsDisplay()
    
    sendActionsForControlEvents(.ValueChanged)
  }
}

private extension YVSwitch {
  
  func pointFromGoingOnTouch(touchPoint: CGPoint) -> CGPoint {
    
    guard let touch = touchPoint as CGPoint? else {
      return CGPointMake(yv_width / 4.0 + xInset, yInset)
    }
    
    let xValue: CGFloat
    
    switch touch.x > yv_width / 2.0 {
      
    case true:
      xValue = min(touch.x - yv_width / 2.0, yv_right - yv_width / 2.0) - xInset - thumbWidthAddition
      
    case false:
      xValue = max(xInset, touch.x - yv_width / 2.0)
    }
    
    return CGPointMake(xValue, yInset)
  }
  
  func pointFromTouch(touchPoint: CGPoint?) -> CGPoint {
    
    guard let touch = touchPoint as CGPoint? else {
      return CGPointMake(yv_width / 4.0 + xInset + borderWidth, yInset)
    }
    
    let xValue: CGFloat
    
    on = touch.x > yv_width / 2.0
    
    switch on {
      
    case true:
      xValue = yv_right - yv_width / 2.0 - xInset - borderWidth - thumbWidthAddition
      
    case false:
      xValue = xInset + borderWidth
    }
    
    return CGPointMake(xValue, yInset)
  }
  
  // MARK: - Drawings
  
  func createRoundedRectForRect(rect: CGRect, radius: CGFloat) -> CGMutablePathRef {
    
    let path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, nil, CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPathAddArcToPoint(path, nil, CGRectGetMaxX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMaxY(rect), radius);
    CGPathAddArcToPoint(path, nil, CGRectGetMaxX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMaxY(rect), radius);
    CGPathAddArcToPoint(path, nil, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMinY(rect), radius);
    CGPathAddArcToPoint(path, nil, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMinY(rect), radius);
    CGPathCloseSubpath(path);
    
    return path;
  }
  
  func drawHandle(ctx: CGContextRef) {
    
    CGContextSaveGState(ctx);
    
    if thumbShadowColor != nil {
      CGContextSetShadowWithColor(ctx, CGSizeMake(0.0, 0.0), ShadowBlurLevel, thumbShadowColor?.CGColor);
    }
    
    let thumbRect: CGRect = CGRectMake(max(point.x, xInset), yInset, CGRectGetWidth(bounds) / 2.0 + thumbWidthAddition, CGRectGetHeight(bounds) - 4.0)
    
    if thumbImage != nil {
      
      CGContextDrawImage(ctx, thumbRect, thumbImage?.CGImage)
      CGContextRestoreGState(ctx)
    } else {
      
      let thumbPath = createRoundedRectForRect(thumbRect, radius: thumbCornerRadius)
      
      CGContextSaveGState(ctx);
      
      let thumbOnTint = thumbOnTintColor != nil ? thumbOnTintColor : DefaultThumbTintColor
      let thumbOffTint = thumbOffTintColor != nil ? thumbOffTintColor : DefaultThumbTintColor
      let thumbTint = on == true ? thumbOnTint : thumbOffTint
      
      CGContextSetFillColorWithColor(ctx, thumbTint?.CGColor);
      CGContextAddPath(ctx, thumbPath);
      
      CGContextFillPath(ctx)
      CGContextRestoreGState(ctx)
    }
  }
  
  func drawBorder(rect: CGRect, ctx: CGContextRef) {
    
    let insetRect = CGRectInset(rect, borderWidth / 2.0, borderWidth / 2.0)
    let path = createRoundedRectForRect(insetRect, radius: cornerRadius)
    
    CGContextAddPath(ctx, path)
    
    let onborderColor = onBorderColor != nil ? onBorderColor : UIColor.clearColor()
    let offborderColor = offBorderColor != nil ? offBorderColor : UIColor.clearColor()
    
    let borderColor = on == true ? onborderColor : offborderColor
    
    CGContextSetStrokeColorWithColor(ctx, borderColor?.CGColor);
    CGContextSetLineWidth(ctx, borderWidth);
    
    CGContextDrawPath(ctx, .Stroke);
  }
}
