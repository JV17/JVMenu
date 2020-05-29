//
//  JVMenuProtocol.swift
//  JVMenu
//
//  Created by Jorge Valbuena on 2020-05-10.
//

import Foundation

/// Will contain all the definitions to conform to this protocol.
public protocol JVMenuProtocol: JVMenuViewDelegate {

    /// Will provide all customization data for the menu.
    var data: JVMenuDataModel { get }
        
    /// Will display menu
    func showMenu()
    
    /// Will hide menu
    func hideMenu()
}

/// Default implementation of JVMenuProtocol
public extension JVMenuProtocol {

    func showMenu() {
        guard let window: UIWindow = appWindow else { return }

        if menuView.data == nil {
            menuView.data = data
        }
    
        window.addSubview(menuView)
        menuView.show()
    }
    
    func hideMenu() {
        menuView.hide {
            self.menuView.removeFromSuperview()
        }
    }

    private var appWindow: UIWindow? {
        guard let window: UIWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {
            print("Ops! Couldn't display the menu. No Window found!")
            return nil
        }
        return window
    }
    
    private var menuView: JVMenuView {
        JVMenuView.shared.delegate = self
        return JVMenuView.shared
    }
}
