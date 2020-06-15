//
//  GameStoriesCollectionViewCell.swift
//  MysteryMessage
//
//  Created by Arif Luthfiansyah on 15/06/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

public class GameStoriesCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: GameStoriesCollectionViewCell.self)
    static let height = CGFloat(264)
    
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    lazy var informationContainerVisualEffectView: UIVisualEffectView = {
        let view = UIVisualEffectView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.effect = UIBlurEffect(style: .light)
        return view
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
        return label
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.implementComponentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func fill(with gameStory: GameStory) {
        self.titleLabel.text = gameStory.title
        self.descriptionLabel.text = gameStory.description
        self.posterImageView.image = gameStory.poster
    }
    
    private func implementComponentView() {
        self.contentView.layoutIfNeeded()
        self.contentView.addSubview(self.posterImageView)
        self.contentView.addSubview(self.informationContainerVisualEffectView)
        self.informationContainerVisualEffectView.contentView.addSubview(self.titleLabel)
        self.informationContainerVisualEffectView.contentView.addSubview(self.descriptionLabel)
        NSLayoutConstraint.activate([
            self.posterImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.posterImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.posterImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.posterImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.informationContainerVisualEffectView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.informationContainerVisualEffectView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.informationContainerVisualEffectView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.informationContainerVisualEffectView.leadingAnchor, constant: 16),
            self.titleLabel.topAnchor.constraint(equalTo: self.informationContainerVisualEffectView.topAnchor, constant: 16),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.informationContainerVisualEffectView.trailingAnchor, constant: -16),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -8),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.informationContainerVisualEffectView.leadingAnchor, constant: 16),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.informationContainerVisualEffectView.trailingAnchor, constant: -16),
            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.informationContainerVisualEffectView.bottomAnchor, constant: -16)
        ])
    }
}
