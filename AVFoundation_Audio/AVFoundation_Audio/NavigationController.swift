//
//  NavigationControllerViewController.swift
//  AVFoundation_Audio
//
//  Created by Artemiy Zuzin on 23.10.2021.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [MusicViewController()]
    }
}
