//
//  File.swift
//  
//
//  Created by R. Kukuh on 14/10/23.
//

import Foundation

struct Block {
    
    var index: Int
    var previousHash: String
    var timestamp: UInt64
    var data: String
    var hash: String
    var nonce: Int
    
    static var genesis: Block {
        return Block(index: 0, 
                     previousHash: "0",
                     timestamp: 1508270000000,
                     data: "Genesis Block created",
                     hash: "000dc75a315c77a1f9c98fb6247d03dd18ac52632d7dc6a9920261d8109b37cf",
                     nonce: 604)
    }
    
}
