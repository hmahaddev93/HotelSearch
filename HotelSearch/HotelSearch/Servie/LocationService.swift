//
//  LocationService.swift
//  HotelSearch
//
//  Created by Khateeb Hussain on 10/31/22.
//

import Foundation

protocol LocationService_Protocol {
    func searchHotels(query: String, completion: @escaping (Result<[LocationItem], Error>) -> Void)
}

class LocationService: LocationService_Protocol {
    private let httpClient: HttpClient
    private let jsonDecoder: JSONDecoder
    
    enum LocationServiceError: Error {
        case invalidUrl
    }
    
    struct LocationsResponseBody: Codable {
        let sr: [LocationItem]
    }
    
    struct test: Codable {
        let type: String
    }

    init() {
        self.httpClient = HttpClient(session: URLSession.shared)
        self.jsonDecoder = JSONDecoder()
    }
    
    func searchHotels(query: String, completion: @escaping (Result<[LocationItem], Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = HotelAPI.host
        urlComponents.path = HotelAPI.EndPoints.search
        let queryItem = URLQueryItem(name: "q", value: query)
        urlComponents.queryItems = [queryItem]
        
        guard let url = urlComponents.url else {
            completion(.failure(LocationServiceError.invalidUrl))
            return
        }
        print(url.absoluteString)
                
        httpClient.get(url: url, headers: [HotelAPI.headerKey, HotelAPI.headerHost]) { data, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(HttpClientError.emptyData))
                return
            }
            do {
                let result = try self.jsonDecoder.decode(LocationsResponseBody.self, from: data)
                completion(.success(result.sr.filter{$0.type == .HOTEL}))
            } catch {
                completion(.failure(error))
            }
        }
    }

}

