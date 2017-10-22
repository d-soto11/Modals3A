//
//  Modals3AConfig.swift
//  Modals3A
//
//  Created by Daniel Soto on 9/27/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import Foundation

public class Modals3AConfig: NSObject {
    public static var backgroundColor: UIColor = .white
    public static var foregroundColor: UIColor = .blue
    public static var textColor: UIColor = .black
    public static var confirmTextColor: UIColor = .white
    public static var cancelTextColor: UIColor = .gray
    public static var fontFamily: String = UIFont.systemFont(ofSize: 12).familyName
    public static var titleFontSize: CGFloat = 25
    public static var bodyFontSize: CGFloat = 20
    public static var roundedCorners: Bool = true
    public static var flatMode: Bool = false
}
