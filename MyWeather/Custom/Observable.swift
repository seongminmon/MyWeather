//
//  Observable.swift
//  MyWeather
//
//  Created by 김성민 on 7/15/24.
//

import Foundation

final class Observable<T> {
    var closure: ((T) -> Void)?
    
    var value: T {
        didSet {
            closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(closure: @escaping (T) -> Void) {
        self.closure = closure
    }
    
    func bindEarly(closure: @escaping (T) -> Void) {
        closure(value)
        self.closure = closure
    }
}
