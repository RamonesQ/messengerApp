//
//  ContatoController.swift
//  messengerApp
//
//  Created by Ramon Queiroz dos Santos on 26/10/22.
//

import Foundation
import UIKit
import FirebaseFirestore

protocol ContatoProtocol: AnyObject {
	func alertStateError(titulo:String, message:String)
	func successContato()
}

class ContatoController{
	
	weak var delegate: ContatoProtocol?
	
	public func delegate(delegate: ContatoProtocol?){
		self.delegate = delegate
	}
	
	func addContact(email:String, emailUsuarioLogado:String, idUsuario: String){
		
		if email == emailUsuarioLogado{
			delegate?.alertStateError(titulo: "Voce adicionou seu proprio email", message: "Adicione um email diferente")
			return
		}
		
		let firestore = Firestore.firestore()
		firestore.collection("usuarios").whereField("email", isEqualTo: email).getDocuments { snapshotResultado, error in
			if let totalItens = snapshotResultado?.count{
				if totalItens == 0{
					self.delegate?.alertStateError(titulo: "Usuario nao cadastrado", message: "Verifique o email e tente novamente")
					return
				}
			}
			if let snapshot = snapshotResultado{
				for document in snapshot.documents{
					let dados = document.data()
					self.salvarContato(dadosContato: dados, idUsuario: idUsuario)
				}
			}
		}
	}
	
	func salvarContato(dadosContato: Dictionary<String, Any>, idUsuario: String){
		let contact: Contact = Contact(dicionario: dadosContato)
		let firestore: Firestore = Firestore.firestore()
		guard let contactId = contact.id else {return}
		firestore.collection("usuarios").document(idUsuario).collection("contatos").document(contactId).setData(dadosContato){(error) in
			if error == nil {
				self.delegate?.successContato()
			}
		}
	}
	
}
