//
//  Listing.swift
//
//  Created by Hoff Henry Pereira da Silva on 19/01/2018
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

class Listing: Model {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let relocationAssistance = "relocation_assistance"
        static let telecommuting = "telecommuting"
        static let howtoApply = "howto_apply"
        static let descriptionValue = "description"
        static let applyUrl = "apply_url"
        static let keywords = "keywords"
        static let type = "type"
        static let category = "category"
        static let id = "id"
        static let perks = "perks"
        static let postDate = "post_date"
        static let title = "title"
        static let company = "company"
        static let url = "url"
    }
    
    // MARK: Properties
    public var relocationAssistance: Int?
    public var telecommuting: Int?
    public var howtoApply: String?
    public var descriptionValue: String?
    public var applyUrl: String?
    public var keywords: String?
    public var type: Type?
    public var category: Category?
    public var id: String?
    public var perks: String?
    public var postDate: String?
    public var title: String?
    public var company: Company?
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
        relocationAssistance = json[SerializationKeys.relocationAssistance].int
        telecommuting = json[SerializationKeys.telecommuting].int
        howtoApply = json[SerializationKeys.howtoApply].string
        descriptionValue = json[SerializationKeys.descriptionValue].string
        applyUrl = json[SerializationKeys.applyUrl].string
        keywords = json[SerializationKeys.keywords].string
        type = Type(json: json[SerializationKeys.type])
        category = Category(json: json[SerializationKeys.category])
        id = json[SerializationKeys.id].string
        perks = json[SerializationKeys.perks].string
        postDate = json[SerializationKeys.postDate].string
        title = json[SerializationKeys.title].string
        company = Company(json: json[SerializationKeys.company])
        url = json[SerializationKeys.url].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = relocationAssistance { dictionary[SerializationKeys.relocationAssistance] = value }
        if let value = telecommuting { dictionary[SerializationKeys.telecommuting] = value }
        if let value = howtoApply { dictionary[SerializationKeys.howtoApply] = value }
        if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
        if let value = applyUrl { dictionary[SerializationKeys.applyUrl] = value }
        if let value = keywords { dictionary[SerializationKeys.keywords] = value }
        if let value = type { dictionary[SerializationKeys.type] = value.dictionaryRepresentation() }
        if let value = category { dictionary[SerializationKeys.category] = value.dictionaryRepresentation() }
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = perks { dictionary[SerializationKeys.perks] = value }
        if let value = postDate { dictionary[SerializationKeys.postDate] = value }
        if let value = title { dictionary[SerializationKeys.title] = value }
        if let value = company { dictionary[SerializationKeys.company] = value.dictionaryRepresentation() }
        if let value = url { dictionary[SerializationKeys.url] = value }
        return dictionary
    }
    
    
}
