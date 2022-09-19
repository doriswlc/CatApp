//
//  Cat.swift
//  CatApp
//
//  Created by doriswlc on 2022/9/19.
//

import Foundation

struct Cat: Decodable {
    let id: Int
    let imageId: String
    let subId: String
    let image: Image
    struct Image: Decodable {
        let id: String
        let url: URL
    }
}
