//
//  File.swift
//  messengerApp
//
//  Created by Ramon Queiroz dos Santos on 25/10/22.
//

import Foundation

class Conversation{
	
	var nome: String?
	var ultimaMensagem: String?
	var idDestinatario: String?
	
	init(dicionario: [String:Any]) {
		self.nome = dicionario["nome"] as? String
		self.ultimaMensagem =  dicionario["ultimaMensagem"] as? String
		self.idDestinatario =  dicionario["idDestinatario"] as? String
	}
}
