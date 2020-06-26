//
//  DetailViewModel.swift
//  MVVMCExample
//
//  Created by Renan 26/06/20.
//  Copyright © 2020 cristina. All rights reserved.
//

import Foundation

protocol DetailViewModelInput {
}

protocol DetailViewModelOutput {

}

protocol DetailViewModelType {
    var inputs: DetailViewModelInput { get }
    var outputs: DetailViewModelOutput { get }
}

class DetailViewModel: DetailViewModelOutput, DetailViewModelType {
    
    var inputs: DetailViewModelInput { return self }
    var outputs: DetailViewModelOutput { return self }

}

extension DetailViewModel: DetailViewModelInput {
    
}
