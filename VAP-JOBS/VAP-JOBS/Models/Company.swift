//
//  Company.swift
//
//  Created by Hoff Henry Pereira da Silva on 19/01/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

class Company: Model {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let name = "name"
        static let location = "location"
        static let logo = "logo"
        static let id = "id"
        static let url = "url"
    }
    
    // MARK: Properties
    public var name: String?
    public var location: Location?
    public var logo: String?
    public var id: String?
    public var url: String?
    
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
        name = json[SerializationKeys.name].string
        location = Location(json: json[SerializationKeys.location])
        logo = json[SerializationKeys.logo].string
        id = json[SerializationKeys.id].string
        url = json[SerializationKeys.url].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = name { dictionary[SerializationKeys.name] = value }
        if let value = location { dictionary[SerializationKeys.location] = value.dictionaryRepresentation() }
        if let value = logo { dictionary[SerializationKeys.logo] = value }
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = url { dictionary[SerializationKeys.url] = value }
        return dictionary
    }
    
}
