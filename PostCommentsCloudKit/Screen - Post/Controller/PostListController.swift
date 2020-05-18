//
//  PostListController.swift
//  PostCommentsCloudKit
//
//  Created by Zewu Chen on 15/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import CloudKit

protocol PostListControllerDelegate: AnyObject {
    func create()
}

final class PostLisController {
    weak var delegate: PostListControllerDelegate?
    private var dataRecord: [CKRecord] = []
    private var dataModel: [PostModel] = []
    public init() { }

    public func create() {
        Cloud.shared.createPost()
    }

    public func fetch() {
        Cloud.shared.fetchPost(type: .post) { (records) in
            for record in records {
                if let name = record["name"] as? String, let description = record["description"] as? String {
                    let register = PostModel(name: name, description: description)
                    self.dataModel.append(register)
                }
                self.dataRecord = records
            }
        }
    }
}
