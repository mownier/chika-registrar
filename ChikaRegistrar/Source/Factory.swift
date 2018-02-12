//
//  Factory.swift
//  ChikaRegistrar
//
//  Created by Mounir Ybanez on 2/6/18.
//  Copyright © 2018 Nir. All rights reserved.
//

import ChikaCore
import ChikaFirebase

public final class Factory {

    var theme: Theme?
    var output: ((Result<OK>) -> Void)?
    var registrar: (() -> ChikaCore.Registrar)?
    var onlineSwitcher: (() -> ChikaCore.OnlinePresenceSwitcher)?
    
    public init() {
        self.theme = Theme()
        self.registrar = { Registrar() }
        self.onlineSwitcher = { OnlinePresenceSwitcher() }
    }
    
    public func withTheme(_ theme: Theme) -> Factory {
        self.theme = theme
        return self
    }
    
    public func withOutput(_ output: @escaping (Result<OK>) -> Void) -> Factory {
        self.output = output
        return self
    }
    
    public func withRegistrar(_ registrar: @escaping () -> ChikaCore.Registrar) -> Factory {
        self.registrar = registrar
        return self
    }
    
    public func withOnlineSwitcher(_ switcher: @escaping () -> ChikaCore.OnlinePresenceSwitcher) -> Factory {
        self.onlineSwitcher = switcher
        return self
    }
    
    public func build() -> Scene {
        defer {
            theme = nil
            output = nil
            registrar = nil
            onlineSwitcher = nil
        }
        
        let bundle = Bundle(for: Factory.self)
        let storyboard = UIStoryboard(name: "Registrar", bundle: bundle)
        let scene = storyboard.instantiateInitialViewController() as! Scene
        scene.theme = theme
        scene.output = output
        scene.registrar = registrar
        scene.operation = RegistrarOperation()
        scene.onlineSwitcher = onlineSwitcher
        scene.onlineSwitcherOperator = OnlinePresenceSwitcherOperation()
        return scene
    }
    
}
