//
//  ViewModel.swift
//  MVVMCExample
//
//  Created by Renan on 05/06/20.
//  Copyright © 2020. All rights reserved.
//

import Foundation

protocol ViewModelInput {
    func navigateToBookDetail()
}

protocol ViewModelOutput {
    func book(at index: Int) -> Book
    var booksObservable: Bindable<[Book]> { get set }
    var numberOfBooks: Int { get }
}

protocol ViewModelType {
    var inputs: ViewModelInput { get }
    var outputs: ViewModelOutput { get }
}

class ViewModel: ViewModelOutput, ViewModelType {
    
    var inputs: ViewModelInput { return self }
    var outputs: ViewModelOutput { return self }
    
    var booksObservable: Bindable<[Book]> = Bindable<[Book]>()
    
    var numberOfBooks: Int {
        return self.booksObservable.value?.count ?? 0
    }
    
    private let bookService: NYTimesStoreProtocol
    private var sceneCoordinator: SceneCoordinatorType
    private var scenes: BookScenesRouter
    
    init(bookService: NYTimesStoreProtocol = BookListService(),
         sceneCoordinator: SceneCoordinatorType = SceneCoordinator.shared,
         scenes: BookScenesRouter = BookScenes()) {
        self.sceneCoordinator = sceneCoordinator
        self.scenes = scenes
        self.bookService = bookService
        fetchBooks()
    }
    
    func book(at index: Int) -> Book {
        return self.booksObservable.value?[index] ?? Book()
    }
    
    func fetchBooks() {
        bookService.requestBooks { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let books):
                self.booksObservable.value = books
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
}

extension ViewModel: ViewModelInput {
    func navigateToBookDetail() {
        let detailViewModel = DetailViewModel()
        sceneCoordinator.transition(to: scenes.bookDetail(viewModel: detailViewModel))
    }
}
