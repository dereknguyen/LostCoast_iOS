//
//  RealmServiceAPI.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 9/9/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import Foundation
import RealmSwift

class RealmServiceAPI {
    
    private init() {}
    
    static let shared = RealmServiceAPI()
    
    var realm = try! Realm()
    
    func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            post(error)
        }
    }
    
    func update<T: Object>(_ object: T, with dictionary: [String: Any], completion: @escaping() -> Void) {
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
                completion()
            }
        } catch {
            post(error)
        }
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            post(error)
        }
    }
    
    func removeLocalData() {
        let uidPredicate = NSPredicate(format: "uid == %@", Offline.currentUser.uid)
        if let user = realm.objects(LostCoastUser.self).filter(uidPredicate).first {
            delete(user)
        }
        
        let waves = realm.objects(Session.self)
        
        for wave in waves {
            delete(wave)
        }
    }
    
    func post(_ error: Error) {
        NotificationCenter.default.post(name: NSNotification.Name("RealmError"), object: error)
    }
    
    func observeRealmError(in vc: UIViewController, completion: @escaping (_ error: Error?) -> Void) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("RealmError"), object: nil, queue: nil) { (notification) in
            completion(notification.object as? Error)
        }
    }
    
    func stopObservingErrors(in vc: UIViewController) {
        NotificationCenter.default.removeObserver(vc, name: NSNotification.Name("RealmError"), object: nil)
    }
}
