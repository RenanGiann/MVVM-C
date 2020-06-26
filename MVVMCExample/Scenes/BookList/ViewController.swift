//
//  ViewController.swift
//  MVVMCExample
//
//  Created by Ginaldo Júnior on 05/06/20.
//  Copyright © 2020 cristina. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BindableType {
    
    var viewModel: ViewModelType?

    @IBOutlet weak var booksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibTexto = UINib(nibName: "BookListTableViewCell", bundle: nil)
        
        self.booksTableView.register(nibTexto, forCellReuseIdentifier: "BookCell")
        self.booksTableView.delegate = self
        self.booksTableView.dataSource = self
    }
    
    func bindViewModel() {
        viewModel?.outputs.booksObservable.bind { _ in
            DispatchQueue.main.async {
                self.booksTableView.reloadData()
            }
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.outputs.numberOfBooks ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookListTableViewCell
        
        let book = viewModel!.outputs.book(at: indexPath.row)
        
        cell.titleLabel.text = book.title
        cell.authorLabel.text = book.author
        cell.accessibilityHint = "Dê dois toques para ver os detalhes"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.inputs.navigateToBookDetail()
    }
    
}
