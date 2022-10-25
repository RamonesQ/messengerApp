//
//  LastMessageCollectionViewCell.swift
//  messengerApp
//
//  Created by Ramon Queiroz dos Santos on 25/10/22.
//

import UIKit

class LastMessageCollectionViewCell: UICollectionViewCell {
	
	static let identifier: String = "LastMessageCollectionViewCell"
	
	lazy var  imageView: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFit
		image.clipsToBounds = false
		image.image = UIImage(systemName: "person.badge.plus")
		return image
	}()
    
	lazy var userName:UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Adicionar novo Contato"
		label.font = UIFont(name: CustomFont.poppinsMedium, size: 16)
		label.textColor = .darkGray
		label.numberOfLines = 0
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
}
