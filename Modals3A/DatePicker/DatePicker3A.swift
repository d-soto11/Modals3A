//
//  DatePicker3A.swift
//  Modals3A
//
//  Created by Daniel Soto on 9/27/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit
import JModalController

public class DatePicker3A: UIViewController {
    
    public enum DateLimit {
        case none
        case now
        case tomorrow
        case timeOnDate(String, String)
        case date(String)
    }

    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var picker: UIDatePicker!
    @IBOutlet weak var acceptB: UIButton!
    
    internal var delegate: DatePickerDelegate!
    internal var jm_delegate : JModalDelegate!
    internal var label : String!
    internal var date: String?
    internal var format: String?
    internal var type: UIDatePickerMode?
    internal var tag: Int?
    
    internal var minDate:DateLimit?
    internal var maxDate:DateLimit?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Modals3AConfig.backgroundColor
        self.text.text = label
        self.text.textColor = Modals3AConfig.textColor
        self.acceptB.backgroundColor = Modals3AConfig.foregroundColor
        self.acceptB.setTitleColor(Modals3AConfig.confirmTextColor, for: .normal)
        
        self.picker.datePickerMode = type!
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = self.format
        
        if (date != nil) {
            if let dateDate = dayTimePeriodFormatter.date(from: date!) {
                self.picker.date = dateDate
            }
        }
        
        switch self.minDate! {
        case .none:
            break
        case .now:
            self.picker.minimumDate = Date()
        case .tomorrow:
            self.picker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        case .date(let dateStr):
            if let dateDate = dayTimePeriodFormatter.date(from: dateStr) {
                self.picker.date = dateDate
                self.picker.minimumDate = dateDate
            }
        case .timeOnDate(let dateStr, let frmt):
            print("\(dateStr) | \(frmt)")
            let formatter = DateFormatter()
            formatter.dateFormat = frmt
            let dateDate = formatter.string(from: Date())
            if dateDate == dateStr {
                self.picker.date = Date()
                self.picker.minimumDate = Date()
            }
            
        }
        
        switch self.maxDate! {
        case .none:
            break
        case .now:
            self.picker.maximumDate = Date()
        case .tomorrow:
            self.picker.maximumDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        case .date(let dateStr):
            if let dateDate = dayTimePeriodFormatter.date(from: dateStr) {
                self.picker.maximumDate = dateDate
            }
        case .timeOnDate(let dateStr, let frmt):
            print("\(dateStr) | \(frmt)")
            let formatter = DateFormatter()
            formatter.dateFormat = frmt
            let dateDate = formatter.string(from: Date())
            if dateDate == dateStr {
                self.picker.date = Date()
                self.picker.maximumDate = Date()
            }
        }
        
        self.picker.minuteInterval = 30
    }
    
    override public func viewDidLayoutSubviews() {
        self.acceptB.roundCorners(radius: 20)
        self.acceptB.addLightShadow()
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func closeDatePicker(_ sender: Any) {
        if (!self.picker.viewIsScrolling()) {
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = format
            let dateString = dayTimePeriodFormatter.string(from: picker.date)
            delegate.didPickDate3A(date: picker.date, string:dateString, tag: tag!)
            jm_delegate.dismissModal(self, data: nil)
        }
    }
}

public protocol DatePickerDelegate : NSObjectProtocol {
    
    @available(iOS 7.0, *)
    func didPickDate3A(date: Date, string: String, tag: Int)
    
}
