//
//  Operators.swift
//  ParsersPackageDescription
//
//  Created by Benjamin Herzog on 13.08.17.
//

import Foundation

public func ||<T, R>(lhs: Parser<T, R>, rhs: @escaping @autoclosure () -> Parser<T, R>) -> Parser<T, R> {
    return lhs.or(rhs())
}

public func >><T, R, B>(lhs: Parser<T, R>, rhs: @escaping @autoclosure () -> Parser<T, B>) -> Parser<T, B> {
    return lhs.then(rhs())
}
