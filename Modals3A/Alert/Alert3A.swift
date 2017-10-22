//
//  Alert3A.swift
//  Modals3A
//
//  Created by Daniel Soto on 9/27/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit

public class Alert3A: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var confirmationB: UIButton!
    @IBOutlet weak var cancelB: UIButton!
    @IBOutlet weak var cancelHeigth: NSLayoutConstraint!
    private var titleString: String!
    private var bodyString: String!
    private var acceptTitle: String!
    private var cancelTitle: String?
    private var confirmation: (()->Void)!
    private var cancelation: (()->Void)!
    private var persistent: Bool!
    private var container: UIViewController!
    private var centerY: NSLayoutConstraint!
    
    private static let nib = !Modals3AConfig.flatMode ? "Alert3A" : "FlatAlert3A"
    private static var alertOnView: Bool! = false
    
    public class func show(withTitle: String, body: String = "", accpetTitle: String = "OK", cancelTitle: String? = nil, confirmation: @escaping ()->Void = {() in}, cancelation: @ escaping ()->Void = {() in}, parent: UIViewController, persistent: Bool = false) {
        
        if Alert3A.alertOnView {
            return
        }
        
        let alert = Alert3A(nibName: nib, bundle: Modals3A.bundle)
        
        let blackView = UIView(frame: parent.view.frame)
        blackView.tag = 95
        blackView.backgroundColor = .black
        blackView.translatesAutoresizingMaskIntoConstraints = false
        blackView.alpha = 0
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: alert, action: #selector(bgtouch)))
        parent.view.addSubview(blackView)
        
        let bc1 = NSLayoutConstraint(item: blackView, attribute: .leading, relatedBy: .equal, toItem: parent.view, attribute: .leading, multiplier: 1, constant: 0)
        let bc2 = NSLayoutConstraint(item: blackView, attribute: .trailing, relatedBy: .equal, toItem: parent.view, attribute: .trailing, multiplier: 1, constant: 0)
        let bc3 = NSLayoutConstraint(item: blackView, attribute: .top, relatedBy: .equal, toItem: parent.view, attribute: .top, multiplier: 1, constant: 0)
        let bc4 = NSLayoutConstraint(item: blackView, attribute: .bottom, relatedBy: .equal, toItem: parent.view, attribute: .bottom, multiplier: 1, constant: 0)
        
        parent.view.addConstraints([bc1, bc2, bc3, bc4])
        parent.view.layoutIfNeeded()
        
        alert.view.alpha = 0
        alert.view.translatesAutoresizingMaskIntoConstraints = false
        parent.view.insertSubview(alert.view, aboveSubview: blackView)
        alert.view.frame = CGRect(x: 0, y: parent.view.frame.height, width: parent.view.frame.width, height: 100)
        
        let c1 = NSLayoutConstraint(item: alert.view, attribute: .width, relatedBy: .equal, toItem: blackView, attribute: .width, multiplier: 0.9, constant: 0)
        let c2 = NSLayoutConstraint(item: alert.view, attribute: .centerX, relatedBy: .equal, toItem: blackView, attribute: .centerX, multiplier: 1, constant: 0)
        alert.centerY = NSLayoutConstraint(item: alert.view, attribute: .centerY, relatedBy: .equal, toItem: blackView, attribute: .centerY, multiplier: 1, constant: 0)
        let plus = 20*(round(Double(body.characters.count / 20)))
        let c4 = NSLayoutConstraint(item: alert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CGFloat(200 + plus))
        parent.view.addConstraints([c1, c2, alert.centerY, c4])
        
        
        UIView.animate(withDuration: 0.3) {
            parent.view.layoutIfNeeded()
            if Modals3AConfig.roundedCorners {
                alert.view.roundCorners(radius: 20)
            }
            parent.view.viewWithTag(95)?.alpha = 0.7
            alert.view.alpha = 1
        }
        
        alert.titleString = withTitle
        alert.bodyString = body
        alert.acceptTitle = accpetTitle
        alert.cancelTitle = cancelTitle
        alert.confirmation = confirmation
        alert.cancelation = cancelation
        alert.container = parent
        alert.persistent = persistent
        
        parent.addChildViewController(alert)
        alert.didMove(toParentViewController: parent)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Modals3AConfig.backgroundColor
        self.bodyLabel.textColor = Modals3AConfig.textColor
        self.bodyLabel.font = UIFont(name: Modals3AConfig.fontFamily, size: Modals3AConfig.bodyFontSize)
        self.titleLabel.textColor = Modals3AConfig.textColor
        self.titleLabel.font = UIFont(name: Modals3AConfig.fontFamily, size: Modals3AConfig.titleFontSize)
        if Modals3AConfig.flatMode {
            self.confirmationB.backgroundColor = Modals3AConfig.backgroundColor
            self.confirmationB.setTitleColor(Modals3AConfig.foregroundColor, for: .normal)
        } else {
            self.confirmationB.backgroundColor = Modals3AConfig.foregroundColor
            self.confirmationB.setTitleColor(Modals3AConfig.confirmTextColor, for: .normal)
        }
        self.cancelB.setTitleColor(Modals3AConfig.cancelTextColor, for: .normal)
    }
    
    @objc public func bgtouch() {
        
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        Alert3A.alertOnView = true
        self.titleLabel.text = self.titleString
        self.bodyLabel.text = self.bodyString
        self.confirmationB.setTitle(self.acceptTitle, for: .normal)
        if self.cancelTitle != nil {
            self.cancelB.setTitle(self.cancelTitle, for: .normal)
            self.cancelHeigth.constant = 30
            UIView.animate(withDuration: 0.3, animations: {
                self.cancelB.alpha = 1
                self.view.layoutIfNeeded()
            })
        }
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        Alert3A.alertOnView = false
    }
    
    override public func viewDidLayoutSubviews() {
        if !Modals3AConfig.flatMode {
            self.confirmationB.addNormalShadow()
            self.confirmationB.roundCorners(radius: 20)
            
            if self.cancelTitle != nil {
                self.cancelB.roundCorners(radius: 15)
                self.cancelB.bordered(color: Modals3AConfig.cancelTextColor)
            }
        }
        
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func confirm(_ sender: Any) {
        self.confirmation()
        self.dismiss()
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.cancelation()
        self.dismiss()
    }
    
    private func dismiss() {
        guard persistent == false else {
            return
        }
        self.centerY.constant = self.container.view.frame.height
        UIView.animate(withDuration: 0.3, animations: {
            self.container.view.layoutIfNeeded()
            self.container.view.viewWithTag(95)?.alpha = 0
            self.view.alpha = 0
        }) { (finished) in
            self.container.view.viewWithTag(95)?.removeFromSuperview()
            self.view.removeFromSuperview()
            self.didMove(toParentViewController: nil)
        }
    }

}
