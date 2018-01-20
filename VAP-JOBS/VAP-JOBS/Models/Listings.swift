//
//  Listings.swift
//
//  Created by Hoff Henry Pereira da Silva on 19/01/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

class Listings: Model {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let total = "total"
        static let page = "page"
        static let perpage = "perpage"
        static let listing = "listing"
        static let lastUpdate = "last_update"
        static let pages = "pages"
    }
    
    // MARK: Properties
    public var total: Int?
    public var page: Int?
    public var perpage: Int?
    public var listing: [Listing]?
    public var lastUpdate: String?
    public var pages: Int?
    
    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    
    override init() {
        super.init()
    }
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
        super.init(json: json)
        total = json[SerializationKeys.total].int
        page = json[SerializationKeys.page].int
        perpage = json[SerializationKeys.perpage].int
        if let items = json[SerializationKeys.listing].array { listing = items.map { Listing(json: $0) } }
        lastUpdate = json[SerializationKeys.lastUpdate].string
        pages = json[SerializationKeys.pages].int
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = total { dictionary[SerializationKeys.total] = value }
        if let value = page { dictionary[SerializationKeys.page] = value }
        if let value = perpage { dictionary[SerializationKeys.perpage] = value }
        if let value = listing { dictionary[SerializationKeys.listing] = value.map { $0.dictionaryRepresentation() } }
        if let value = lastUpdate { dictionary[SerializationKeys.lastUpdate] = value }
        if let value = pages { dictionary[SerializationKeys.pages] = value }
        return dictionary
    }
    
}
