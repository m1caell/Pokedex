//
//  Result.swift
//  Pokedex
//
//  Created by Pablo Trindade on 15/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

public enum Result<Success, Failure> where Failure : Error {
    
    /// A success, storing a `Success` value.
    case success(Success)
    
    /// A failure, storing a `Failure` value.
    case failure(Failure)

}
