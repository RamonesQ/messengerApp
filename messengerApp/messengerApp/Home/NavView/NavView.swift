//
//  NavView.swift
//  messengerApp
//
//  Created by Ramon Queiroz dos Santos on 25/10/22.
//

import UIKit

enum TypeChatOrContact{
	case chat
	case contact
}

protocol NavViewProtocol: AnyObject{
	func typeScreenMessage(type: TypeChatOrContact)
}

class NavView: UIView {
	
	weak private var delegate: NavViewProtocol?
	
	func delegate(delegate: NavViewProtocol?){
		self.delegate = delegate
	}
	
	lazy var navBackgroundView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		view.layer.cornerRadius = 35
		view.layer.maskedCorners = [.layerMaxXMaxYCorner]
		view.layer.shadowColor = UIColor(white: 0, alpha: 0.02).cgColor
		view.layer.shadowOffset = CGSize(width: 0, height: 5)
		view.layer.shadowOpacity = 1
		view.layer.shadowRadius = 10
		return view
	}()
	
	lazy var navBar:UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .clear
		return view
	}()
	
	// mudar para searchbar
	
	lazy var searchBar: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = CustomColor.appLight
		view.clipsToBounds = true
		view.layer.cornerRadius = 20
		return view
	}()
	
	lazy var searchLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Digite aqui"
		label.font = UIFont(name: CustomFont.poppinsMedium, size: 16)
		label.textColor = .lightGray
		return label
	}()
	
	lazy var searchBtn: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(named: "search"), for: .normal)
		return button
	}()

	lazy var stackView:UIStackView = {
		let stackV = UIStackView()
		stackV.translatesAutoresizingMaskIntoConstraints = false
		stackV.distribution = .fillEqually
		stackV.axis = .horizontal
		stackV.spacing = 10
		return stackV
	}()
	
	lazy var chatBtn: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(systemName: "message")?.withRenderingMode(.alwaysTemplate), for: .normal)
		button.tintColor = .black
		button.addTarget(self, action: #selector(self.tappedChatBtn), for: .touchUpInside)
		return button
	}()
	
	lazy var contactBtn: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(named: "group")?.withRenderingMode(.alwaysTemplate), for: .normal)
		button.tintColor = .systemPink
		button.addTarget(self, action: #selector(self.tappedContactBtn), for: .touchUpInside)
		return button
	}()
	
	@objc func tappedChatBtn(){
		self.delegate?.typeScreenMessage(type: .chat)
		chatBtn.tintColor = .systemPink
		contactBtn.tintColor = .black
	}
	
	@objc func tappedContactBtn(){
		self.delegate?.typeScreenMessage(type: .contact)
		chatBtn.tintColor = .black
		contactBtn.tintColor = .systemPink
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		configSuperView()
		setupConstraints()
	}
	
	func configSuperView(){
		addSubview(navBackgroundView)
		navBackgroundView.addSubview(navBar)
		navBar.addSubview(searchBar)
		navBar.addSubview(stackView)
		searchBar.addSubview(searchLabel)
		searchBar.addSubview(searchBtn)
		stackView.addArrangedSubview(chatBtn)
		stackView.addArrangedSubview(contactBtn)
	}
	
	func setupConstraints(){
		NSLayoutConstraint.activate([
			navBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
			navBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
			navBackgroundView.topAnchor.constraint(equalTo: topAnchor),
			navBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
			
			navBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			navBar.trailingAnchor.constraint(equalTo: trailingAnchor),
			navBar.leadingAnchor.constraint(equalTo: leadingAnchor),
			navBar.bottomAnchor.constraint(equalTo: bottomAnchor),
			
			searchBar.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 30),
			searchBar.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
			searchBar.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -20),
			searchBar.heightAnchor.constraint(equalToConstant: 55),
			
			stackView.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -30),
			stackView.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
			stackView.widthAnchor.constraint(equalToConstant: 100),
			stackView.heightAnchor.constraint(equalToConstant: 30),
			
			searchLabel.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 25),
			searchLabel.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
			
			searchBtn.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -20),
			searchBtn.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
			searchBtn.widthAnchor.constraint(equalToConstant: 20),
			searchBtn.heightAnchor.constraint(equalToConstant: 20),
			])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
