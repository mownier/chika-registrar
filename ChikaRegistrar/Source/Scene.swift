//
//  Scene.swift
//  ChikaRegistrar
//
//  Created by Mounir Ybanez on 2/6/18.
//  Copyright © 2018 Nir. All rights reserved.
//

import UIKit
import ChikaCore

public final class Scene: UIViewController {

    enum State {
        
        case idle, registering
    }
    
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var output: ((Result<OK>) -> Void)!
    var registrar: (() -> Registrar)!
    var operation: RegistrarOperator!
    
    var onlineSwitcher: (() -> OnlinePresenceSwitcher)!
    var onlineSwitcherOperator: OnlinePresenceSwitcherOperator!
    
    var state: State = .idle {
        didSet {
            guard isViewLoaded else {
                return
            }
            
            updateView(withState: state)
        }
    }
    
    public internal(set) var theme: Theme!
    
    deinit {
        dispose()
    }
    
    public func dispose() {
        theme = nil
        output = nil
        registrar = nil
        operation = nil
        onlineSwitcher = nil
        onlineSwitcherOperator = nil
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView(withState: state)
        
        guard theme != nil else {
            return
        }
        
        styleInput(emailInput)
        styleInput(passwordInput)
        styleButton(goButton)
        styleIndicator(indicatorView)
    }
    
    @IBAction func go() {
        guard registrar != nil else {
            return
        }
        
        state = .registering
        
        let email = emailInput.text ?? ""
        let password = passwordInput.text ?? ""
        let _ = operation.withEmail(email).withPassword(password).withCompletion(completion).register(using: registrar())
    }
    
    private func styleIndicator(_ indicator: UIActivityIndicatorView) {
        indicator.color = theme.indicatorColor
    }
    
    private func styleButton(_ button: UIButton) {
        button.titleLabel?.font = theme.buttonFont
        button.backgroundColor = theme.buttonBackgroundColor
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.setTitleColor(theme.buttonTitleColor, for: .normal)
    }
    
    private func styleInput(_ input: UITextField) {
        input.font = theme.inputFont
        input.tintColor = theme.inputTextColor
        input.textColor = theme.inputTextColor
        input.layer.cornerRadius = 4
        input.layer.borderWidth = 1
        input.layer.masksToBounds = true
        input.layer.borderColor = theme.inputTextColor?.cgColor
    }
    
    private func updateView(withState state: State) {
        switch state {
        case .idle:
            view.isUserInteractionEnabled = true
            indicatorView.stopAnimating()
            
        case .registering:
            view.isUserInteractionEnabled = false
            indicatorView.stopAnimating()
        }
    }
    
    private func completion(_ result: Result<Auth>) {
        state = .idle
        
        guard output != nil else {
            return
        }
        
        switch result {
        case .ok:
            let _ = onlineSwitcherOperator.switchToOnline(using: onlineSwitcher())
            output(.ok(OK("registered successfully")))
            
        case .err(let error):
            output(.err(error))
        }
    }
    
}
