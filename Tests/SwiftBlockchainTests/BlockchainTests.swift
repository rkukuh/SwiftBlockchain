//
//  BlockchainTests.swift
//
//
//  Created by R. Kukuh on 24/10/23.
//

import XCTest
@testable import SwiftBlockchain

final class BlockchainTests: XCTestCase {
    
    var minedBlock: Block!
    var blockchain: Blockchain!
    
    override func setUpWithError() throws {
        super.setUp()
        
        blockchain = Blockchain()
        blockchain.mine(data: "New Data")
        minedBlock = blockchain.latestBlock
    }
    
    override func tearDownWithError() throws {
        blockchain = nil
        
        super.tearDown()
    }
    
    func testGet() {
        let chain = blockchain.get()
        
        XCTAssertNotNil(chain)
        XCTAssertEqual(chain.count, 2)
    }
    
    func testLatestBlock() {
        let latest = blockchain.latestBlock
        
        XCTAssertEqual(latest, minedBlock)
    }
    
    func testIsValidHashDifficulty() {
        let validHash = "000123456"
        let invalidHash = "123456"
        
        XCTAssertTrue(blockchain.isValidHashDifficulty(hash: validHash))
        XCTAssertFalse(blockchain.isValidHashDifficulty(hash: invalidHash))
    }
    
    func testCalculateHash() {
        let index = minedBlock.index
        let previousHash = minedBlock.previousHash
        let timestamp = minedBlock.timestamp
        let data = minedBlock.data
        let nonce = minedBlock.nonce
        
        let calculatedHash = blockchain.calculateHash(index: index,
                                                      nonce: nonce,
                                                      previousHash: previousHash,
                                                      timestamp: timestamp,
                                                      data: data)
        
        XCTAssertEqual(calculatedHash, minedBlock.hash)
    }
    
    func testCalculateHashForBlock() {
        let calculatedHash = blockchain.calculateHashForBlock(block: minedBlock)
        
        XCTAssertEqual(calculatedHash, minedBlock.hash)
    }
    
    func testMine() {
        blockchain.mine(data: "New Data")
        
        XCTAssertEqual(blockchain.get().count, 3)
    }
    
    func testGenerateNextBlock() {
        let newBlock = try? blockchain.generateNextBlock(data: "New Data")
        
        XCTAssertNotNil(newBlock)
    }
    
    func testAddBlock() {
        let newBlock = try? blockchain.generateNextBlock(data: "New Data")
        
        if let block = newBlock {
            try? blockchain.addBlock(newBlock: block)
        }
        
        XCTAssertEqual(blockchain.get().count, 3)
    }
    
    func testIsValidNextBlock() {
        let newBlock = try? blockchain.generateNextBlock(data: "New Data")
        
        if let block = newBlock {
            XCTAssertTrue(blockchain.isValidNextBlock(nextBlock: block, 
                                                      previousBlock: blockchain.latestBlock))
        }
    }
    
    func testIsValidChain() {
        XCTAssertTrue(blockchain.isValidChain(chain: blockchain.get()))
    }
    
//    func testIsChainLonger() {
//        let localBlockchain = Blockchain()
//        
//        localBlockchain.mine(data: "Test Data")
//        
//        let newBlockchain = Blockchain()
//        
//        newBlockchain.mine(data: "New Data")
//        newBlockchain.mine(data: "Another New Data")
//        
//        /// DEBUG
//        print("Original blockchain length: \(blockchain.get().count)")
//        print("New blockchain length: \(newBlockchain.get().count)")
//        
//        let isLonger = newBlockchain.isChainLonger(chain: blockchain.get())
//        print("Is new blockchain longer: \(isLonger)")
//        /// END OF DEBUG
//
//        XCTAssertTrue(newBlockchain.isChainLonger(chain: localBlockchain.get()), "New blockchain should be longer")
//    }
    
    func testReplaceChain() {
        let newBlockchain = Blockchain()
        
        newBlockchain.mine(data: "New Data")
        
        blockchain.replaceChain(newChain: newBlockchain.get())
        
        XCTAssertEqual(blockchain.get().count, newBlockchain.get().count)
    }
    
}
