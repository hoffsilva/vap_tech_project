//
//  Location.swift
//
//  Created by Hoff Henry Pereira da Silva on 20/01/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

class Location: Model {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let state = "state"
        static let name = "name"
        static let city = "city"
        static let lng = "lng"
        static let id = "id"
        static let count = "count"
        static let lat = "lat"
        static let country = "country"
    }
    
    // MARK: Properties
    public var state: String?
    public var name: String?
    public var city: String?
    public var lng: String?
    public var id: String?
    public var count: Int?
    public var lat: String?
    public var country: String?
    
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
        state = json[SerializationKeys.state].string
        name = json[SerializationKeys.name].string
        city = json[SerializationKeys.city].string
        lng = json[SerializationKeys.lng].string
        id = json[SerializationKeys.id].string
        count = json[SerializationKeys.count].int
        lat = json[SerializationKeys.lat].string
        country = json[SerializationKeys.country].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = state { dictionary[SerializationKeys.state] = value }
        if let value = name { dictionary[SerializationKeys.name] = value }
        if let value = city { dictionary[SerializationKeys.city] = value }
        if let value = lng { dictionary[SerializationKeys.lng] = value }
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = count { dictionary[SerializationKeys.count] = value }
        if let value = lat { dictionary[SerializationKeys.lat] = value }
        if let value = country { dictionary[SerializationKeys.country] = value }
        return dictionary
    }
    
}
