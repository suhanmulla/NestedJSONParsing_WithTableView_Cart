//
//  Carts.swift
//  NestedJSONParsing_WithTableView_Cart
//
//  Created by Macintosh on 15/04/25.
//

import Foundation

struct Carts {
    var id : Int
    var products : [Products]
    var total : Double
    var discountedTotal : Double
    var userId : Int
    var totalProducts : Int
    var totalQuantity : Int
}
