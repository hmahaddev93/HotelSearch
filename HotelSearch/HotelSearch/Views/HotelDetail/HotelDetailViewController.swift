//
//  HotelDetailViewController.swift
//  HotelSearch
//
//  Created by Khateeb Hussain on 10/31/22.
//

import UIKit

class HotelDetailViewController: UIViewController {

    private let viewModel: HotelDetailViewModel
    lazy var detailView = HotelDetailView()
    
    init(viewModel: HotelDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateView()
    }
    
    private func updateView() {
        detailView.model = viewModel.hotel
        self.title = viewModel.title
    }

}
