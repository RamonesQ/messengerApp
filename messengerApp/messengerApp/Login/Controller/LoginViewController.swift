//
//  ViewController.swift
//  LoginScreenViewCode
//
//  Created by Ramon Queiroz dos Santos on 20/10/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
	
	
	var loginView: LoginView?
	var auth: Auth?
	var alert: Alert?
	
	override func loadView() {
		loginView = LoginView()
		view = loginView
		navigationController?.isNavigationBarHidden = true
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		auth = Auth.auth()
		loginView?.delegate(delegate: self)
		loginView?.configTextFieldDelegate(delegate: self)
		alert = Alert(controller: self)
	}
}

extension LoginViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		loginView?.validaTextFields()
	}
}

extension LoginViewController: LoginViewProtocol {
	func actionLoginButton() {
//		navigationController?.pushViewController(HomeViewController(), animated: true)
		
		// guard let login = LoginView else {return}
		guard let email = loginView?.emailTextField.text else {return}
		guard let password = loginView?.passwordTextField.text else {return}

		auth?.signIn(withEmail: email, password: password, completion: { (usuario, error) in
			if error != nil {
				self.alert?.getAlert(titulo: "Atenção", mensagem: "Dados incorretos \(String(describing: error))")
			} else {
				if usuario == nil {
					self.alert?.getAlert(titulo: "Atenção", mensagem: "Tivemos um erro, tente mais tarde")
				} else {
					self.alert?.getAlert(titulo: "Parabéns", mensagem: "Usuário logado com sucesso")
				}
			}
		})
	}
	
	func actionRegisterButton() {
		navigationController?.pushViewController(RegisterViewController(), animated: true)
	}
}
