//
//  Result.swift
//  SalesRanking1
//
//  Created by tichinose1 on 2018/04/01.
//  Copyright © 2018年 example.com. All rights reserved.
//

import Foundation

struct Item: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let name: String
    let artworkUrl100: String
}
