//
//  NavigationControllerViewController.swift
//  AVFoudationMusicAndVideo
//
//  Created by Artemiy Zuzin on 02.11.2021.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [MusicViewController()]
    }
}
