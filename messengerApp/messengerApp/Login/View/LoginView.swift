//
//  view.swift
//  LoginScreenViewCode
//
//  Created by Ramon Queiroz dos Santos on 20/10/22.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
	func actionLoginButton()
	func actionRegisterButton()
}

class LoginView: UIView {
	
	private weak var delegate: LoginViewProtocol?
	
	func delegate(delegate:LoginViewProtocol?){
		self.delegate = delegate
	}

	lazy var loginLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .white
		label.font = UIFont.boldSystemFont(ofSize: 40)
		label.text = "Login"
		return label
	}()
	
	lazy var logoAppImageView:UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(named: "logo")
		image.tintColor = .green
		image.contentMode = .scaleAspectFit
		return image
	}()
	
	lazy var emailTextField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.autocorrectionType = .no
		textField.backgroundColor = .white
		textField.borderStyle = .roundedRect
		textField.keyboardType = .emailAddress
		textField.placeholder = "Digite seu email: "
		textField.textColor = .darkGray
		return textField
	}()
	
	lazy var passwordTextField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.autocorrectionType = .no
		textField.backgroundColor = .white
		textField.borderStyle = .roundedRect
		textField.keyboardType = .default
		textField.isSecureTextEntry = true
		textField.placeholder = "Digite sua senha: "
		textField.textColor = .darkGray
		return textField
	}()
	
	lazy var loginButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Logar", for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
		button.setTitleColor(.lightGray, for: .normal)
		button.clipsToBounds = true
		button.layer.cornerRadius = 7.5
		button.backgroundColor = UIColor(red: 3/255, green: 58/255, blue: 51/255, alpha: 1.0)
		button.addTarget(self, action: #selector(self.tappedLoginButton), for: .touchUpInside)
		return button
	}()
	
	lazy var registerButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Cadastre-se", for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
		button.setTitleColor(.white, for: .normal)
		button.addTarget(self, action: #selector(self.tappedRegisterButton), for: .touchUpInside)
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configBackgrounf()
		configSuperView()
		setupConstraint()
	}
	
	private func configBackgrounf(){
		backgroundColor = UIColor(red: 24/255, green: 177/255, blue: 104/255, alpha: 1.0)
	}
	
	private func configSuperView(){
		addSubview(loginLabel)
		addSubview(logoAppImageView)
		addSubview(emailTextField)
		addSubview(passwordTextField)
		addSubview(loginButton)
		addSubview(registerButton)
	}
	
	public func configTextFieldDelegate(delegate: UITextFieldDelegate){
		emailTextField.delegate = delegate
		passwordTextField.delegate = delegate
	}
	
	@objc private func tappedLoginButton(){
		self.delegate?.actionLoginButton()
	}
	@objc private func tappedRegisterButton(){
		self.delegate?.actionRegisterButton()
	}
	
	public func validaTextFields(){
		guard let email: String = emailTextField.text else {return}
		guard let password: String = passwordTextField.text else {return}
		
		if !email.isEmpty && !password.isEmpty{
			configButtonEnable(true)
		} else {
			configButtonEnable(false)
		}
	}
	
	private func configButtonEnable(_ enable: Bool){
		if enable{
			loginButton.setTitleColor(.white, for: .normal)
			loginButton.isEnabled = true
		} else {
			loginButton.setTitleColor(.lightGray, for: .normal)
			loginButton.isEnabled = false
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupConstraint(){
		NSLayoutConstraint.activate([
			loginLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
			loginLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
			
			logoAppImageView.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 30),
			logoAppImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 80),
			logoAppImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -80),
			logoAppImageView.heightAnchor.constraint(equalToConstant: 100),
			
			emailTextField.topAnchor.constraint(equalTo: logoAppImageView.bottomAnchor, constant: 40),
			emailTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
			emailTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
			emailTextField.heightAnchor.constraint(equalToConstant: 45),
			
			passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
			passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
			passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
			passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
			
			loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
			loginButton.leadingAnchor.constraint(equalTo: logoAppImageView.leadingAnchor),
			loginButton.trailingAnchor.constraint(equalTo: logoAppImageView.trailingAnchor),
			loginButton.heightAnchor.constraint(equalToConstant: 60),
			
			registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 40),
			registerButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
			registerButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
			registerButton.heightAnchor.constraint(equalToConstant: 20),
		])
	}
	
}
