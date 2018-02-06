//
//  Theme.swift
//  ChikaRegistrar
//
//  Created by Mounir Ybanez on 2/6/18.
//  Copyright © 2018 Nir. All rights reserved.
//

import UIKit

public final class Theme {

    public var backgroundColor: UIColor?
    
    public var inputFont: UIFont?
    public var inputTextColor: UIColor?
    
    public var buttonFont: UIFont?
    public var buttonTitleColor: UIColor?
    public var buttonBackgroundColor: UIColor?
    
    public var indicatorColor: UIColor?
    
    public init() {
        self.backgroundColor = .white
        
        self.inputFont = UIFont.systemFont(ofSize: 14.0)
        self.inputTextColor = .black
        
        self.buttonFont = UIFont.systemFont(ofSize: 15.0)
        self.buttonTitleColor = .white
        self.buttonBackgroundColor = .black
        
        self.indicatorColor = .white
    }
    
}
