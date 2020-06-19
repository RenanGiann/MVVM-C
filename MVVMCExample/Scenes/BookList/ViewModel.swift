//
//  ViewModel.swift
//  MVVMCExample
//
//  Created by Ginaldo Júnior on 05/06/20.
//  Copyright © 2020 cristina. All rights reserved.
//

import Foundation

class ViewModel {
    
    var userObservable: Bindable<User> = Bindable<User>()
    var booksObservable: Bindable<[Book]> = Bindable<[Book]>()
    private let bookService = BookListService()
    
    init() {
        let user = User(name: "Luan", age: 27)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.userObservable.value = user
        })
    }
    
    var numberOfBooks: Int {
        return self.booksObservable.value?.count ?? 0
    }
    
    func book(at index: Int) -> Book {
        return self.booksObservable.value?[index] ?? Book()
    }
    
    func fetchBooks() {
        
        bookService.requestBooks { (result) in
            switch result {
            case .success(let books):
                self.booksObservable.value = books
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
