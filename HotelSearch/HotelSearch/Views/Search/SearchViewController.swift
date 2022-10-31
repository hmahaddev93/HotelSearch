//
//  SearchViewController.swift
//  HotelSearch
//
//  Created by Khateeb Hussain on 10/31/22.
//

import UIKit
import Combine

class SearchViewController: UIViewController {

    private var viewModel: SearchViewModel = SearchViewModel(title: "Hotels")
    private var cancellables: Set<AnyCancellable> = []
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindViewModel()
        prepareView()
    }
    
    private func prepareView() {
        self.title = viewModel.title
        self.searchBar.searchTextField.autocapitalizationType = .words
        self.searchBar.returnKeyType = .search
    }
    
    private func bindViewModel() {
        viewModel.$hotels
            .sink { _ in
                DispatchQueue.main.async {
                    self.updateHotels()
                }
            }
            .store(in: &cancellables)
    }
    
    private func updateHotels() {
        self.tableView.reloadData()
    }
}

// MARK: UISearchBarDelegate Methods
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text, text.isEmpty {
            viewModel.clearHotels()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text,
           !query.isEmpty {
            viewModel.fetchHotels(query: query)
            searchBar.resignFirstResponder()
        }
    }
}

// MARK: TableViewDataSource, TableViewDelegate Methods
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.hotels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hotelCell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        hotelCell.accessoryType = .detailDisclosureButton
        let hotel = viewModel.hotels[indexPath.row]
        hotelCell.textLabel?.text = hotel.displayName()
        return hotelCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .fade)
        let selected = viewModel.hotels[indexPath.row]
        let detailVC = HotelDetailViewController(viewModel: HotelDetailViewModel(model: selected, title: ""))
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

