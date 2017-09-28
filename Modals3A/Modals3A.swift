//
//  Modals3A.swift
//  Modals3A
//
//  Created by Daniel Soto on 9/27/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import Foundation
import JModalController

public class Modals3A: NSObject {
    
    public class func optionPickerWith(title: String, options: [String], onViewController: (UIViewController & OptionPickerDelegate), allowMultiple: Bool = false, tag: Int = 0, selected: [Int] = []) -> Void {
        let storyboard = UIStoryboard(name: "OptionPicker3A", bundle: Bundle(for: self))
        let option_picker = storyboard.instantiateViewController(withIdentifier: "OptionPicker") as? OptionPicker3A
        option_picker?.label = title
        option_picker?.delegate = onViewController
        option_picker?.jm_delegate = onViewController as JModalDelegate
        option_picker?.options = options
        option_picker?.allowMultiple = allowMultiple
        option_picker?.tag = tag
        option_picker?.indexes = selected
        let config = JModalConfig(transitionDirection: .bottom, animationDuration: 0.2, backgroundTransform: false, tapOverlayDismiss: true)
        onViewController.presentModal(onViewController, modalViewController: option_picker!, config: config, completion: nil)
    }
    
    public class func datePickerWith(title: String, date: String? = nil, format:String = "dd-MM-yyyy", type: UIDatePickerMode = .date, minDate:DatePicker3A.DateLimit = .none, maxDate:DatePicker3A.DateLimit = .none, delegate: DatePickerDelegate, jm_delegate: JModalDelegate, tag: Int = 0, onViewController: UIViewController) {
        
        let date_picker = DatePicker3A.init(nibName: "DatePicker3A", bundle: Bundle(for: self))
        
        date_picker.label = title
        date_picker.date = date
        date_picker.format = format
        date_picker.type = type
        date_picker.delegate = delegate
        date_picker.jm_delegate = jm_delegate
        date_picker.tag = tag
        
        date_picker.minDate = minDate
        date_picker.maxDate = maxDate
        
        let config = JModalConfig(transitionDirection: .bottom, animationDuration: 0.2, backgroundTransform: false, tapOverlayDismiss: true)
        onViewController.presentModal(onViewController, modalViewController: date_picker, config: config) {
        }
    }
}
