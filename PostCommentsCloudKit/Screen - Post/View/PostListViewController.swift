//
//  PostListViewController.swift
//  PostCommentsCloudKit
//
//  Created by Zewu Chen on 15/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class PostListViewController: UIViewController {

    let controller = PostLisController()

    override func viewDidLoad() {
        super.viewDidLoad()
        controller.delegate = self
//        controller.create()
        controller.fetch()
    }

}

extension PostListViewController: PostListControllerDelegate {
    func create() {
        controller.create()
    }
}
