//
//  JVMenuItem.swift
//  JVMenu
//
//  Created by Jorge Valbuena on 2020-05-10.
//

import Foundation

/// Holds the data for each menu item
public struct JVMenuItem {
    public var icon: UIImage
    public var title: String
    
    public init(icon: UIImage, title: String) {
        self.icon = icon
        self.title = title
    }
}
