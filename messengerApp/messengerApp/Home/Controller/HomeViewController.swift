//
//  HomeViewController.swift
//  messengerApp
//
//  Created by Ramon Queiroz dos Santos on 25/10/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController {
	
	
	var auth: Auth?
	var db: Firestore?
	var idUsuarioLogado: String?
	
	var screenContact:Bool?
	var emailUsuarioLogado: String?
	var alert: Alert?
	
	var homeView: HomeView?
	
	var contato: ContatoController?
	var listaContato: [Contact] = []
	var listaConversas: [Conversation] = []
	var conversasListener: ListenerRegistration?
	
	override func loadView() {
		homeView = HomeView()
		view = homeView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		 navigationController?.navigationBar.isHidden = true
		 view.backgroundColor = CustomColor.appLight
		 configHomeView()
		 configCollectionView()
		 configAlert()
		 configIdentifierFirebase()
		 configContato()
		 addListenerRecuperarConversa()
    }
	
	private func configHomeView(){
		homeView?.navView.delegate(delegate: self)
	}
	
	private func configCollectionView(){
		self.homeView?.delegateCollectionView(delegate: self, dataSource: self)
	}
	
	private func configAlert(){
		alert = Alert(controller: self)
	}
	
	private func configIdentifierFirebase(){
		self.auth = Auth.auth()
		self.db = Firestore.firestore()
		
		if let currentUser = auth?.currentUser{
			self.idUsuarioLogado = currentUser.uid
			self.emailUsuarioLogado = currentUser.email
		}
	}
	
	private func configContato(){
		self.contato = ContatoController()
		self.contato?.delegate(delegate: self)
	}
	
	func getContato(){
		guard let idUsuerLogado = idUsuarioLogado else {return}
		self.listaContato.removeAll()
		self.db?.collection("usuarios").document(idUsuerLogado).collection("contatos").getDocuments(completion: { snapshotResultado, error in
			if error != nil {
				print("error getContato")
				return
			}
			if let snapshot = snapshotResultado {
				for document in snapshot.documents{
					let dadosContato = document.data()
					self.listaContato.append(Contact(dicionario: dadosContato))
				}
				self.homeView?.reloadCollectionView()
			}
		})
	}
	
	func addListenerRecuperarConversa(){
		
		if let idUsuarioLogado = auth?.currentUser?.uid {
			self.conversasListener = db?.collection("conversas").document(idUsuarioLogado).collection("ultimas conversas").addSnapshotListener({ querySnapshot, error in
				if error == nil {
					self.listaConversas.removeAll()
					if let snapshot = querySnapshot{
						for document in snapshot.documents {
							let dados = document.data()
							self.listaConversas.append(Conversation(dicionario: dados))
						}
						self.homeView?.reloadCollectionView()
					}
				}
			})
		}
	}
	
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		if self.screenContact ?? false {
			return self.listaContato.count + 1
		} else {
			return self.listaConversas.count
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if self.screenContact ?? false {
			if indexPath.row == self.listaContato.count{
				let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LastMessageCollectionViewCell.identifier, for: indexPath)
				return cell
			} else {
				let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageDetailCollectionViewCell.identifier, for: indexPath) as? MessageDetailCollectionViewCell
				cell?.setupViewContact(contact: self.listaContato[indexPath.row])
				return cell ?? UICollectionViewCell()
			}
		} else {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageDetailCollectionViewCell.identifier, for: indexPath) as? MessageDetailCollectionViewCell
			cell?.setupViewConversation(conversation: self.listaConversas[indexPath.row])
			return cell ?? UICollectionViewCell()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		 
		 if self.screenContact ?? false{
			  if indexPath.row == self.listaContato.count{
					self.alert?.addContact(completion: { value in
						 self.contato?.addContact(email: value, emailUsuarioLogado: self.emailUsuarioLogado ?? "", idUsuario: self.idUsuarioLogado ?? "")
					})
					
			  }else{
				  
				
					
			  }
			  
			  
		 }else{
			  
			  //TO DO
			  
		 }
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.frame.width, height: 100)
	}
}


extension HomeViewController: NavViewProtocol{
	
	func typeScreenMessage(type: TypeConversationOrContact) {
		switch type {
		case .contact:
			self.screenContact = true
			self.getContato()
			self.conversasListener?.remove()
		case .conversation:
			self.screenContact = false
			self.addListenerRecuperarConversa()
			self.homeView?.reloadCollectionView()
		}
	}
}

extension HomeViewController: ContatoProtocol {
	
	func alertStateError(titulo: String, message: String) {
		self.alert?.getAlert(titulo: titulo, mensagem: message)
	}
	
	func successContato() {
		alert?.getAlert(titulo: "Ebaaa", mensagem: "Cadastrado com sucesso", completion: {
			self.getContato()
		})
	}
}
