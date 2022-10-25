//
//  Extension+UIView.swift
//  messengerApp
//
//  Created by Ramon Queiroz dos Santos on 25/10/22.
//

import UIKit

extension UIView{
	func pin(to supperView: UIView){
		self.translatesAutoresizingMaskIntoConstraints = false
		self.topAnchor.constraint(equalTo: supperView.topAnchor).isActive = true
		self.leadingAnchor.constraint(equalTo: supperView.leadingAnchor).isActive = true
		self.bottomAnchor.constraint(equalTo: supperView.bottomAnchor).isActive = true
		self.trailingAnchor.constraint(equalTo: supperView.trailingAnchor).isActive = true
	}
}
