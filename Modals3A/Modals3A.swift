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
    
    internal static let bundle = Bundle(url: Bundle(for: Modals3A.classForCoder()).url(forResource: "Modals3A", withExtension: "bundle")!)
    
    public class func optionPickerWith(title: String, options: [String], onViewController: (UIViewController & OptionPickerDelegate), allowMultiple: Bool = false, tag: Int = 0, selected: [Int] = []) -> Void {
        let storyboard = UIStoryboard(name: "OptionPicker3A", bundle: Modals3A.bundle)
        let picker = storyboard.instantiateViewController(withIdentifier: "Picker") as! OptionPicker3A
        picker.label = title
        picker.delegate = onViewController
        picker.jm_delegate = onViewController as JModalDelegate
        picker.options = options
        picker.allowMultiple = allowMultiple
        picker.tag = tag
        picker.indexes = selected
        let config = JModalConfig(transitionDirection: .bottom, animationDuration: 0.2, backgroundTransform: false, tapOverlayDismiss: true)
        onViewController.presentModal(onViewController, modalViewController: picker, config: config, completion: nil)
    }
    
    public class func datePickerWith(title: String, date: String? = nil, format:String = "yyyy-MM-dd", type: UIDatePickerMode = .date, from:DatePicker3A.DateLimit = .none, to:DatePicker3A.DateLimit = .none, tag: Int = 0, onViewController: (UIViewController & DatePickerDelegate)) {
        
        let date_picker = DatePicker3A.init(nibName: "DatePicker3A", bundle: Modals3A.bundle)
        
        date_picker.label = title
        date_picker.date = date
        date_picker.format = format
        date_picker.type = type
        date_picker.delegate = onViewController
        date_picker.jm_delegate = onViewController as JModalDelegate
        date_picker.tag = tag
        
        date_picker.minDate = from
        date_picker.maxDate = to
        
        let config = JModalConfig(transitionDirection: .bottom, animationDuration: 0.2, backgroundTransform: false, tapOverlayDismiss: true)
        onViewController.presentModal(onViewController, modalViewController: date_picker, config: config) {
        }
    }
}
