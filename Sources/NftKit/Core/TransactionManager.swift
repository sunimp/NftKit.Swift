//
//  TransactionManager.swift
//  NftKit
//
//  Created by Sun on 2024/8/21.
//

import Foundation

import BigInt
import EvmKit

// MARK: - TransactionManager

class TransactionManager {
    private let address: Address

    init(evmKit: EvmKit.Kit) {
        address = evmKit.receiveAddress
    }
}

extension TransactionManager {
    func transferEip721TransactionData(contractAddress: Address, to: Address, tokenId: BigUInt) -> TransactionData {
        TransactionData(
            to: contractAddress,
            value: BigUInt.zero,
            input: Eip721SafeTransferFromMethod(from: address, to: to, tokenId: tokenId, data: Data()).encodedABI()
        )
    }

    func transferEip1155TransactionData(
        contractAddress: Address,
        to: Address,
        tokenId: BigUInt,
        value: BigUInt
    ) -> TransactionData {
        TransactionData(
            to: contractAddress,
            value: BigUInt.zero,
            input: Eip1155SafeTransferFromMethod(from: address, to: to, tokenId: tokenId, value: value, data: Data()).encodedABI()
        )
    }
}
