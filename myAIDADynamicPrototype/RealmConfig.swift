//
//  RealmConfig.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 03.08.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import Foundation
import RealmSwift

public enum RealmConfig {
    private static var copyInitialFile: Void = {
        DataUtils.copyInitialData(
            Bundle.main.url(forResource: "catalogContent", withExtension: "realm")!,
            to: RealmConfig.mainConfig.fileURL!)
    }()
    
    
    private static let defaultConfig = Realm.Configuration(

        schemaVersion: 44,
        migrationBlock:DataUtils.migrate

   )
    
    
    private static let mainConfig = Realm.Configuration(
        fileURL: URL.inDocumentsFolder(fileName: "main.realm"),
        schemaVersion: 44,
        migrationBlock:DataUtils.migrate
    )
    
    private static let staticConfig = Realm.Configuration(
        fileURL: Bundle.main.url(forResource: "catalogContent", withExtension: "realm"),
        readOnly:true,
        schemaVersion: 44,
        migrationBlock:DataUtils.migrate

    )
    


    
    case main
    case `default`
    case `static`
    
    var configuration: Realm.Configuration {
        switch  self {
        case .main:
//            _ = RealmConfig.copyInitialFile
            
            return RealmConfig.mainConfig
        
        case .static:
            return RealmConfig.staticConfig
            
            
        case .default:
            return RealmConfig.defaultConfig
        }
        
    }
    
}

