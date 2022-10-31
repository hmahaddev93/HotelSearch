//
//  SearchViewModel.swift
//  HotelSearch
//
//  Created by Khateeb Hussain on 10/31/22.
//

import Foundation
import Combine


final class SearchViewModel: ObservableObject {
    let apiService: LocationService
    @Published private(set) var hotels: [LocationItem] = []
    var title: String

    init(model:[LocationItem]? = nil, title: String) {
        if let model = model {
            self.hotels = model
        }
        self.apiService = LocationService()
        self.title = title
    }
}

extension SearchViewModel {
    func fetchHotels(query: String) {
        self.apiService.searchHotels(query: query) { result in
            switch result {
            case .success(let hotels):
                self.hotels = hotels
                return
            case .failure(_):
                return
            }
        }
    }
    
    func clearHotels() {
        hotels.removeAll()
    }
}
