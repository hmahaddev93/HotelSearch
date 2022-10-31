//
//  LocationItem.swift
//  HotelSearch
//
//  Created by Khateeb Hussain on 10/31/22.
//

import Foundation

struct LocationItem: Codable {
    let type: LocationType
    let regionNames: RegionNames
    let coordinates: Coordinates
    let hotelAddress: HotelAddress?
    
    func displayName() -> String {
        return regionNames.displayName
    }
}


enum LocationType: String, Codable {
    case CITY
    case NEIGHBORHOOD
    case HOTEL
    case AIRPORT
    case unknown
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawString = try container.decode(String.self)
        
        if let type = LocationType(rawValue: rawString) {
            self = type
        } else {
            self = .unknown
        }
    }
}

struct RegionNames: Codable {
    let fullName: String
    let shortName: String
    let displayName: String
    let primaryDisplayName: String
    let secondaryDisplayName: String
    let lastSearchName: String
}

struct Coordinates: Codable {
    let lat: String
    let long: String
}

struct HotelAddress: Codable {
    let street: String
    let city: String
    let province: String
    
    func fullAddress() -> String {
        return "\(street)\n \(city), \(province)"
    }
}
