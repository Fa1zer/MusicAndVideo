//
//  ViewController.swift
//  AVFoundation_Audio
//
//  Created by Niki Pavlove on 18.02.2021.
//

import UIKit
import AVFoundation
import AVKit

class MusicViewController: UIViewController {
    
    private var name: String? {
        didSet {
            do {
                player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:
                                                                    Bundle.main.path(forResource: name,
                                                                                     ofType: "mp3")!))
                player.prepareToPlay()
                
                nameLabel.text = name
            } catch {
                print(error)
            }
        }
    }
    
    private var player = AVAudioPlayer()
    
    private let cellid = "video"
    
    private let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let stopButton: UIButton = {
        let button = UIButton()
        
        button.setBackgroundImage(UIImage(systemName: "square.fill"), for: .normal)
        button.addTarget(nil, action: #selector(stopButtonTapped), for: .touchUpInside)
        button.tintColor = .black
        
        return button
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        
        button.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        button.addTarget(nil, action: #selector(playButtonTapped), for: .touchUpInside)
        button.tintColor = .black
        
        return button
    }()
    
    private let pauseButton: UIButton = {
        let button = UIButton()
        
        button.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        button.addTarget(nil, action: #selector(pauseButtonTapped), for: .touchUpInside)
        button.tintColor = .black
        
        return button
    }()
    
    private let nextSongButton: UIButton = {
        let button = UIButton()
        
        button.setBackgroundImage(UIImage(systemName: "arrow.right.circle.fill"), for: .normal)
        button.addTarget(nil, action: #selector(nextSongButtonTapped), for: .touchUpInside)
        button.tintColor = .black
        
        return button
    }()
    
    private let previousSongButton: UIButton = {
        let button = UIButton()
        
        button.setBackgroundImage(UIImage(systemName: "arrow.left.circle.fill"), for: .normal)
        button.addTarget(nil, action: #selector(previousSongButtonTapped), for: .touchUpInside)
        button.tintColor = .black
        
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let stackView: UIStackView = {
       let view = UIStackView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 15
        view.distribution = .fillEqually
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        name = music.first
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(VideoTableViewCell.self, forCellReuseIdentifier: cellid)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        view.addSubview(nameLabel)
        view.addSubview(tableView)
        
        stackView.addArrangedSubview(previousSongButton)
        stackView.addArrangedSubview(pauseButton)
        stackView.addArrangedSubview(playButton)
        stackView.addArrangedSubview(stopButton)
        stackView.addArrangedSubview(nextSongButton)
        
        let constraints = [stackView.bottomAnchor.constraint(equalTo:
                                                                view.safeAreaLayoutGuide.bottomAnchor,
                                                            constant: -40),
                           stackView.centerXAnchor.constraint(equalTo:
                                                            view.centerXAnchor),
                           stackView.widthAnchor.constraint(equalTo: stackView.heightAnchor,
                                                            multiplier: 5, constant: 45),
                           stackView.heightAnchor.constraint(equalToConstant: 50),
        
                           nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                           nameLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor,
                                                             constant: -15),
        
                           tableView.trailingAnchor.constraint(equalTo:
                                                            view.safeAreaLayoutGuide.trailingAnchor),
                           tableView.leadingAnchor.constraint(equalTo:
                                                            view.safeAreaLayoutGuide.leadingAnchor),
                           tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                           tableView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor,
                                                             constant: -15)]
        
        NSLayoutConstraint.activate(constraints)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "Music"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Voice", style: .done, target: self,
                                                            action: #selector(voiceButtonTapped))
    }

    @objc private func playButtonTapped() {
        player.play()
    }
    
    @objc private func pauseButtonTapped() {
        if player.isPlaying {
            player.pause()
        } else {
            print("Already stoped!")
        }
    }
    
    @objc private func stopButtonTapped() {
        player.stop()
        player.currentTime = 0
    }
    
    @objc private func nextSongButtonTapped() {
        for i in 0 ..< music.count {
            if name == music[i] && i != 4 {
                name = music[i + 1]
                
                return
            }
        }
    }
    
    @objc private func previousSongButtonTapped() {
        for i in 0 ..< music.count {
            if name == music[i] && i != 0 {
                name = music[i - 1]
        
                return
            }
        }
    }
    
    @objc private func voiceButtonTapped() {
        navigationController?.pushViewController(UIViewController(), animated: true)
    }
}

extension MusicViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: VideoTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellid,
                                          for: indexPath) as! VideoTableViewCell
        
        cell.imagePreview = UIImageView(image: UIImage(named: videos[indexPath.row].image))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let player = AVPlayer(url: URL(string: videos[indexPath.row].videoURL)!)

        let controller = AVPlayerViewController()
        controller.player = player

        present(controller, animated: true) {
            player.play()
        }
    }
}

