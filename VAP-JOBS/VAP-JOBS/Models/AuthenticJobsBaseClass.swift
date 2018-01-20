//
//  AuthenticJobsBaseClass.swift
//
//  Created by Hoff Henry Pereira da Silva on 19/01/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

class AuthenticJobsBaseClass: Model {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let stat = "stat"
        static let listings = "listings"
    }
    
    // MARK: Properties
    public var stat: String?
    public var listings: Listings?
    
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
        stat = json[SerializationKeys.stat].string
        listings = Listings(json: json[SerializationKeys.listings])
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = stat { dictionary[SerializationKeys.stat] = value }
        if let value = listings { dictionary[SerializationKeys.listings] = value.dictionaryRepresentation() }
        return dictionary
    }
}
