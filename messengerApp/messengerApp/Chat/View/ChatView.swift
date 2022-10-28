//
//  ChatView.swift
//  messengerApp
//
//  Created by Ramon Queiroz dos Santos on 27/10/22.
//

import UIKit
import AVFoundation

protocol ChatViewProtocol: AnyObject {
	func actionPushMessage()
}

class ChatView: UIView {
	
	weak  private var delegate:ChatViewProtocol?
	
	public func delegate(delegate: ChatViewProtocol?){
		self.delegate = delegate
	}
	
	var bottomContraint:NSLayoutConstraint?
	var player:AVAudioPlayer?
	
	lazy var chatNavView: ChatNavView = {
		let view = ChatNavView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	lazy var messageInputView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		return view
	}()
	
	lazy var messagemBar: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = CustomColor.appLight
		view.layer.cornerRadius = 20
		return view
	}()
	
	lazy var sendBtn: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(named: "send"), for: .normal)
		button.backgroundColor = CustomColor.appPink
		button.layer.cornerRadius = 22.5
		button.layer.shadowColor = CustomColor.appLight.cgColor
		button.layer.shadowRadius = 10
		button.layer.shadowOffset = CGSize(width: 0, height: 5)
		button.layer.shadowOpacity = 0.3
		button.addTarget(self, action: #selector(sendBtnPressed), for: .touchUpInside)
		return button
	}()
	
	lazy var inputMessageTextField: UITextField = {
		let tf = UITextField()
		tf.delegate = self
		tf.translatesAutoresizingMaskIntoConstraints = false
		tf.placeholder = "mensagem"
		tf.font = UIFont(name: CustomFont.poppinsSemiBold, size: 14)
		tf.textColor = .darkGray
		return tf
	}()
	
	lazy var tableView: UITableView = {
		let tb = UITableView()
		tb.translatesAutoresizingMaskIntoConstraints = false
		tb.register(IncomingTextMessageTableViewCell.self, forCellReuseIdentifier: IncomingTextMessageTableViewCell.identifier)
		tb.register(OutgoingTextMessageTableViewCell.self, forCellReuseIdentifier: OutgoingTextMessageTableViewCell.identifier)
		tb.backgroundColor = .clear
		tb.transform = CGAffineTransform(scaleX: 1, y: 1)
		tb.separatorStyle = .none
		tb.tableFooterView = UIView()
		return tb
	}()
	
	public func configTablewView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource){
		tableView.delegate = delegate
		tableView.dataSource = dataSource
	}
	
	public func reloadTableView(){
		tableView.reloadData()
	}
	
	func configChatNavView(controller: ChatViewController){
		chatNavView.controller = controller
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		configSuperView()
		setupConstraints()
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  
  self.inputMessageTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
  
  self.bottomContraint = NSLayoutConstraint(item: self.messageInputView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
  
  self.addConstraint(bottomContraint ?? NSLayoutConstraint())
  self.sendBtn.isEnabled = false
  self.sendBtn.layer.opacity = 0.4
  self.sendBtn.transform = .init(scaleX: 0.8, y: 0.8)
  self.inputMessageTextField.becomeFirstResponder()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc func sendBtnPressed(){
		self.sendBtn.touchAnimation(s: self.sendBtn)
		self.playSound()
		self.delegate?.actionPushMessage()
		self.startPushMessage()
	}
	
	func playSound() {
		 guard let url = Bundle.main.url(forResource: "send", withExtension: "wav") else { return }
		 do {
			  try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
			  try AVAudioSession.sharedInstance().setActive(true)
			  self.player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
			  guard let player = self.player else { return }
			  player.play()
		 } catch let error {
			  print(error.localizedDescription)
		 }
	}
	
	public func startPushMessage(){
		self.inputMessageTextField.text = ""
		self.sendBtn.isEnabled = false
		self.sendBtn.layer.opacity = 0.4
		self.sendBtn.transform = .init(scaleX: 0.8, y: 0.8)
	}
	
	private func configSuperView(){
		addSubview(chatNavView)
		addSubview(tableView)
		addSubview(messageInputView)
		messageInputView.addSubview(messagemBar)
		messagemBar.addSubview(sendBtn)
		messagemBar.addSubview(inputMessageTextField)
	}
	
	private func setupConstraints(){
		NSLayoutConstraint.activate([
		chatNavView.topAnchor.constraint(equalTo: topAnchor),
		chatNavView.leadingAnchor.constraint(equalTo: leadingAnchor),
		chatNavView.trailingAnchor.constraint(equalTo: trailingAnchor),
		chatNavView.heightAnchor.constraint(equalToConstant: 140),
		
		tableView.topAnchor.constraint(equalTo: chatNavView.bottomAnchor),
		tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
		tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
		tableView.bottomAnchor.constraint(equalTo: messageInputView.topAnchor),
		
		messageInputView.bottomAnchor.constraint(equalTo: bottomAnchor),
		messageInputView.leadingAnchor.constraint(equalTo: leadingAnchor),
		messageInputView.trailingAnchor.constraint(equalTo: trailingAnchor),
		messageInputView.heightAnchor.constraint(equalToConstant: 80),
		
		messagemBar.leadingAnchor.constraint(equalTo: messageInputView.leadingAnchor, constant: 20),
		messagemBar.trailingAnchor.constraint(equalTo: messageInputView.trailingAnchor, constant: -20),
		messagemBar.heightAnchor.constraint(equalToConstant: 55),
		messagemBar.centerYAnchor.constraint(equalTo: messageInputView.centerYAnchor),
		
		sendBtn.trailingAnchor.constraint(equalTo: messagemBar.trailingAnchor),
		sendBtn.widthAnchor.constraint(equalToConstant: 55),
		sendBtn.topAnchor.constraint(equalTo: messagemBar.topAnchor, constant: 1),
		sendBtn.bottomAnchor.constraint(equalTo: messagemBar.bottomAnchor, constant: -1),
		
		inputMessageTextField.leadingAnchor.constraint(equalTo: messagemBar.leadingAnchor, constant: 20),
		inputMessageTextField.trailingAnchor.constraint(equalTo: sendBtn.leadingAnchor, constant: -5),
		inputMessageTextField.heightAnchor.constraint(equalToConstant: 45),
		inputMessageTextField.centerYAnchor.constraint(equalTo: messagemBar.centerYAnchor)
		
		])
	}
	
	@objc func handleKeyboardNotification(notification: NSNotification){

		 if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
			  let keyboardRectangle = keyboardFrame.cgRectValue
			  let keyboardHeight = keyboardRectangle.height

			  let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification

			  self.bottomContraint?.constant = isKeyboardShowing ? -keyboardHeight : 0

			  self.tableView.center.y = isKeyboardShowing ? self.tableView.center.y-keyboardHeight : self.tableView.center.y+keyboardHeight

			  UIView.animate(withDuration:0.1, delay: 0 , options: .curveEaseOut , animations: {
					self.layoutIfNeeded()
			  } , completion: {(completed) in
					//Config!!!!!
			  })
		 }
	}
	
}

extension ChatView:UITextFieldDelegate{
	 
	 //MARK:- Animating
	 @objc func textFieldDidChange(_ textField: UITextField) {
		  if self.inputMessageTextField.text == ""{
				UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
					 self.sendBtn.isEnabled = false
					 self.sendBtn.layer.opacity = 0.4
					 self.sendBtn.transform = .init(scaleX: 0.8, y: 0.8)
				}, completion: { _ in
				})
		  }
		  else {
				UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
					 self.sendBtn.isEnabled = true
					 self.sendBtn.layer.opacity = 1
					 self.sendBtn.transform = .identity
				}, completion: { _ in
				})
		  }
	 }
	 
}
