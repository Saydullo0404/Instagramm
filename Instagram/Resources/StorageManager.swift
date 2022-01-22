//
//  StorageManager.swift
//  Instagram
//
//  Created by 1 on 08/01/22.
//

import FirebaseStorage
import Foundation

public class StorageManager {
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    enum IGStorageManagerError: Error {
        case failedToDowload
        
    }
    
    // MARK: - Public
    
    public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL,Error>)-> Void) {
        
    }
    private func dowloadImage(with reference: String, completion: @escaping(Result<URL,IGStorageManagerError>) -> Void) {
        bucket.child(reference).downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(.failedToDowload))
                return
            }
            completion(.success(url))
        }
    }
}





