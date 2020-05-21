//
//  User.swift
//  RockPaperScissors
//
//  Created by Shannon Draeker on 5/21/20.
//  Copyright © 2020 Shannon Draeker. All rights reserved.
//

import Foundation
import CloudKit

// MARK: - Strings

struct UserStrings {
    static let recordTypeKey = "User"
    fileprivate static let usernameKey = "username"
    fileprivate static let highScoreKey = "highScore"
    static let appleUserReferenceKey = "appleUserReference"
}

class User {
    
    // Properties
    let username: String
    var highScore: Int
    var appleUserReference: CKRecord.Reference
    var recordID: CKRecord.ID
    
    // Initializer
    init(username: String, highScore: Int, appleUserReference: CKRecord.Reference, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.username = username
        self.highScore = highScore
        self.appleUserReference = appleUserReference
        self.recordID = recordID
    }
}

// MARK: - Convert from CKRecord

extension User {
    
    convenience init?(ckRecord: CKRecord) {
        guard let username = ckRecord[UserStrings.usernameKey] as? String,
            let highScore = ckRecord[UserStrings.highScoreKey] as? Int,
            let appleUserReference = ckRecord[UserStrings.appleUserReferenceKey] as? CKRecord.Reference
            else { return nil }
        self.init(username: username, highScore: highScore, appleUserReference: appleUserReference, recordID: ckRecord.recordID)
    }
}

// MARK: - Convert to CKRecord

extension CKRecord {
    
    convenience init(user: User) {
        self.init(recordType: UserStrings.recordTypeKey, recordID: user.recordID)
        
        setValuesForKeys([
            UserStrings.usernameKey : user.username,
            UserStrings.highScoreKey : user.highScore,
            UserStrings.appleUserReferenceKey : user.appleUserReference
        ])
    }
}
