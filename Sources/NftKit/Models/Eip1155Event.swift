//
//  Eip1155Event.swift
//  NftKit
//
//  Created by Sun on 2024/8/21.
//

import Foundation

import BigInt
import EvmKit
import GRDB

class Eip1155Event: Record {
    let hash: Data
    let blockNumber: Int
    let contractAddress: Address
    let from: Address
    let to: Address
    let tokenID: BigUInt
    let tokenValue: Int
    let tokenName: String
    let tokenSymbol: String

    init(
        hash: Data,
        blockNumber: Int,
        contractAddress: Address,
        from: Address,
        to: Address,
        tokenID: BigUInt,
        tokenValue: Int,
        tokenName: String,
        tokenSymbol: String
    ) {
        self.hash = hash
        self.blockNumber = blockNumber
        self.contractAddress = contractAddress
        self.from = from
        self.to = to
        self.tokenID = tokenID
        self.tokenValue = tokenValue
        self.tokenName = tokenName
        self.tokenSymbol = tokenSymbol

        super.init()
    }

    override class var databaseTableName: String {
        "eip1155Events"
    }

    enum Columns: String, ColumnExpression {
        case hash
        case blockNumber
        case contractAddress
        case from
        case to
        case tokenID
        case tokenValue
        case tokenName
        case tokenSymbol
    }

    required init(row: Row) throws {
        hash = row[Columns.hash]
        blockNumber = row[Columns.blockNumber]
        contractAddress = Address(raw: row[Columns.contractAddress])
        from = Address(raw: row[Columns.from])
        to = Address(raw: row[Columns.to])
        tokenID = row[Columns.tokenID]
        tokenValue = row[Columns.tokenValue]
        tokenName = row[Columns.tokenName]
        tokenSymbol = row[Columns.tokenSymbol]

        try super.init(row: row)
    }

    override func encode(to container: inout PersistenceContainer) throws {
        container[Columns.hash] = hash
        container[Columns.blockNumber] = blockNumber
        container[Columns.contractAddress] = contractAddress.raw
        container[Columns.from] = from.raw
        container[Columns.to] = to.raw
        container[Columns.tokenID] = tokenID
        container[Columns.tokenValue] = tokenValue
        container[Columns.tokenName] = tokenName
        container[Columns.tokenSymbol] = tokenSymbol
    }
}
