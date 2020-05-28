//
//  JVMenuDataModel.swift
//  JVMenu
//
//  Created by Jorge Valbuena on 2020-05-10.
//

import Foundation

/// Holds all the data for menu view.
public struct JVMenuDataModel {
    public var items: [JVMenuItem]
    public var backgroundColor: UIColor = UIColor(rgb: 0x3D3D3D)
    public var dropDown: Bool = false
    public var rowHeight: CGFloat = 50
    public var font: UIFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
    public var textColor: UIColor = UIColor.white
    public var separatorColor: UIColor = UIColor.gray
    
    public init(_ items: [JVMenuItem]) {
        self.items = items
    }
}
