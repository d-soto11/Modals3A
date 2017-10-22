//
//  Notification3A.swift
//  Modals3A
//
//  Created by Daniel Soto on 10/9/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit

class Notification3A: UIViewController {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    private var titleString: String!
    private var bodyString: String!
    private var actionTitle: String!
    private var action: (()->Void)!

    
    private static var alertOnView: Bool! = false
    
//    public class func notication(withTitle: String, body: String = "", actionTitle: String = "OK", action: @escaping ()->Void = {() in}, parent: UIViewController) {
//
//        if Notification3A.alertOnView {
//            return
//        }
//
//        let alert = Alert3A(nibName: "Notification3A", bundle: Modals3A.bundle)
//
//        let blackView = UIView()
//        blackView.tag = 95
//        blackView.backgroundColor = .black
//        blackView.translatesAutoresizingMaskIntoConstraints = false
//        blackView.alpha = 0
//        blackView.addGestureRecognizer(UITapGestureRecognizer(target: alert, action: #selector(bgtouch)))
//        parent.view.insertSubview(blackView, aboveSubview: parent.view)
//
//        let bc1 = NSLayoutConstraint(item: blackView, attribute: .leading, relatedBy: .equal, toItem: parent.view, attribute: .leading, multiplier: 1, constant: 0)
//        let bc2 = NSLayoutConstraint(item: blackView, attribute: .trailing, relatedBy: .equal, toItem: parent.view, attribute: .trailing, multiplier: 1, constant: 0)
//        let bc3 = NSLayoutConstraint(item: blackView, attribute: .top, relatedBy: .equal, toItem: parent.view, attribute: .top, multiplier: 1, constant: 0)
//        let bc4 = NSLayoutConstraint(item: blackView, attribute: .bottom, relatedBy: .equal, toItem: parent.view, attribute: .bottom, multiplier: 1, constant: 0)
//
//        parent.view.addConstraints([bc1, bc2, bc3, bc4])
//        parent.view.layoutIfNeeded()
//
//        alert.view.alpha = 0
//        alert.view.translatesAutoresizingMaskIntoConstraints = false
//        parent.view.insertSubview(alert.view, aboveSubview: blackView)
//        alert.view.frame = CGRect(x: 0, y: parent.view.frame.height, width: parent.view.frame.width, height: 100)
//        
//        let c1 = NSLayoutConstraint(item: alert.view, attribute: .width, relatedBy: .equal, toItem: blackView, attribute: .width, multiplier: 0.9, constant: 0)
//        let c2 = NSLayoutConstraint(item: alert.view, attribute: .centerX, relatedBy: .equal, toItem: blackView, attribute: .centerX, multiplier: 1, constant: 0)
//        alert.centerY = NSLayoutConstraint(item: alert.view, attribute: .centerY, relatedBy: .equal, toItem: blackView, attribute: .centerY, multiplier: 1, constant: 0)
//        let plus = 20*(round(Double(body.characters.count / 20)))
//        let c4 = NSLayoutConstraint(item: alert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CGFloat(200 + plus))
//        parent.view.addConstraints([c1, c2, alert.centerY, c4])
//
//
//        UIView.animate(withDuration: 0.3) {
//            parent.view.layoutIfNeeded()
//            if Modals3AConfig.roundedCorners {
//                alert.view.roundCorners(radius: 20)
//            }
//            parent.view.viewWithTag(95)?.alpha = 0.7
//            alert.view.alpha = 1
//        }
//
//        alert.titleString = withTitle
//        alert.bodyString = body
//        alert.acceptTitle = accpetTitle
//        alert.cancelTitle = cancelTitle
//        alert.confirmation = confirmation
//        alert.cancelation = cancelation
//        alert.container = parent
//        alert.persistent = persistent
//
//        parent.addChildViewController(alert)
//        alert.didMove(toParentViewController: parent)
//    }
    
    @IBOutlet weak var iconWidth: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func performAction(_ sender: Any) {
    }
    

}
