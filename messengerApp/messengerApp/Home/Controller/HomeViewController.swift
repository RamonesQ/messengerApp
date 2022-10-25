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
	
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return UICollectionViewCell()
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print(indexPath)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.frame.width, height: 100)
	}
}


extension HomeViewController: NavViewProtocol{
	
	func typeScreenMessage(type: TypeChatOrContact) {
		switch type {
		case .contact:
			self.screenContact = true
		case .chat:
			self.screenContact = false
		}
	}

}

