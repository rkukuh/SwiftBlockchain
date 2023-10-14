//
//  File.swift
//  
//
//  Created by R. Kukuh on 14/10/23.
//

import XCTest
@testable import SwiftBlockchain

class BlockTests: XCTestCase {
    
    var block: Block!
    
    override func setUp() {
        super.setUp()
        
        block = Block(index: 1, 
                      previousHash: "000000",
                      timestamp: 1633027200,
                      data: "Test Data",
                      hash: "123456",
                      nonce: 0)
    }
    
    override func tearDown() {
        block = nil
        
        super.tearDown()
    }
    
    func testGenesisBlock() {
        let genesis = Block.genesis
        XCTAssertEqual(genesis.index, 0)
        XCTAssertEqual(genesis.previousHash, "0")
        XCTAssertEqual(genesis.timestamp, 1508270000000)
        XCTAssertEqual(genesis.data, "Genesis Block created")
        XCTAssertEqual(genesis.hash, "000dc75a315c77a1f9c98fb6247d03dd18ac52632d7dc6a9920261d8109b37cf")
        XCTAssertEqual(genesis.nonce, 604)
    }
    
}
