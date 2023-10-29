//
//  File.swift
//  
//
//  Created by R. Kukuh on 14/10/23.
//

import Foundation

public struct Block: Equatable {
    
    var index: Int
    var previousHash: String
    var timestamp: UInt64
    var data: String
    var hash: String
    var nonce: Int
    
    static var genesis: Block {
        return Block(index: 0, 
                     previousHash: "0000000000000000000000000000000000000000000000000000000000000000",
                     timestamp: 1697293989000,
                     data: "Genesis Block created",
                     hash: "0000cc157676415ae96d7c678abff10dc34a27171f04fc0c49e47115e863e85a",
                     nonce: 178458)
    }
    
}
