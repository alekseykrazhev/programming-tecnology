//
//  Cities+CoreDataProperties.swift
//  task2-2
//
//  Created by Кражевский Алексей И. on 6/10/22.
//
//

import Foundation
import CoreData


extension Cities {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cities> {
        return NSFetchRequest<Cities>(entityName: "Cities")
    }

    @NSManaged public var info: String?
    @NSManaged public var route: String?
    @NSManaged public var city: String?

}

extension Cities : Identifiable {

}
