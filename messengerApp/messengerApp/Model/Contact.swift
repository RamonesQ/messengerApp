//
//  File.swift
//  messengerApp
//
//  Created by Ramon Queiroz dos Santos on 25/10/22.
//

import Foundation

class Contact {
	
	var id: String?
	var nome: String?
	
	init(dicionario: [String:Any]?) {
		self.id = dicionario?["id"] as? String
		self.nome = dicionario?["nome"] as? String
	}
	
	convenience init(id: String?, nome: String?) {
		self.init(dicionario: nil)
		self.id = id
		self.nome = nome
	}
}
