//
//  DatabaseManager.swift
//  MovieTime
//
//  Created by Evgenii Kolgin on 01.08.2021.
//

import Foundation
import FirebaseFirestore

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Firestore.firestore().collection("Watchlist")
    
    func addDocument(_ item: Movie) {

       let document = database.addDocument(data: ["id" : item.id, "title" : item.title, "year" : item.year, "image" : item.image, "imDbRating" : item.imDbRating ?? ""])
        UserDefaults.standard.setValue(document.documentID, forKey: item.id)
    }
    
    private func deleteDocument(with id: String) {
        
        database.document(id).delete { error in
            if let error = error {
                print("Error removing document: \(error)")
            } else {
                print("Document successfully removed!")
            }
        }
        UserDefaults.standard.removeObject(forKey: id)
    }
    
    func getDocuments(completion: @escaping ([Movie]) -> Void) {
        
        var movies = [Movie]()
        database.getDocuments { snapshot, error in
            guard let docs = snapshot?.documents, error == nil else { return }
            for doc in docs {
                let movie = doc.data()
                
                guard let id = movie["id"] as? String else { return }
                guard let title = movie["title"] as? String else { return }
                guard let year = movie["year"] as? String else { return }
                guard let image = movie["image"] as? String else { return }
                guard let imDbRating = movie["imDbRating"] as? String else { return }
                let data = Movie(id: id, rank: nil, title: title, year: year, image: image, crew: nil, imDbRating: imDbRating)
                movies.append(data)
                UserDefaults.standard.setValue(doc.documentID, forKey: id)
            }
            completion(movies)
        }
    }
    
    func deleteItemByMovieID(item: Movie) {
        guard let docID = UserDefaults.standard.string(forKey: item.id) else { return }
        deleteDocument(with: docID)
        UserDefaults.standard.removeObject(forKey: item.id)
    }
    
    func checkIsMovieInTheList(id: String) -> Bool {
        if UserDefaults.standard.object(forKey: id) != nil {
            return true
        } else {
            return false
        }
    }
}
