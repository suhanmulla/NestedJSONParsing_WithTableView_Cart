//
//  APIResponse.swift
//  NestedJSONParsing_WithTableView_Cart
//
//  Created by Macintosh on 15/04/25.
//

import Foundation

struct APIResponse {
    var carts : [Carts]
    var total : Int
    var skip : Int
    var limit : Int
}
