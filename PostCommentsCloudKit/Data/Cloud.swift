//
//  Cloud.swift
//  PostCommentsCloudKit
//
//  Created by Zewu Chen on 15/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import CloudKit

enum Record {
    case post
    case comment

    var record: String {
        switch self {
            case .post: return "Post"
            case .comment: return "Comment"
        }
    }
}

final class Cloud {

    let container: CKContainer
    let publicDB: CKDatabase
    let privateDB: CKDatabase
    let sharedDB: CKDatabase
    var predicate: NSPredicate

    private init() {
        self.container = CKContainer.default()
        self.publicDB = container.publicCloudDatabase
        self.privateDB = container.privateCloudDatabase
        self.sharedDB = container.sharedCloudDatabase
        self.predicate = NSPredicate(value: true)
    }

    static let shared = Cloud()

    // MARK: Testes
    public func createPost() {
        let post = CKRecord(recordType: "Post")

        post.setValue("Post", forKey: "name")
        post.setValue("Uma descrição", forKey: "description")

        cloudSave(record: post, database: publicDB)
    }

    private func cloudSave(record: CKRecord, database: CKDatabase) {
        self.publicDB.save(record) { (record, error) in
            if let err = error {
                fatalError(err.localizedDescription)
            } else {
                print("Salvo com Sucesso")
            }
        }
    }

    public func fetchPost(type: Record, completionHandler: @escaping ([CKRecord]) -> Void) {
        self.predicate = NSPredicate(format: "name == 'Post'")
        let query = CKQuery(recordType: type.record, predicate: predicate)

        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let records = records {
                completionHandler(records)
            } else {
                completionHandler([])
            }
        }
    }

//    func fetchDataUnico() {
//        let predicateAtualizar = NSPredicate(format: "Nome == 'Catarina'")
//        let query = CKQuery(recordType: "Aluno", predicate: predicateAtualizar)
//
//        privateDB.perform(query, inZoneWith: nil) { (records, error) in
//            if let records = records {
//                print(records)
//            }
//        }
//    }

//    func fetchDataList() {
//        let predicateAtualizar = NSPredicate(format: "Nome == 'Catarina'")
//        let query = CKQuery(recordType: "Aluno", predicate: predicateAtualizar)
//    var fieldValueReferences = [CKRecord.Reference]()
//        privateDB.perform(query, inZoneWith: nil) { (records, error) in
//            if let records = records {
//                print(records)
//            }
//        }
//    }

//    func atualizarDado() {
//        let predicateAtualizar = NSPredicate(format: "Nome == 'Enes'")
//        let query = CKQuery(recordType: "Aluno", predicate: predicateAtualizar)
//
//        let predicateEscola = NSPredicate(format: "Nome == 'Teste'")
//        let query2 = CKQuery(recordType: "Escola", predicate: predicateEscola)
//
//        var recordReference = CKRecord(recordType: "Escola")
//
//        privateDB.perform(query2, inZoneWith: nil) { (records, error) in
//            if let records = records {
//                recordReference = records.first!
//            }
//        }
//
//        privateDB.perform(query, inZoneWith: nil) { (records, error) in
//            if let err = error {
//                fatalError(err.localizedDescription)
//            } else {
//                let alunoAtual = records?.first
//                alunoAtual?.setValue("Catarina", forKey: "Nome")
//                let reference = CKRecord.Reference(recordID: recordReference.recordID, action: .none)
//                alunoAtual?.setValue(reference, forKey: "Escola")
////                recordAircraft["fieldValues"] = fieldValueReferences as CKRecordValue
//                guard let alunoAtualSafe = alunoAtual else { return }
//                self.salvarAluno(aluno: alunoAtualSafe)
//            }
//        }
//    }

//    func deleteAluno(aluno: CKRecord) {
//        let recordID = aluno.recordID
//        privateDB.delete(withRecordID: recordID) { (recordID, error) in
//            if let err = error {
//                fatalError(err.localizedDescription)
//            } else {
//                print("Record \(recordID!) foi deletado com sucesso")
//            }
//        }
//    }

//    func deleteGenerico() {
//        let predicate = NSPredicate(format: "Nome == 'Catarina'")
//        let query = CKQuery(recordType: "Aluno", predicate: predicate)
//
//        privateDB.perform(query, inZoneWith: nil) { (record, error) in
//            if let err = error {
//                fatalError(err.localizedDescription)
//            } else {
//                let recordID = record?.first?.recordID
//                self.privateDB.delete(withRecordID: recordID!) { (recordID, error) in
//                    if let err = error {
//                        fatalError(err.localizedDescription)
//                    } else {
//                        print("Record \(recordID!) foi deletado com sucesso")
//                    }
//                }
//            }
//        }
//    }

}
