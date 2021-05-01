//
//  MovieModel.swift
//  RickMovie
//
//  Created by Martin Chibwe on 4/30/21.
//

import Foundation
struct MovieModelResults :Codable {
    var info: info
    var results: [results]
}
struct info: Codable {
    var pages: Int?
    var next: String?
    var prev: String?
}
struct results: Codable{
    var id: Int?
    var name: String?
    var species:String?
    var status: String?
    var type: String?
    var gender: String?
    var origin: origin
    var location:location
    var image: String?
    var episode:[String]?
    var url: String?
    var created: String?
}
struct location: Codable{
    var name: String?
    var url: String?
}
struct origin: Codable{
    var name: String?
    var url: String?
}
