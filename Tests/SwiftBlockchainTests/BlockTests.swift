//
//  File.swift
//  
//
//  Created by R. Kukuh on 14/10/23.
//

import XCTest
@testable import SwiftBlockchain

final class BlockTests: XCTestCase {
    
    var block: Block!
    
    func testGenesisBlock() {
        let genesis = Block.genesis
        
        XCTAssertEqual(genesis.index, 0)
        XCTAssertEqual(genesis.previousHash, "0")
        XCTAssertEqual(genesis.timestamp, 1697293989000)
        XCTAssertEqual(genesis.data, "Genesis Block created")
        XCTAssertEqual(genesis.hash, "0000cc157676415ae96d7c678abff10dc34a27171f04fc0c49e47115e863e85a")
        XCTAssertEqual(genesis.nonce, 123)
    }
    
}
