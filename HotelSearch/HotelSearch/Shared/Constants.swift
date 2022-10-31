//
//  Constants.swift
//  HotelSearch
//
//  Created by Khateeb Hussain on 10/31/22.
//

import Foundation

typealias HttpHeader = (hKey: String, hValue: String)

enum HotelAPI  {
    static let host: String = "hotels4.p.rapidapi.com"
    enum EndPoints {
        static let search = "/locations/v3/search"
    }
    
    static let headerKey: HttpHeader = ("X-RapidAPI-Key", "34efc26f48mshaff9aa5927fb2abp1a4ac0jsn927f7b5f2dd2")
    static let headerHost: HttpHeader = ("X-RapidAPI-Host", "hotels4.p.rapidapi.com")
}
