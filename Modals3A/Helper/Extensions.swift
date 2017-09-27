//
//  Extensions.swift
//  Modals3A
//
//  Created by Daniel Soto on 9/27/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import Foundation

extension UIView {
    
    func addNormalShadow() {
        self.layoutIfNeeded()
        let shadowPath = UIBezierPath(rect: self.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    func addInvertedShadow() {
        self.layoutIfNeeded()
        let shadowPath = UIBezierPath(rect: self.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: -2.0)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    func addSpecialShadow(size: CGSize, opacitiy: Float = 0.15) {
        self.layoutIfNeeded()
        let shadowPath = UIBezierPath(rect: self.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = size
        self.layer.shadowOpacity = opacitiy
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    func addLightShadow() {
        self.layoutIfNeeded()
        let shadowPath = UIBezierPath(rect: self.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 0.05
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    func clearShadows() {
        self.layer.shadowOpacity = 0.0
    }
    
    func roundCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.shadowRadius = radius
    }
    
    func bordered(color:UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1.0
    }
    
    public func viewIsScrolling() -> Bool {
        return anySubViewScrolling(view: self)
    }
    
    private func anySubViewScrolling(view: UIView) -> Bool {
        if let scroll = view as? UIScrollView {
            return scroll.isDragging || scroll.isDecelerating
        }
        var subs = false
        for v in view.subviews {
            subs = subs || anySubViewScrolling(view: v)
        }
        return subs
    }
}

extension UIViewController {
    func showAlert(title:String, message:String, closeButtonTitle:String, persistent: Bool = false) {
        Alert3A.show(withTitle: title, body: message, accpetTitle: closeButtonTitle, parent: self, persistent: persistent)
    }
}

extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
    
    func empty() -> Bool {
        return self.count == 0
    }
    
    var head: Element? {
        get {
            return self.first
        }
    }
    
    var tail: Array<Element>? {
        get {
            if self.empty() { return nil }
            return Array(self.dropFirst())
        }
    }
    
    func foldl<A>(acc: A, list: Array<Element>,f: (A, Element) -> A) -> A {
        if list.empty() { return acc }
        return foldl(acc: f(acc, list.head!), list: list.tail!, f: f)
    }
    
    subscript(indexes: [Int]) ->  [Element] {
        var result: [Element] = []
        for index in indexes {
            if index > 0 && index < self.count {
                result.append(self[index])
            }
        }
        return result
    }
    
    func insertionIndexOf(elem: Element, isOrderedBefore: (Element, Element) -> Bool) -> Int {
        var lo = 0
        var hi = self.count - 1
        while lo <= hi {
            let mid = (lo + hi)/2
            if isOrderedBefore(self[mid], elem) {
                lo = mid + 1
            } else if isOrderedBefore(elem, self[mid]) {
                hi = mid - 1
            } else {
                return mid // found at position mid
            }
        }
        return lo // not found, would be inserted at position lo
    }
}
