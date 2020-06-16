//
//  OptionsView.swift
//  MysteryMessage
//
//  Created by Muhammad Nobel Shidqi on 15/06/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

protocol OptionsViewDelegate {
    func didSelectTextFieldForOpen()
    func didSelectTextFieldForDismiss()
}

class OptionsView: UIView {
    
    var delegate: OptionsViewDelegate?
    private let cameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "camera.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.lightGray), for: .normal)
        button.setSize(width: 35, height: 35)
        return button
    }()
    private let storeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "australsign.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.lightGray), for: .normal)
        button.setSize(width: 35, height: 35)
        return button
    }()
    var textFieldIsOpened: Bool = false
    private lazy var textFieldView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat.zero, height: CGFloat.zero))
        view.configureRoundedCorners(for: [.all], withRadius: 18)
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.8
        view.backgroundColor = .white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(textFieldViewHandler))
        view.addGestureRecognizer(tapGesture)
        
        let sendButton = UIButton(type: .system)
        sendButton.setBackgroundImage(UIImage(systemName: "arrow.up.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemBlue), for: .normal)
        
        view.addSubview(sendButton)
        sendButton.setAnchor(right: view.rightAnchor, paddingRight: 5)
        sendButton.setSize(width: 30, height: 30)
        sendButton.setCenterYAnchor(in: view)
        
        let label = UILabel()
        label.text = "uMessage"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        view.addSubview(label)
        label.setAnchor(top: view.topAnchor, right: sendButton.leftAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, paddingTop: 8,  paddingRight: 8, paddingBottom: 8, paddingLeft: 12)
        
        return view
    }()
    lazy var optionsStack: UIStackView = {
        let sv = UIStackView()
        sv.alignment = .fill
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 10
        return sv
    }()
    var optionButtons: [OptionButton] = [OptionButton]() {
        didSet {
            optionsStack.arrangedSubviews.forEach { (sv) in
                sv.removeFromSuperview()
            }
            optionButtons.forEach { (btn) in
                btn.addTarget(self, action: #selector(optionButtonHandler), for: .touchUpInside)
                optionsStack.addArrangedSubview(btn)
            }
        }
    }
    

    
    // MARK: - Initialier
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        
        self.addSubview(cameraButton)
        cameraButton.setAnchor(top: self.topAnchor, left: self.leftAnchor, paddingTop: 10, paddingLeft: 15)
        
        self.addSubview(storeButton)
        storeButton.setAnchor(top: self.topAnchor, left: cameraButton.rightAnchor, paddingTop: 10, paddingLeft: 15)
        
        self.addSubview(textFieldView)
        textFieldView.setAnchor(top: self.topAnchor, right: self.rightAnchor, left: storeButton.rightAnchor, paddingTop: 10, paddingRight: 15, paddingLeft: 15)
        textFieldView.setSize(height: 35)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Targets
    @objc private func textFieldViewHandler() {
        if textFieldIsOpened {
            dismissView()
        } else {
            configureOptionButtons()
            delegate?.didSelectTextFieldForOpen()
        }
    }
    
    @objc private func optionButtonHandler() {
        dismissView()
    }
    
    // MARK: - Helper
    private func configureOptionButtons() {
        self.addSubview(optionsStack)
        optionsStack.setAnchor(top: textFieldView.bottomAnchor, right: self.rightAnchor, bottom: self.bottomAnchor, left: self.leftAnchor, paddingTop: 15, paddingRight: 10, paddingBottom: 15, paddingLeft: 10)
    }
    
    private func dismissView() {
        delegate?.didSelectTextFieldForDismiss()
        optionsStack.removeFromSuperview()
        optionButtons = []
    }
}
