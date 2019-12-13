//
//  LostCoastUserAPI.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/31/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import RealmSwift

enum UserFieldReference: String {
    case firstName
    case lastName
    case username
    case email
    case dob
    case uid
    case imageURL
    case image
}

enum APIError: Error {
    case nilSnapshot
}

class LostCoastUserAPI {
    
    private init() {}
    
    /// Singleton instance
    static var shared = LostCoastUserAPI()
    
    var realm = try! Realm()
    
    /// Authenticated Current User
    private var AUTH_CURRENT_USER: User? {
        return Auth.auth().currentUser
    }
    
    /// Users' collection reference
    private var USERS_REFERENCE: CollectionReference {
        return FirebaseServiceAPI.shared.reference(to: .users)
    }
    
    /// Reference to current user Firestore document.
    private var CURRENT_USER_REFERENCE: DocumentReference? {
        guard let uid = AUTH_CURRENT_USER?.uid else { return nil }
        return FirebaseServiceAPI.shared.reference(to: .users).document(uid)
    }
    
    /// Update User's edited profile field to Firebase.
    ///
    /// - Parameters:
    ///     - dataObject: The new data to be upload to Firebase.
    ///     - reference: The field's refence that need updating.
    ///     - completion: Completion callback when finished updating.
    ///     - error: The error while updating if any.
    func update<T>(_ reference: UserFieldReference, with data: T, completion: @escaping (_ error: Error?) -> Void) {
        let updateData = [reference.rawValue : data]
        
        CURRENT_USER_REFERENCE?.updateData(updateData) { (error) in
            completion(error)
        }
    }
    
    /// Retrieve current user's profile informations. Add a listener for potential changes.
    ///
    /// - Parameters:
    ///     - completion: Completion handler.
    ///     - profile: The retrieved profile information of the user.
    ///     - error: Retrieval error if any.
    func observeCurrentUser(completion: @escaping(_ profile: LostCoastUser?, _ error: Error?) -> Void) {
        CURRENT_USER_REFERENCE?.addSnapshotListener({ (snapshot, error) in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let snapshot = snapshot else {
                completion(nil, APIError.nilSnapshot)
                return
            }
            
            if let dictionary = snapshot.data() {
                let user = LostCoastUser.parse(dictionary: dictionary)
                print(dictionary)
                completion(user, nil)
            }
            else {
                completion(nil, APIError.nilSnapshot)
            }
        })
    }
    
    /// Upload Image to Firebase Storage. Completion closure return
    /// the download URL and error status.
    ///
    /// - Parameters:
    ///     - image: Data format of UIImage.
    ///     - completion: The resulting closure of the method return
    ///                   downloadURL or any error.
    ///     - downloadURL: *Part of completion closure.*
    ///                    The download URL of user's profile image.
    ///     - error: *Part of completion closure.*
    ///              Any resulting error during the upload process.
    func uploadImage(image: UIImage, completion: @escaping (_ downloadURL: String?, _ error: Error?) -> Void) {
        
        // TODO: CREATE ERROR CLASS FOR ERROR HANDLING
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let data = UIImagePNGRepresentation(image) else { return }
        /*--------------------------------------------------------------*/
        
        let fileName = "profile_images/" + uid + ".png"
        let imageStorageRef = Storage.storage().reference().child(fileName)
        
        imageStorageRef.putData(data, metadata: nil) { (metadata, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            imageStorageRef.downloadURL(completion: { (url, error) in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                if let downloadURL = url?.absoluteString { completion(downloadURL, nil) }
            })
        }
    }
    
    /// Check if the user create a profile already. The sign up process
    /// requires that the user sign up with Firebase Auth then create an account
    /// for Lost Coast
    ///
    /// - Parameters:
    ///     - completion: The completion closure of the method.
    ///     - result: *Part of the completion closure.*
    ///               **True** if user already created profile with Lost Coast.
    ///               **False** if user have not create profile or any error.
    ///     - error: Error of the process if any.
    func checkUserProfileExist(completion: @escaping(_ result: Bool, _ error: Error?) -> Void) {
        
        CURRENT_USER_REFERENCE?.getDocument { (snapshot, error) in
            if let snapshot = snapshot {
                if snapshot.exists {
                    completion(true, error)
                }
                else {
                    completion(false, error)
                }
            }
            else {
                completion(false, error)
            }
        }
    }
    
    /// Upload user's profile to Firebase.
    ///
    /// - Parameters:
    ///     - completion: The completion callback.
    ///     - error: Resulting error from uploading if any.
    func uploadProfile(profile: LostCoastUser,completion: @escaping(_ error: Error?) -> Void) {

        CURRENT_USER_REFERENCE?.setData(profile.toDict(), completion: { (error) in
            if error != nil {
                completion(error)
            }
            else {
                completion(nil)
            }
        })
    }
    
    /// Check Firebase Firestore dabase if the given username exist.
    ///
    /// - Parameters:
    ///     - username: The chosen username by user
    ///     - completion: Completion Callback
    ///     - result: **True** if another user already register the chose username.
    ///               **False** if no other user have the chosen username.
    func checkUsernameExist(username: String, completion: @escaping(_ result: Bool) -> Void) {
        USERS_REFERENCE.whereField(UserFieldReference.username.rawValue, isEqualTo: username).getDocuments { (snapshot, error) in
            
            if let err = error {
                print("Check Username Exist: Error! \n", err)
                completion(false)
                return
            }
            
            guard let isEmpty = snapshot?.isEmpty else { return }
            
            if isEmpty {
                completion(false)
            }
            else {
                completion(true)
            }
        }
    }
    
    func downloadImage(user: LostCoastUser, completion: @escaping(_ image: UIImage, _ error: Error) -> Void) {
        
    }
}

