//
//  FirebaseController.swift
//  Timeline
//
//  Created by youcef bouhafna on 2/29/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//
import Foundation
import UIKit
import Firebase
class FirebaseController: NSObject {
    static let base = Firebase(url: "https://timelinebyme.firebaseio.com/")
    
    static func dataAtEndpoint(endpoint: String, completion: (data: AnyObject?) -> Void) {
        let dataFetch = FirebaseController.base.childByAppendingPath(endpoint)
        dataFetch.observeSingleEventOfType(.Value, withBlock: { (snapshot) -> Void in
            if   snapshot.value != nil {
                completion(data: snapshot.value)
            } else {
                completion(data: nil)
            }
        })
    }
    
    static func observeDataAtEndpoint(endpoint: String, completion: (data: AnyObject?) -> Void) {
        let dataChanged = FirebaseController.base.childByAppendingPath(endpoint)
        dataChanged.observeEventType(.Value, withBlock: { (snapshot) -> Void in
            if snapshot.value is NSNull {
                completion(data: nil)
            }else {
                completion(data: snapshot.value)
            }
        })
    }
    
}
protocol FirebaseType {
    var identifier: String? { get set}
    var endpoint: String {get}
    var jsonValue: [String: AnyObject] {get}
    
    init?(json: [String: AnyObject], identifier: String)
    mutating func save()
    
    func delete()
    
}



extension FirebaseType {
    mutating func save(){
        var data: Firebase
        if let identifier = self.identifier {
             data = FirebaseController.base.childByAppendingPath(endpoint).childByAppendingPath(identifier)
            
            
        }else {
             data = FirebaseController.base.childByAppendingPath(endpoint).childByAutoId()
            identifier = data.key
        }
        data.updateChildValues(self.jsonValue)
    }
    func delete() {
        var data: Firebase
        if let identifier = self.identifier {
            data = FirebaseController.base.childByAppendingPath(endpoint).childByAppendingPath(identifier)
            data.removeValue()
        }
    }
}





