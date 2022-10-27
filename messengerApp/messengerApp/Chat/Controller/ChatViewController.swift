//
//  ChatViewController.swift
//  messengerApp
//
//  Created by Ramon Queiroz dos Santos on 27/10/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
	
	var chatView: ChatView?
	
	override func loadView() {
		self.chatView = ChatView()
		view = chatView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	@objc func tappedBackBtn(){
		self.navigationController?.popToRootViewController(animated: true)
	}


}
