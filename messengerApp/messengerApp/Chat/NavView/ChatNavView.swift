//
//  ChatNavView.swift
//  messengerApp
//
//  Created by Ramon Queiroz dos Santos on 27/10/22.
//

import UIKit

class ChatNavView: UIView {
	
	var controller:ChatViewController?{
		didSet{
			self.backBtn.addTarget(controller, action: #selector(ChatViewController.tappedBackButton), for: .touchUpInside)
		}
	}
	
	lazy var navBackgroundView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		view.layer.cornerRadius = 35
		view.layer.maskedCorners = [.layerMaxXMaxYCorner]
		view.layer.shadowColor = UIColor(white: 0, alpha: 0.05).cgColor
		view.layer.shadowOffset = CGSize(width: 0, height: 10)
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
		label.text = "Search"
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
	
	lazy var backBtn: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(named: "back"), for: .normal)
		return button
	}()

	lazy var customImage:UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFill
		image.clipsToBounds = true
		image.layer.cornerRadius = 26
		image.image = UIImage(named: "imagem-perfil")
		return image
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configSuperView()
		setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configSuperView(){
		addSubview(navBackgroundView)
		navBackgroundView.addSubview(navBar)
		navBar.addSubview(searchBar)
		navBar.addSubview(backBtn)
		navBar.addSubview(customImage)
		searchBar.addSubview(searchLabel)
		searchBar.addSubview(searchBtn)
	}
	
	private func setupConstraints(){
		NSLayoutConstraint.activate([
			navBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
			navBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
			navBackgroundView.topAnchor.constraint(equalTo: topAnchor),
			navBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
			
			navBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			navBar.trailingAnchor.constraint(equalTo: trailingAnchor),
			navBar.leadingAnchor.constraint(equalTo: leadingAnchor),
			navBar.bottomAnchor.constraint(equalTo: bottomAnchor),
			
			backBtn.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 30),
			backBtn.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
			backBtn.heightAnchor.constraint(equalToConstant: 30),
			backBtn.widthAnchor.constraint(equalToConstant: 30),
			
			customImage.leadingAnchor.constraint(equalTo: backBtn.trailingAnchor, constant: 20),
			customImage.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
			customImage.heightAnchor.constraint(equalToConstant: 55),
			customImage.widthAnchor.constraint(equalToConstant: 55),
			
			searchBar.leadingAnchor.constraint(equalTo: customImage.trailingAnchor, constant: 20),
			searchBar.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
			searchBar.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -20),
			searchBar.heightAnchor.constraint(equalToConstant: 55),
			
			searchLabel.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 25),
			searchLabel.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
			
			searchBtn.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -20),
			searchBtn.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
			searchBtn.widthAnchor.constraint(equalToConstant: 20),
			searchBtn.heightAnchor.constraint(equalToConstant: 20),
			])
	}
	
	

}
