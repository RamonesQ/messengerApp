//
//  HomeView.swift
//  messengerApp
//
//  Created by Ramon Queiroz dos Santos on 25/10/22.
//

import UIKit

class HomeView: UIView {
	
	lazy var navView: NavView = {
		let view = NavView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.showsVerticalScrollIndicator = false
		collectionView.backgroundColor = .clear
		collectionView.delaysContentTouches = false
		collectionView.register(LastMessageCollectionViewCell.self, forCellWithReuseIdentifier: LastMessageCollectionViewCell.identifier)
		collectionView.register(MessageDetailCollectionViewCell.self, forCellWithReuseIdentifier: MessageDetailCollectionViewCell.identifier)
		let layout = UICollectionViewFlowLayout.init()
		layout.scrollDirection = .vertical
		collectionView.setCollectionViewLayout(layout, animated: false)
		return collectionView
	}()
	
	public func delegateCollectionView(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource){
		self.collectionView.delegate = delegate
		self.collectionView.dataSource = dataSource
	}
	
	public func reloadCollectionView(){
		collectionView.reloadData()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configSuperView()
		setupConstraint()
	}
	
	private func configSuperView(){
		addSubview(navView)
		addSubview(collectionView)
	}
	
	private func setupConstraint(){
		NSLayoutConstraint.activate([
		
			navView.topAnchor.constraint(equalTo: topAnchor),
			navView.leadingAnchor.constraint(equalTo: leadingAnchor),
			navView.trailingAnchor.constraint(equalTo: trailingAnchor),
			navView.heightAnchor.constraint(equalToConstant: 140),
			
			collectionView.topAnchor.constraint(equalTo: navView.bottomAnchor),
			collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
			
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
