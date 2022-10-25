//
//  HomeViewController.swift
//  messengerApp
//
//  Created by Ramon Queiroz dos Santos on 25/10/22.
//

import UIKit

class HomeViewController: UIViewController {
	
	var homeView: HomeView?
	
	override func loadView() {
		homeView = HomeView()
		view = homeView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		 navigationController?.navigationBar.isHidden = true
		 view.backgroundColor = CustomColor.appLight
    }
	

}
