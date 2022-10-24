//
//  RegisterViewController.swift
//  LoginScreenViewCode
//
//  Created by Ramon Queiroz dos Santos on 21/10/22.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
	
	var registerView: RegisterView?
	
	var auth: Auth?
	var alert: Alert?
	
	override func loadView() {
		registerView = RegisterView()
		view = registerView
		navigationController?.isNavigationBarHidden = true
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		registerView?.delegate(delegate: self)
		registerView?.configTextFieldDelegate(delegate: self)
		auth = Auth.auth()
		alert = Alert(controller: self)
	}
}

extension RegisterViewController: UITextFieldDelegate{
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
	}
}

extension RegisterViewController: RegisterViewProtocol{
	
	func actionBackButton() {
		navigationController?.popViewController(animated: true)
	}

	func textFieldDidEndEditing(_ textField: UITextField) {
		registerView?.validaTextFields()
	}
	
	func actionRegisterButton() {
		
		guard let email = registerView?.emailTextField.text else {return}
		guard let password = registerView?.passwordTextField.text else {return}
		
		auth?.createUser(withEmail: email, password: password, completion: { (result, error) in
			if error != nil {
				self.alert?.getAlert(titulo: "Atenção", mensagem: "\(String(describing: error))")
			} else {
				print("\(email) Cadastrado")
				self.alert?.getAlert(titulo: "Parabéns", mensagem: "Usuário cadastrado com sucesso", completion: {
					self.navigationController?.popViewController(animated: true)
				})
			}
		})
	}
}
