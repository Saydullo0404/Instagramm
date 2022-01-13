//
//  DatabaseManager.swift
//  Instagram
//
//  Created by 1 on 08/01/22.
//



import FirebaseDatabase

public class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    
    // MARK: - Public
    
    /// Check if username and email is available
    /// - Parameters
    ///  - email: String representing email
    ///  - username: String representing username
    
    public func canCreateNewUser(email: String, username: String, completion:@escaping (Bool) -> Void) {
        completion(true)
        
        
    }
    
    
    /// Inserts new user data to database
    /// - Parameters
    ///  - email: String representing email
    ///  - completion: Async callback for result if database entry succeded
    
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        let key = email.safeDatabaseKey()        
        database.child(key).setValue(["username": username]) { error, _ in
            if error == nil {
                // succeeded
                completion(true)
                return
            }
            else {
                // failed
                completion(false)
                return
            }
        }
    }
    
    //MARK: - Private
    
    
    
}
