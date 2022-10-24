////
////  RegisterView.swift
////  LoginScreenViewCode
////
////  Created by Ramon Queiroz dos Santos on 21/10/22.
////

import UIKit

protocol RegisterViewProtocol: AnyObject{
	func actionBackButton()
	func actionRegisterButton()
}

class RegisterView: UIView {

	private weak var delegate: RegisterViewProtocol?
	
	func delegate(delegate: RegisterViewProtocol?){
		self.delegate = delegate
	}

	lazy var backButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(named: "back"), for: .normal)
		button.addTarget(self, action: #selector(self.tappedBackButton), for: .touchUpInside)
		return button
	}()

	lazy var imageAddUser:UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(named: "usuario")
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

	lazy var registerButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Cadastrar", for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
		button.setTitleColor(.lightGray, for: .normal)
		button.clipsToBounds = true
		button.layer.cornerRadius = 7.5
		button.backgroundColor = UIColor(red: 3/255, green: 58/255, blue: 51/255, alpha: 1.0)
		button.isEnabled = false
		button.addTarget(self, action: #selector(self.tappedRegisterButton), for: .touchUpInside)
		return button
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		configBackground()
		configSuperView()
		setupConstraint()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func configBackground(){
		backgroundColor = UIColor(red: 24/255, green: 177/255, blue: 104/255, alpha: 1.0)
	}

	private func configSuperView(){
		addSubview(backButton)
		addSubview(imageAddUser)
		addSubview(emailTextField)
		addSubview(passwordTextField)
		addSubview(registerButton)
	}

	public func configTextFieldDelegate(delegate: UITextFieldDelegate){
		emailTextField.delegate = delegate
		passwordTextField.delegate = delegate
	}

	@objc private func tappedBackButton(){
		self.delegate?.actionBackButton()
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
			registerButton.setTitleColor(.white, for: .normal)
			registerButton.isEnabled = true
		} else {
			registerButton.setTitleColor(.lightGray, for: .normal)
			registerButton.isEnabled = false
		}
	}

	private func setupConstraint(){
		NSLayoutConstraint.activate([
			imageAddUser.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
			imageAddUser.centerXAnchor.constraint(equalTo: centerXAnchor),
			imageAddUser.widthAnchor.constraint(equalToConstant: 150),
			imageAddUser.heightAnchor.constraint(equalToConstant: 150),

			backButton.topAnchor.constraint(equalTo: imageAddUser.topAnchor),
			backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),

			emailTextField.topAnchor.constraint(equalTo: imageAddUser.bottomAnchor, constant: 40),
			emailTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
			emailTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
			emailTextField.heightAnchor.constraint(equalToConstant: 45),

			passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
			passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
			passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
			passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),

			registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
			registerButton.leadingAnchor.constraint(equalTo: imageAddUser.leadingAnchor),
			registerButton.trailingAnchor.constraint(equalTo: imageAddUser.trailingAnchor),
			registerButton.heightAnchor.constraint(equalToConstant: 60),
		])
	}
}
