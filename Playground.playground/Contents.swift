//: Playground - noun: a place where people can play

import UIKit
import RealmSwift


class CatalogEntity : Object {
    dynamic var id  = NSUUID().uuidString
    
    
}

class TestVenue : CatalogEntity {
    dynamic var name:String?
    
}

class TestExcursion : CatalogEntity {
    dynamic var excursionName:String?
}

//class Category : Object {
//    var members = AnyRealmCollection<CatalogEntity>
//    init<C: RealmCollection>(members: C) where C.element == CatalogEntity {
//        self.members = AnyRealmCollection(members)
//    }
//}


let newRealm = try! Realm()

try! newRealm.write {
    let venues = newRealm.objects(TestVenue.self)
    let shorexes = newRealm.objects(TestExcursion.self)
    newRealm.delete(venues)
    newRealm.delete(shorexes)
    
    for i in 1...10 {
        
        
        
        let venue = TestVenue()
        venue.name = "venue\(i)"
        
        
        let shoreex = TestExcursion()
        shoreex.excursionName = "Excursion\(i)"
        newRealm.add(shoreex)
        newRealm.add(venue)
    }
    let allvenues = newRealm.objects(TestVenue.self)
    let allShorex = newRealm.objects(TestExcursion.self)
//    let TestCategory = Category()
//    TestCategory.members.append(allvenues)
    

}

//class newClass {
//    
//    let collection: AnyRealmCollection<Object>
//    init<C:RealmCollection>(collection:C) where C.Element == CatalogEntity {
//        self.collection = AnyRealmCollection(collection)
//    }
//    
//    
//}
//
//let category = newClass(collection: CatalogEntity)


