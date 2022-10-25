//
//  File1.swift
//  messengerApp
//
//  Created by Ramon Queiroz dos Santos on 25/10/22.
//

import Foundation

class User{
	
	var nome: String?
	var email: String?
	
	init(dicionario: [String:Any]) {
		self.nome = dicionario["nome"] as? String
		self.email = dicionario["email"] as? String
	}
}
