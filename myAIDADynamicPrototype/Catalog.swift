//
//  Catalog.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 03.08.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import RealmSwift

struct Catalog {
    
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

}
