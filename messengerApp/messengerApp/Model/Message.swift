//
//  MessageAllModel.swift
//  messengerApp
//
//  Created by Ramon Queiroz dos Santos on 25/10/22.
//

import Foundation

class Message {
	
	var texto: String?
	var idUsuario:String?
	
	init(dicionario: [String:Any]) {
		self.texto = dicionario["texto"] as? String
		self.idUsuario = dicionario["idUsuario"] as? String
	}
}

