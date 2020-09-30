//
//  ViewController.swift
//  NewAnimation Test
//
//  Created by Thobio Joseph on 29/09/20.
//

import UIKit

class ViewController: UIViewController {
    
    var submitButton = SubmitButton()
    var typeDuration: TimeInterval = 0.0325
    let labelName : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Satisfy-Regular", size: 45)
        return lbl
    }()
    var start = 0
    var totalString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageViews = UIImageView()
        imageViews.frame = view.frame
        imageViews.image = UIImage(named: "bg")
        view.addSubview(imageViews)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        drawSun()
    }

    func drawSun(){
        let views = UIView(frame: CGRect(x: -80, y: 350, width: 80, height: 80))
        views.layer.cornerRadius = 80/2
        views.backgroundColor = UIColor(named: "sun")
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customPath().cgPath
        animation.duration = 1.5
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.calculationMode = .paced
        animation.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeIn)
        views.layer.add(animation, forKey: nil)
        view.addSubview(views)
        
        labelName.frame = CGRect(x: 115, y: 170, width: 250, height: 45)
        Timer.scheduledTimer(withTimeInterval: 1.4, repeats: false) { (timer) in
            let displaylink = CADisplayLink(target: self, selector: #selector(self.textChange))
            displaylink.add(to: .main, forMode: .default)
        }
        
        view.addSubview(labelName)
    }
    @objc func textChange(){
        let arrayOfString = "travelquest".characterArray
       
        let end = arrayOfString.count
       
        if start < end {
            self.totalString +=  "\(arrayOfString[start])"
            self.start += 1
            self.labelName.text = self.totalString
        }else{
            self.labelName.text = self.totalString
            
        }
        
    }
   //travelquest
    func drawSubmit(){
        
        let buttonWidth: CGFloat = 160
        let buttonHeight: CGFloat = 62
        
        let cX: CGFloat = self.view.center.x
        let cY: CGFloat = self.view.center.y + 260
        
        let submiButtonFrame = CGRect(x: cX - (buttonWidth / 2), y: cY, width: buttonWidth, height: buttonHeight)
        
        submitButton = SubmitButton(type: .system, frame: submiButtonFrame, borderColor: .systemGreen, borderWidth: 4, cornerRadius: 12, tintColor: UIColor.systemIndigo)
        
        submitButton.setTitle("Submit", for: .normal)
        self.view.addSubview(submitButton)
        
        submitButton.addTarget(self, action: #selector(performSubmit), for: .touchUpInside)
    }
    @objc func performSubmit(){
        submitButton.performSubmitAction(parentView: self.view, circleButton: 84, duration: 0.75, borderWidth: 4, scale: 0.6, tickWidth: 6,
                                               tickColor:  UIColor.white, backgroundColor: UIColor.systemGreen)
    }
}
func customPath() -> UIBezierPath {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: -60, y: 350))
    path.addQuadCurve(to: CGPoint(x: 100, y: 200), controlPoint: CGPoint(x: 45, y: 300))
    return path
}

extension String {
    var characterArray: [Character]{
        var characterArray = [Character]()
        for character in self {
            characterArray.append(character)
        }
        return characterArray
    }
}

