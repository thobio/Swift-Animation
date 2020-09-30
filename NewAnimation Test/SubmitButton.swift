//
//  SubmitButton.swift
//  NewAnimation Test
//
//  Created by Thobio Joseph on 29/09/20.
//

import UIKit

class SubmitButton: UIButton {
    let tickLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(type buttonType: UIButton.ButtonType,frame:CGRect,borderColor:UIColor,borderWidth:CGFloat,cornerRadius:CGFloat,tintColor: UIColor = UIColor.label) {
        self.init(type:buttonType)
        self.frame = frame
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.tintColor = tintColor
        self.layer.cornerRadius = cornerRadius
    }
    
    func performSubmitAction(parentView:UIView,circleButton:CGFloat, duration:TimeInterval,borderWidth:CGFloat,scale:CGFloat,tickWidth:CGFloat,tickColor:UIColor,backgroundColor:UIColor){
        DispatchQueue.main.async {
            self.setTitle("", for: .normal)
            UIView.animate(withDuration: duration / 3, delay: 0, options: .curveEaseIn, animations: {
                self.layer.borderWidth = borderWidth
                self.frame = CGRect(x: self.center.x - (circleButton / 2), y: self.center.y - (circleButton/2), width: circleButton, height: circleButton)
                self.layer.cornerRadius = self.frame.width / 2.0
                
                let cX:CGFloat = self.center.x
                let cY:CGFloat = self.center.y
                
                let tickPath = UIBezierPath()
                tickPath.move(to: CGPoint(x: cX - (42 * scale), y:  cY - (18 * scale)))
                tickPath.addLine(to: CGPoint(x: cX - (scale * 18), y: cY + (scale * 28)))
                tickPath.addLine(to: CGPoint(x: cX + (scale * 42), y: cY - (scale * 30)))
                self.tickLayer.setShapeLayer(path: tickPath, fillColor: UIColor.clear, lineWidth: tickWidth, strokeStart: 0, strokeEnd: 0, strokeColor: tickColor)
                                parentView.layer.insertSublayer(self.tickLayer, above: self.layer)
            })
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
                        }) { finished in
                let strokeEndAnimation = SubmitButton.getStrokeEndAnimation(duration: duration)
                            self.tickLayer.add(strokeEndAnimation, forKey: "strokeEnd")
                UIView.animate(withDuration: duration) {
                    self.backgroundColor = backgroundColor
                }
            }
            
        }
    }
    static func getStrokeEndAnimation(duration: TimeInterval, toValue: CGFloat = 1.0, isRemovedOnCompletion : Bool = false) -> CABasicAnimation {
        let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        strokeEnd.duration = duration
        strokeEnd.toValue = toValue
        strokeEnd.isRemovedOnCompletion = isRemovedOnCompletion
        strokeEnd.fillMode = .forwards
        return strokeEnd
    }
    
}

extension CAShapeLayer {
    func setShapeLayer(path: UIBezierPath, frame: CGRect = CGRect(), fillColor: UIColor, lineWidth: CGFloat,strokeStart: CGFloat, strokeEnd: CGFloat, strokeColor: UIColor){
        self.path = path.cgPath
        self.frame = frame
        self.fillColor = fillColor.cgColor
        self.lineWidth = lineWidth
        self.strokeStart = strokeStart
        self.strokeEnd = strokeEnd
        self.lineCap = .round
        self.strokeColor = strokeColor.cgColor
    }
}
