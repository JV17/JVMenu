//
//  JVMenuDashView.swift
//  JVMenu
//
//  Created by Jorge Valbuena on 2020-05-27.
//

import UIKit

class JVMenuDashView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        drawView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        drawView()
    }
    
    private func drawView() {
        layer.cornerRadius = frame.height*0.5
        layer.backgroundColor = UIColor.gray.cgColor
    }
}
