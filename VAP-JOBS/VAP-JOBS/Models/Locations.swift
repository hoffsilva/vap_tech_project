//
//  Locations.swift
//
//  Created by Hoff Henry Pereira da Silva on 20/01/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

class Locations: Model {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let lastUpdate = "last_update"
    static let location = "location"
  }

  // MARK: Properties
  public var lastUpdate: String?
  public var location: [Location]?

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
    lastUpdate = json[SerializationKeys.lastUpdate].string
    if let items = json[SerializationKeys.location].array { location = items.map { Location(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = lastUpdate { dictionary[SerializationKeys.lastUpdate] = value }
    if let value = location { dictionary[SerializationKeys.location] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

}
