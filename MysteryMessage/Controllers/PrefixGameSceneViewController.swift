//
//  PrefixGameSceneViewController.swift
//  MysteryMessage
//
//  Created by Arif Luthfiansyah on 15/06/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import AVFoundation
import Foundation
import UIKit

public protocol PrefixGameSceneViewControllerDelegate: class {
    func prefixGameScene(_ viewController: PrefixGameSceneViewController, didPlay new: Bool)
}

public class PrefixGameSceneViewController: UIViewController {
    
    lazy var closeImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "xmark.circle.fill")
        imageView.tintColor = .white
        imageView.isUserInteractionEnabled = true
        imageView.gestureRecognizers = [ UITapGestureRecognizer(target: self, action: #selector(self.onCloseImageViewTapped(_:))) ]
        return imageView
    }()
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    lazy var informationContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    lazy var playGameStoryContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var gameStoryPosterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "SamplePosterGameStory")
        return imageView
    }()
    lazy var gameStoryTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.text = "Story"
        return label
    }()
    lazy var playGameStoryButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        button.setTitle("PLAY IT NOW", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .systemGray5
        button.addTarget(self, action: #selector(self.onPlayGameStoryButtonTouchedUpInside(_:)), for: .touchUpInside)
        return button
    }()
    
    public weak var delegate: PrefixGameSceneViewControllerDelegate?
    private var audioPlayer: AVAudioPlayer?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupViewWillAppear()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setupViewWillDisappear()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.setupViewDidDisappear()
    }
    
    @objc private func onCloseImageViewTapped(_ sender: UIImageView) {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
    
    @objc private func onPlayGameStoryButtonTouchedUpInside(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: {
                self.delegate?.prefixGameScene(self, didPlay: true)
            })
        }
    }
    
    private func setupViewDidLoad() {
        self.implementComponentView()
        let gif = UIImage.gifImageWithName("MysteryHackGif")
        let playGameStoryButtonCorner = self.playGameStoryButton.frame.height / 2
        self.playGameStoryButton.layer.cornerRadius = playGameStoryButtonCorner
        self.posterImageView.image = gif
        self.descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc augue ipsum, gravida sed molestie at, porttitor ac nunc. Donec aliquet maximus consectetur. Praesent eget hendrerit nisl. Praesent euismod mi quis erat fermentum, at tempus metus rhoncus. Praesent viverra turpis hendrerit, porta nunc in, placerat odio. Fusce eget tortor dolor. Maecenas id venenatis massa. Etiam leo velit, dictum et ornare non, consequat id mi. Nullam ac rhoncus arcu, vel convallis libero. Etiam scelerisque suscipit nisl at dictum. Duis libero sem, elementum volutpat neque sed, accumsan tincidunt lacus. Aliquam finibus orci quis eros molestie, in faucibus nisl fermentum. Morbi ultricies, neque ut dapibus dignissim, felis nulla iaculis quam, at vulputate nulla ex ac tellus. Aliquam posuere magna eget metus fringilla sagittis.\n\nAenean semper nulla sed leo maximus euismod ac id turpis. Nam eu mi tellus. Mauris rutrum, ex nec vestibulum pharetra, ex erat euismod risus, in tristique justo eros et justo. Nunc venenatis, purus finibus facilisis malesuada, urna augue ullamcorper elit, rhoncus mollis velit sem quis massa. In vehicula dolor quis nisi iaculis tristique. Proin et libero sit amet orci faucibus consectetur in eu dui. Vestibulum ipsum nulla, eleifend et mi nec, rhoncus viverra nisl. Sed facilisis tempus arcu, a tincidunt turpis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas."
        guard let bundle = Bundle.main.path(forResource: "Decisions", ofType: "mp3") else { return }
        let url = URL(fileURLWithPath: bundle)
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: url)
            self.audioPlayer?.prepareToPlay()
            self.audioPlayer?.play()
        } catch let error {
            debugPrint("PrefixGameSceneViewController: \(error.localizedDescription)")
        }
    }
    
    private func setupViewWillAppear() {
        self.navigationItem.title = "Stories"
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupViewWillDisappear() {
    }
    
    private func setupViewDidDisappear() {
        if let audioPlayer = self.audioPlayer, audioPlayer.isPlaying {
            audioPlayer.stop()
        }
    }
    
    private func implementComponentView() {
        self.view.layoutIfNeeded()
        self.view.backgroundColor = .white
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        self.contentView.addSubview(self.posterImageView)
        self.contentView.addSubview(self.closeImageView)
        self.contentView.addSubview(self.informationContainerView)
        self.informationContainerView.addSubview(self.playGameStoryContainerView)
        self.informationContainerView.addSubview(self.descriptionLabel)
        self.playGameStoryContainerView.addSubview(self.gameStoryPosterImageView)
        self.playGameStoryContainerView.addSubview(self.gameStoryTitleLabel)
        self.playGameStoryContainerView.addSubview(self.playGameStoryButton)
        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.closeImageView.widthAnchor.constraint(equalToConstant: 24),
            self.closeImageView.heightAnchor.constraint(equalToConstant: 24),
            self.closeImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.closeImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            self.posterImageView.heightAnchor.constraint(equalToConstant: self.view.frame.size.height / 2),
            self.posterImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.posterImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.posterImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.informationContainerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.informationContainerView.topAnchor.constraint(equalTo: self.posterImageView.bottomAnchor, constant: 16),
            self.informationContainerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.informationContainerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            self.playGameStoryContainerView.leadingAnchor.constraint(equalTo: self.informationContainerView.leadingAnchor),
            self.playGameStoryContainerView.topAnchor.constraint(equalTo: self.informationContainerView.topAnchor),
            self.playGameStoryContainerView.trailingAnchor.constraint(equalTo: self.informationContainerView.trailingAnchor),
            self.playGameStoryContainerView.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor),
            self.gameStoryPosterImageView.widthAnchor.constraint(equalToConstant: 48),
            self.gameStoryPosterImageView.heightAnchor.constraint(equalToConstant: 48),
            self.gameStoryPosterImageView.leadingAnchor.constraint(equalTo: self.playGameStoryContainerView.leadingAnchor),
            self.gameStoryPosterImageView.topAnchor.constraint(equalTo: self.playGameStoryContainerView.topAnchor),
            self.gameStoryPosterImageView.bottomAnchor.constraint(equalTo: self.playGameStoryContainerView.bottomAnchor, constant: -16),
            self.gameStoryTitleLabel.leadingAnchor.constraint(equalTo: self.gameStoryPosterImageView.trailingAnchor, constant: 16),
            self.gameStoryTitleLabel.topAnchor.constraint(equalTo: self.gameStoryPosterImageView.topAnchor),
            self.gameStoryTitleLabel.bottomAnchor.constraint(equalTo: self.gameStoryPosterImageView.bottomAnchor),
            self.playGameStoryButton.centerYAnchor.constraint(equalTo: self.gameStoryPosterImageView.centerYAnchor),
            self.playGameStoryButton.widthAnchor.constraint(equalToConstant: ("PLAY IT NOW".size(withAttributes: [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13, weight: .bold) ]).width + 8 + 8)),
            self.playGameStoryButton.leadingAnchor.constraint(equalTo: self.gameStoryTitleLabel.trailingAnchor, constant: 16),
            self.playGameStoryButton.trailingAnchor.constraint(equalTo: self.playGameStoryContainerView.trailingAnchor),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.informationContainerView.leadingAnchor),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.informationContainerView.trailingAnchor),
            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.informationContainerView.bottomAnchor)
        ])
        for constraint in self.scrollView.constraints {
            if constraint.firstAttribute == .height {
                constraint.priority = .defaultLow
                break
            }
        }
        self.view.layoutIfNeeded()
    }
}
