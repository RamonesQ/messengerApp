//
//  MessageDetailCollectionViewCell.swift
//  messengerApp
//
//  Created by Ramon Queiroz dos Santos on 25/10/22.
//

import UIKit

class MessageDetailCollectionViewCell: UICollectionViewCell {
	
	static let identifier: String = "MessageDetailCollectionViewCell"
	
	lazy var  imageView: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFit
		image.clipsToBounds = true
		image.layer.cornerRadius = 26
		image.image = UIImage(named: "imagem-perfil")
		return image
	}()
	 
	lazy var userName:UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 2
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configSuperView()
		setupConstraint()
	}
	
	private func configSuperView(){
		addSubview(imageView)
		addSubview(userName)
	}
	
	private func setupConstraint(){
		NSLayoutConstraint.activate([
			imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
			imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
			imageView.widthAnchor.constraint(equalToConstant: 55),
			imageView.heightAnchor.constraint(equalToConstant: 55),
			
			userName.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
			userName.centerYAnchor.constraint(equalTo: centerYAnchor),
			userName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupViewContact(contact: Contact){
		if let nome = contact.nome {
			setUserName(userName: nome) }
	}
	
	func setupViewConversation(conversation: Conversation){
		setUserNameAttributtedText(conversation)
	}
	
	func setUserName(userName: String){
		let attributedText = NSMutableAttributedString(string: userName, attributes: [NSAttributedString.Key.font : UIFont(name: CustomFont.poppinsMedium, size: 16) ?? UIFont(), NSAttributedString.Key.foregroundColor:UIColor.darkGray])
		self.userName.attributedText = attributedText
	}
	
	func setUserNameAttributtedText(_ conversation: Conversation){
		let attributedText = NSMutableAttributedString(string: "\(conversation.nome ?? "")", attributes: [NSAttributedString.Key.font : UIFont(name: CustomFont.poppinsMedium, size: 16) ?? UIFont(), NSAttributedString.Key.foregroundColor:UIColor.darkGray])
		
		attributedText.append(NSAttributedString(string: "\n\(conversation.ultimaMensagem ?? "")", attributes: [NSAttributedString.Key.font : UIFont(name: CustomFont.poppinsMedium, size: 14) ?? UIFont(), NSAttributedString.Key.foregroundColor:UIColor.lightGray]))
		self.userName.attributedText = attributedText
	}
	
}

