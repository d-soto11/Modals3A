//
//  OptionPicker3A.swift
//  Modals3A
//
//  Created by Daniel Soto on 9/27/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit
import JModalController

class OptionPicker3A: UIViewController, UITableViewDelegate, UITableViewDataSource {
    internal var options: [String] = []
    internal var allowMultiple = false
    internal var label: String = "Options"
    internal var tag:Int = 0
    internal var indexes: [Int] = []
    
    internal var layouted:Bool = false
    
    @IBOutlet weak var optionTable: UITableView!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var doneB: UIButton!
    
    internal var delegate: OptionPickerDelegate!
    
    internal var jm_delegate : JModalDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.text.text = label
        self.text.textColor = Modals3AConfig.textColor
        self.text.font = UIFont(name: Modals3AConfig.fontFamily, size: Modals3AConfig.titleFontSize)
        self.view.backgroundColor = Modals3AConfig.backgroundColor
        self.doneB.backgroundColor = Modals3AConfig.foregroundColor
        self.doneB.setTitleColor(Modals3AConfig.confirmTextColor, for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        self.layouted = true
        self.doneB.roundCorners(radius: 20)
        self.doneB.addLightShadow()
        self.optionTable.reloadData()
    }
    
    
    @IBAction func closePicker(_ sender: Any) {
        guard !indexes.isEmpty else{
            showAlert(title: "Lo sentimos", message: "Debes seleccionar una opción", closeButtonTitle: "Listo")
            return
        }
        if allowMultiple {
            delegate.didPickMultipleOptions3A!(indexes: indexes, selected: options[indexes], tag:tag)
            jm_delegate.dismissModal(self, data: nil)
        } else {
            delegate.didPickSingleOption3A(index: indexes[0], selected: options[indexes[0]], tag:tag)
            jm_delegate.dismissModal(self, data: nil)
        }
        
        
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return layouted ? options.count : 0
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath)
        if self.layouted {
            (cell.viewWithTag(1)?.clearShadows())
            (cell.viewWithTag(1)?.addNormalShadow())
            if indexes.contains(indexPath.row) {
                cell.viewWithTag(1)?.backgroundColor = Modals3AConfig.foregroundColor
                (cell.viewWithTag(1)?.viewWithTag(2) as? UILabel)?.textColor = Modals3AConfig.confirmTextColor
            } else {
                cell.viewWithTag(1)?.backgroundColor = Modals3AConfig.backgroundColor
                (cell.viewWithTag(1)?.viewWithTag(2) as? UILabel)?.textColor = Modals3AConfig.textColor
            }
        }
        (cell.viewWithTag(1)?.viewWithTag(2) as? UILabel)?.text = options[indexPath.row]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if allowMultiple {
            if indexes.contains(indexPath.row) {
                indexes.remove(object: indexPath.row)
            } else {
                indexes.append(indexPath.row)
            }
            tableView.reloadRows(at: [indexPath], with: .fade)
        } else {
            indexes.insert(indexPath.row, at: 0)
            tableView.reloadRows(at: [indexPath], with: .fade)
            self.closePicker(self)
        }
    }

}

@objc public protocol OptionPickerDelegate : NSObjectProtocol {
    
    @available(iOS 7.0, *)
    func didPickSingleOption3A(index:Int, selected:String, tag:Int)
    
    @objc @available(iOS 7.0, *)
    optional func didPickMultipleOptions3A(indexes:[Int], selected:[String], tag:Int)
    
}
