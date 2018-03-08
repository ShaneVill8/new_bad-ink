//
//  Users.swift
//  bad-ink
//
//  Created by User on 3/7/18.
//  Copyright © 2018 bad-ink. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Users{
    var username : String?
    var first_name : String?
    var last_name : String?
    var password : String?
    
    let ref : DatabaseReference?
    
    init(key: String,snapshot: DataSnapshot) {
        username = key
        
        let snaptemp = snapshot.value as! [String : AnyObject]
        let snapvalues = snaptemp[key] as! [String : AnyObject]
        
        username = snapvalues["username"] as? String ?? "N/A"
        first_name = snapvalues["first_name"] as? String ?? "N/A"
        last_name = snapvalues["last_name"] as? String ?? "N/A"
        password = snapvalues["password"] as? String ?? "N/A"
        
        ref = snapshot.ref
    }
}
