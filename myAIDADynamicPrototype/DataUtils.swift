//
//  Catalog.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 03.08.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import RealmSwift

struct DataUtils {
    
    // MARK: - copy a file
    static func copyInitialData(_ from: URL, to: URL) {
        let copy = {
            _ = try? FileManager.default.removeItem(at: to)
            try! FileManager.default.copyItem(at: from, to: to)
        }
        
        let exists: Bool
        do {
            exists = try to.checkPromisedItemIsReachable()
        } catch {
            copy()
            return
        }
        if !exists {
            copy()
        }
    }
    
    // MARK: - migration
    static func migrate(_ migration: Migration, fileSchemaVersion:UInt64) {
        if fileSchemaVersion == 25 {
            
            migration.enumerateObjects(ofType: Venue.className(), { oldObject, newObject in
                    let id = NSUUID().uuidString
                    newObject!["venueID"] = id
            })
            
        }
        
        if fileSchemaVersion == 26 {
            print("Migrating schema to version 27")
            migration.enumerateObjects(ofType: "Venue", { oldObject, newObject in
                if let newObject = newObject {
                    print(newObject["venueID"] as! String)
                    newObject["venueID"] = NSUUID().uuidString
                }
            
            
            })
            
        }
        
        if fileSchemaVersion == 27 {
            print("Migrating schema to version 28")
            
            
        }
        
        if fileSchemaVersion == 28 {
            print("Migrating schema to version 29")
            
            migration.enumerateObjects(ofType: "Venue", { oldObject, newObject in
                if let newObject = newObject {
                    newObject["id"] = NSUUID().uuidString
                }
         
            })
        }
        
        if fileSchemaVersion == 29 {
            
            print("Migrating to 30")
        }
        
        if fileSchemaVersion == 30 {
            
            print("Migrating to 31")
        }
        
        if fileSchemaVersion == 31 {
            print("Migrating to 32")
        }
        
        if fileSchemaVersion == 32 {
            print("Migrating to 33")
        }
        if fileSchemaVersion == 33 {
            print("Migrating to 34")
        }
        
        if fileSchemaVersion == 34 {
            print("Migrating to 35")
        }

        if fileSchemaVersion == 35 {
            print("Migrating to 36")
            migration.deleteData
        }
        
        if fileSchemaVersion == 36 {
            print("Migrating to 37")
            migration.deleteData
        }
        
        if fileSchemaVersion == 37 {
            print("Migrating to 38")
            migration.deleteData
        }
        if fileSchemaVersion == 38 {
            print("Migrating to 39")
            migration.deleteData
        }
        if fileSchemaVersion == 39 {
            print("Migrating to 40")
        }
        if fileSchemaVersion == 40 {
            print("Migrating to 41")
        }
        if fileSchemaVersion == 41 {
            print("Migrating to 42")
        }
    }

}
