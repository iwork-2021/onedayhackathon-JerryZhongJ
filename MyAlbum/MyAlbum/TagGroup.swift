//
//  Group.swift
//  MyAlbum
//
//  Created by nju on 2021/12/21.
//

import Foundation
import UIKit
struct Tag{
    let name: String
    var photoList:[UIImage] = []
    init(name: String){
        self.name = name
    }
}

struct TagGroup{
    let name: String
    let include: [String]
    var tags: [Tag] = []
    init(name: String, include: [String]){
        self.name = name
        self.include = include
    }
    
}
