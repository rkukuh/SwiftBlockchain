//
//  File.swift
//
//
//  Created by R. Kukuh on 24/10/23.
//

import Foundation
import CryptoKit

@available(macOS 10.15, *)
class Blockchain {
    
    var difficulty: Int
    var blockchain: [Block]
    
    init() {
        self.blockchain = [Block.genesis]
        self.difficulty = 3
    }
    
    func get() -> [Block] {
        return self.blockchain
    }
    
    var latestBlock: Block {
        return self.blockchain.last!
    }
    
    func isValidHashDifficulty(hash: String) -> Bool {
        let prefix = String(repeating: "0", count: self.difficulty)
        return hash.hasPrefix(prefix)
    }
    
    func calculateHash(index: Int, previousHash: String, timestamp: UInt64, data: String, nonce: Int) -> String {
        let input = "\(index)\(previousHash)\(timestamp)\(data)\(nonce)"
        let inputData = Data(input.utf8)
        let hash = SHA256.hash(data: inputData)
        
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }
    
    func calculateHashForBlock(block: Block) -> String {
        return self.calculateHash(index: block.index,
                                  previousHash: block.previousHash,
                                  timestamp: block.timestamp,
                                  data: block.data,
                                  nonce: block.nonce)
    }
    
    func mine(data: String) {
        do {
            let newBlock = try generateNextBlock(data: data)
            try addBlock(newBlock: newBlock)
        } catch {
            print("Error: \(error)")
        }
    }
    
    func generateNextBlock(data: String) throws -> Block {
        let nextIndex = self.latestBlock.index + 1
        let previousHash = self.latestBlock.hash
        var timestamp: UInt64 = UInt64(Date().timeIntervalSince1970 * 1000)
        var nonce = 0
        
        var nextHash = self.calculateHash(index: nextIndex,
                                          previousHash: previousHash,
                                          timestamp: timestamp,
                                          data: data,
                                          nonce: nonce)
        
        while !isValidHashDifficulty(hash: nextHash) {
            nonce += 1
            timestamp = UInt64(Date().timeIntervalSince1970 * 1000)
            
            nextHash = self.calculateHash(index: nextIndex,
                                          previousHash: previousHash,
                                          timestamp: timestamp,
                                          data: data,
                                          nonce: nonce)
        }
        
        return Block(index: nextIndex,
                     previousHash: previousHash,
                     timestamp: timestamp,
                     data: data,
                     hash: nextHash,
                     nonce: nonce)
    }
    
    func addBlock(newBlock: Block) throws {
        if isValidNextBlock(nextBlock: newBlock, previousBlock: self.latestBlock) {
            self.blockchain.append(newBlock)
        } else {
            throw NSError(domain: "Invalid block", code: 1, userInfo: nil)
        }
    }
    
    func isValidNextBlock(nextBlock: Block, previousBlock: Block) -> Bool {
        let nextBlockHash = self.calculateHashForBlock(block: nextBlock)
        
        if previousBlock.index + 1 != nextBlock.index {
            return false
        } else if previousBlock.hash != nextBlock.previousHash {
            return false
        } else if nextBlockHash != nextBlock.hash {
            return false
        } else if !isValidHashDifficulty(hash: nextBlockHash) {
            return false
        } else {
            return true
        }
    }
    
    func isValidChain(chain: [Block]) -> Bool {
        if chain.first != Block.genesis {
            return false
        }
        
        for i in 1..<chain.count {
            if !isValidNextBlock(nextBlock: chain[i], previousBlock: chain[i-1]) {
                return false
            }
        }
        
        return true
    }
    
    func isChainLonger(chain: [Block]) -> Bool {
        return chain.count > self.blockchain.count
    }
    
    func replaceChain(newChain: [Block]) {
        if isValidChain(chain: newChain) && isChainLonger(chain: newChain) {
            self.blockchain = newChain
        } else {
            print("Invalid or shorter chain received. Not replacing the current chain.")
        }
    }
    
}
