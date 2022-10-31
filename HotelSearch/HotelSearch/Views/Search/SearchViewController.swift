//
//  SearchViewController.swift
//  HotelSearch
//
//  Created by Khateeb Hussain on 10/31/22.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        LocationService().searchHotels(query: "new york") { result in
            switch result {
            case .success(let hotels):
                print(hotels)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

