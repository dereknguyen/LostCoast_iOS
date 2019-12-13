//
//  FirebaseService.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/17/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

enum FirebaseCollectionReference: String {
    case users
}

class FirebaseServiceAPI {
    
    private init() {}
    
    /// Signleton instance
    static var shared = FirebaseServiceAPI()
    
    /// Configured Firestore Database
    private lazy var database: Firestore = {
        let database = Firestore.firestore()
        database.settings.areTimestampsInSnapshotsEnabled = true
        return database
    }()
    
    var isLoggedIn: Bool = {
        return Auth.auth().currentUser != nil
    }()
    
    /// Run Firebase configure method for initializing Firebase when app did launched.
    func configure() {
        FirebaseApp.configure()
    }
    
    /// Get Firestore collection reference.
    ///
    /// - Parameter collectionReference: Collection's path name.
    /// - Returns: Firestore reference to the specified collection.
    func reference(to collectionReference: FirebaseCollectionReference) -> CollectionReference {
        return self.database.collection(collectionReference.rawValue)
    }
    
    /// Login user with email and password.
    ///
    /// - Parameters:
    ///     - email: User's registered email.
    ///     - password: User's account password.
    ///     - completion: Completion handler
    ///     - error: Login error if any.
    func login(email: String, password: String, completion: @escaping (_ error: Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) {
            (authData, authError) in
            
            completion(authError)
        }
    }
    
    /// Sign up user with Firebase using email and password.
    ///
    /// - Parameters:
    ///     - email: User's email.
    ///     - password: User's password
    ///     - completion: Completion handler
    ///     - error: Sign up error if any.
    func signup(email: String, password: String, completion: @escaping (_ error: Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {
            (authData, authError) in
            
            if let error = authError {
                completion(error)
                return
            }
            else {
                completion(nil)
            }
        }
    }
    
    /// Log out current user.
    ///
    /// - Parameters:
    ///     - completion: Completion handler.
    ///     - error: Log out error if any.
    func logout(completion: @escaping (_ error: Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error{
            completion(error)
        }
    }
    
    /// Grab authenticated user's UID
    ///
    /// - Returns: User's UID string
    func getUID() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    /// Grab authenticated user's email
    ///
    /// - Returns: User's email associate with Firebase Account
    func getEmail() -> String? {
        return Auth.auth().currentUser?.email
    }
}

