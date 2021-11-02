//
//  VideoTableViewCellTableViewCell.swift
//  AVFoudationMusicAndVideo
//
//  Created by Artemiy Zuzin on 02.11.2021.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imagePreview: UIImageView? {
        didSet {
            imagePreview!.contentMode = .scaleAspectFit
            imagePreview!.translatesAutoresizingMaskIntoConstraints = false
            
            insertSubview(imagePreview!, at: 1)

            let constraints = [imagePreview!.leadingAnchor.constraint(equalTo:
                                                                    safeAreaLayoutGuide.leadingAnchor),
                               imagePreview!.trailingAnchor.constraint(equalTo:
                                                                    safeAreaLayoutGuide.trailingAnchor),
                               imagePreview!.topAnchor.constraint(equalTo:
                                                                    safeAreaLayoutGuide.topAnchor),
                               imagePreview!.bottomAnchor.constraint(equalTo:
                                                                    safeAreaLayoutGuide.bottomAnchor),
                               imagePreview!.heightAnchor.constraint(equalTo:
                                                                        imagePreview!.widthAnchor)]
            
            NSLayoutConstraint.activate(constraints)
        }
    }
        
    private let playButton: UIButton = {
        let button = UIButton()
        
        button.tintColor = .white
        button.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private func setupViews() {
        insertSubview(playButton, at: 2)
        
        let constraints = [playButton.centerXAnchor.constraint(equalTo:
                                                                safeAreaLayoutGuide.centerXAnchor),
                           playButton.centerYAnchor.constraint(equalTo:
                                                                safeAreaLayoutGuide.centerYAnchor),
                           playButton.heightAnchor.constraint(equalTo: playButton.widthAnchor),
                           playButton.widthAnchor.constraint(equalToConstant: 80)]
        
        NSLayoutConstraint.activate(constraints)
    }
}
