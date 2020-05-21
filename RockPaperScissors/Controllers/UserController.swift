//
//  UserController.swift
//  RockPaperScissors
//
//  Created by Shannon Draeker on 5/21/20.
//  Copyright © 2020 Shannon Draeker. All rights reserved.
//

import Foundation
import CloudKit

class UserController {
    
    // MARK: - Singleton
    
    static let shared = UserController()
    
    // MARK: - Source of Truth
    
    var currentUser: User?
    var users: [User] = []
    
    // MARK: - Properties
    
    let publicDB = CKContainer(identifier: "iCloud.com.Shannon.RockPaperScissors").publicCloudDatabase
    
    // MARK: - CRUD Methods
    
    // Create a user
    func createNewUser(with username: String, completion: @escaping (Bool) -> Void) {
        // Get the user's apple reference
        fetchAppleUserReference { [weak self]  (reference) in
            // Make sure the reference was fetched successfully
            guard let reference = reference else { return completion(false)}
            
            // Create the user as a CKRecord
            let userRecord = CKRecord(user: User(username: username, highScore: 0, appleUserReference: reference))
            
            // Save the user to the cloud
            self?.publicDB.save(userRecord) { (record, error) in
                // Handle the error
                if let error = error {
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    return completion(false)
                }
                
                // Unwrap the data
                guard let record = record,
                    let user = User(ckRecord: record)
                    else { return completion(false) }
                
                // Save the data to the source of truth and return success
                self?.currentUser = user
                return completion(true)
            }
        }
    }
    
    // Read (fetch) the current user
    func fetchCurrentUser(completion: @escaping (Bool) -> Void) {
        // Get the current user's apple reference
        fetchAppleUserReference { [weak self] (reference) in
            // Make sure the reference was fetched successfully
            guard let reference = reference else { return completion(false) }
            
            // Search for only the current user's data
            let predicate = NSPredicate(format: "%K == %@", argumentArray: [UserStrings.appleUserReferenceKey, reference])
            
            let query = CKQuery(recordType: UserStrings.recordTypeKey, predicate: predicate)
            
            self?.publicDB.perform(query, inZoneWith: nil) { (records, error) in
                // Handle any errors
                if let error = error {
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    return completion(false)
                }
                
                // Unwrap the data
                guard let record = records?.first,
                    let user = User(ckRecord: record)
                    else { return completion(false) }
                
                // Save the data to the source of truth and return success
                self?.currentUser = user
                return completion(true)
            }
        }
    }
    
    // Read (fetch) the users with the highest scores
    func fetchHighScoringUsers(completion: @escaping (Bool) -> Void) {
        // Set up the query to pull the users based on high scores
        let query = CKQuery(recordType: UserStrings.recordTypeKey, predicate: NSPredicate(value: true))
        
        // Pull the users from the cloud
        publicDB.perform(query, inZoneWith: nil) { [weak self] (records, error) in
            // Handle any errors
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(false)
            }
            
            // Unwrap the data
            guard let records = records else { return completion(false) }
            let users = records.compactMap( { User(ckRecord: $0) }).sorted(by: { $0.highScore > $1.highScore } )
            
            // Save the data to the source of truth and return success
            self?.users = users
            return completion(true)
        }
    }
    
    // Update a user's score
    func updateScore(by newScore: Int, completion: @escaping (Bool) -> Void) {
        // Make sure the user exists
        guard let currentUser = currentUser else { return completion(false) }
        
        // Update the user's score and convert it to a CKRecord
        currentUser.highScore += newScore
        let userRecord = CKRecord(user: currentUser)
        
        // Create the operation to modify the record in the cloud
        let operation = CKModifyRecordsOperation()
        operation.recordsToSave = [userRecord]
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInteractive
        operation.modifyRecordsCompletionBlock = { (records, _, error) in
            // Handle any errors
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(false)
            }
            
            // Unwrap the data
            guard let record = records?.first,
                let _ = User(ckRecord: record)
                else { return completion(false) }
            
            // Return the completion
            return completion(true)
        }
        
        // Add the operation to the database
        publicDB.add(operation)
    }
    
    // MARK: - Helper Method
    
    private func fetchAppleUserReference(completion: @escaping (CKRecord.Reference?) -> Void) {
        CKContainer(identifier: "iCloud.com.Shannon.RockPaperScissors").fetchUserRecordID { (recordID, error) in
            // Handle the error
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(nil)
            }
            
            // Unwrap the data
            guard let recordID = recordID else { return completion(nil) }
            let reference = CKRecord.Reference(recordID: recordID, action: .none)
            return completion(reference)
        }
    }
}
