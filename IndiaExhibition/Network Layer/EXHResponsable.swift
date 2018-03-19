//
//  EXHResponsable.swift
//  IndiaExhibition
//
//  Created by gourav sharma on 3/19/18.
//  Copyright © 2018 mobileprogramming. All rights reserved.
//

import Foundation

protocol Identifiable {
    static func parseJSON(data:Any?)->ResponseResult<Any>?
}

internal enum ResponseResult<Value> {
    case success(Value?)
    case failure(Error)
    case uninitialize
    
    /// Returns `true` if the result is a success, `false` otherwise.
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        case .uninitialize:
            return false
        }
    }
    
    /// Returns `true` if the result is a failure, `false` otherwise.
    public var isFailure: Bool {
        return !isSuccess
    }
    
    /// Returns the associated value if the result is a success, `nil` otherwise.
    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        case .uninitialize:
            return nil
        }
    }
    
    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    public var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        case .uninitialize:
            return nil
        }
    }
}

enum APIErrorType:Error {
    
    case apiMessage(key:String,message:String)
    
    func errorTitle()->String {
        switch self {
        case .apiMessage(let a, _):
            return a
        }
    }
    
    func description()->String {
        switch self {
        case .apiMessage(_, let b):
            return b
        }
    }
    
}

extension APIErrorType {
    public var localizedDescription: String { return self.description() }
}

