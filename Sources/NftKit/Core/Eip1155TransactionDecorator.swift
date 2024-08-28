//
//  Eip1155TransactionDecorator.swift
//  NftKit
//
//  Created by Sun on 2024/8/21.
//

import Foundation

import BigInt
import EvmKit

// MARK: - Eip1155TransactionDecorator

class Eip1155TransactionDecorator {
    private let userAddress: Address

    init(userAddress: Address) {
        self.userAddress = userAddress
    }
}

// MARK: ITransactionDecorator

extension Eip1155TransactionDecorator: ITransactionDecorator {
    public func decoration(
        from: Address?,
        to: Address?,
        value: BigUInt?,
        contractMethod: ContractMethod?,
        internalTransactions _: [InternalTransaction],
        eventInstances: [ContractEventInstance]
    ) -> TransactionDecoration? {
        guard let from, let to else {
            return nil
        }

        if let transferMethod = contractMethod as? Eip1155SafeTransferFromMethod {
            if from == userAddress {
                return Eip1155SafeTransferFromDecoration(
                    contractAddress: to,
                    to: transferMethod.to,
                    tokenId: transferMethod.tokenId,
                    value: transferMethod.value,
                    sentToSelf: transferMethod.to == userAddress,
                    tokenInfo: eventInstances.compactMap { $0 as? Eip1155TransferEventInstance }
                        .first { $0.contractAddress == to }?.tokenInfo
                )
            }
        }

        if let method = contractMethod as? Eip1155SetApprovalForAllMethod {
            if from == userAddress {
                return Eip1155SetApprovalForAllDecoration(
                    contractAddress: to,
                    operator: method.operator,
                    approved: method.approved
                )
            }
        }

        return nil
    }
}
