//
//  RealmConfig.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 03.08.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import Foundation
import RealmSwift

enum RealmConfig {
    private static var copyInitialFile: Void = {
        Catalog.copyInitialData(
            Bundle.main.url(forResource: "catalogContent", withExtension: "realm")!,
            to: RealmConfig.mainConfig.fileURL!)
    }()
    
    
    private static let defaultConfig = Realm.Configuration(

        schemaVersion: 18,
        migrationBlock: {
            migration, oldSchemaVersion in
            if (oldSchemaVersion < 18) {
                print("schema out of date in default realm file")

            }
    })
    
    
    private static let mainConfig = Realm.Configuration(
        fileURL: URL.inDocumentsFolder(fileName: "main.realm"),
        schemaVersion: 18,
        migrationBlock:
            {
                migration, oldSchemaVersion in
                    if (oldSchemaVersion < 18) {
                        print("schema out of date in main.realm")
                }
            }
    )
    
    private static let staticConfig = Realm.Configuration(
        fileURL: Bundle.main.url(forResource: "catalogContent", withExtension: "realm"),
        readOnly:true,
        schemaVersion: 19,
        migrationBlock:
        {
            migration, oldSchemaVersion in
            if (oldSchemaVersion < 19) {
                print("schema out of date in catalogContent.realm")
            }
        }
    )
    


    
    case main
    case `default`
    case `static`
    
    var configuration: Realm.Configuration {
        switch  self {
        case .main:
            _ = RealmConfig.copyInitialFile
            
            return RealmConfig.mainConfig
        
        case .static:
            return RealmConfig.staticConfig
            
            
        case .default:
            return RealmConfig.defaultConfig
        }
        
    }
    
}

