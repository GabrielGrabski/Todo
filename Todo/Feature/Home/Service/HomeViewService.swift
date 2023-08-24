//
//  HomeViewService.swift
//  Todo
//
//  Created by Gabriel Grabski on 17/08/23.
//

import Foundation
import FirebaseFirestore

class HomeViewService {
    
    private var database = Firestore.firestore()
    
    public func fetchTasks(completion: @escaping ([Task]) -> ()) {
        database
            .collection("tasks")
            .getDocuments { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let documents = snapshot?.documents else { print("no documents"); return }
                
                let tasks = documents.map { snapshot in
                    let data = snapshot.data()
                    let documentID = snapshot.documentID
                    let id = data["id"] as? String ?? ""
                    let title = data["Title"] as? String ?? ""
                    let desc = data["Description"] as? String ?? ""
                    return Task(documentID: documentID, id: id, title: title, description: desc)
                }
                
                completion(tasks)
            }
    }
    
    public func deleteTask(_ id: String) {
        database.collection("tasks").document(id).delete()
    }
}
