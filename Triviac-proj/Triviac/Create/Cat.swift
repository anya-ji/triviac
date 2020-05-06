//
//  Cat.swift
//  Triviac
//
//  Created by Anya Ji on 5/5/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import Foundation
struct Cat: Decodable {
    var catnum: String?
    var catname: String?
}

struct CatResponse: Decodable{
    var cats: [Cat]
}


