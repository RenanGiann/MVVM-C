//
//  ViewController.swift
//  MVVMCExample
//
//  Created by Ginaldo Júnior on 05/06/20.
//  Copyright © 2020 cristina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var booksTableView: UITableView!
    private let viewModel = ViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        
        
        let nibTexto = UINib(nibName: "BookListTableViewCell", bundle: nil)
        
        self.booksTableView.register(nibTexto, forCellReuseIdentifier: "BookCell")
        
        self.booksTableView.delegate = self
        self.booksTableView.dataSource = self
    }
    
    func setupViewModel() {
        viewModel.booksObservable.bind { [weak self](books) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                 self.booksTableView.reloadData()
            }
        }
        viewModel.fetchBooks()
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfBooks
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookListTableViewCell
        
        let book = viewModel.book(at: indexPath.row)
        
        cell.titleLabel.text = book.title
        cell.authorLabel.text = book.author
        cell.accessibilityHint = "Dê dois toques para ver os detalhes"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goDetail", sender: nil)
    }
    
}
