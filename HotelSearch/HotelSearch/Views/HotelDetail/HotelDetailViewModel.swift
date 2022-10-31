//
//  HotelDetailViewModel.swift
//  HotelSearch
//
//  Created by Khateeb Hussain on 10/31/22.
//

import Foundation

class HotelDetailViewModel {
    // MARK: - Initialization
    init(model: LocationItem, title: String) {
        self.hotel = model
        self.title = title
    }
    var hotel: LocationItem
    var title: String
}

