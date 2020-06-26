//
//  DetailViewController.swift
//  MVVMCExample
//
//  Created by Renan Giannella​  on 16/06/20.
//  Copyright © 2020 cristina. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, BindableType {
    
    var viewModel: DetailViewModelType?
    
    @IBOutlet weak var titleDetailLabel: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bindViewModel() {
        
    }
    
}
