//
//  Eip1155TransactionSyncer.swift
//  NftKit
//
//  Created by Sun on 2024/8/21.
//

import Foundation

import BigInt
import EvmKit

// MARK: - Eip1155TransactionSyncer

class Eip1155TransactionSyncer {
    private let provider: ITransactionProvider
    private let storage: Storage

    weak var delegate: ITransactionSyncerDelegate? = nil

    init(provider: ITransactionProvider, storage: Storage) {
        self.provider = provider
        self.storage = storage
    }

    private func handle(transactions: [ProviderEip1155Transaction]) {
        guard !transactions.isEmpty else {
            return
        }

        let events = transactions.map { tx in
            Eip1155Event(
                hash: tx.hash,
                blockNumber: tx.blockNumber,
                contractAddress: tx.contractAddress,
                from: tx.from,
                to: tx.to,
                tokenID: tx.tokenID,
                tokenValue: tx.tokenValue,
                tokenName: tx.tokenName,
                tokenSymbol: tx.tokenSymbol
            )
        }

        try? storage.save(eip1155Events: events)

        let nfts = Set<Nft>(events.map { event in
            Nft(
                type: .eip1155,
                contractAddress: event.contractAddress,
                tokenID: event.tokenID,
                tokenName: event.tokenName
            )
        })

        delegate?.didSync(nfts: Array(nfts), type: .eip1155)
    }
}

// MARK: ITransactionSyncer

extension Eip1155TransactionSyncer: ITransactionSyncer {
    func transactions() async throws -> ([Transaction], Bool) {
        let lastBlockNumber = try storage.lastEip1155Event()?.blockNumber ?? 0
        let initial = lastBlockNumber == 0

        do {
            let transactions = try await provider.eip1155Transactions(startBlock: lastBlockNumber + 1)

            handle(transactions: transactions)

            let array = transactions.map { tx in
                Transaction(
                    hash: tx.hash,
                    timestamp: tx.timestamp,
                    isFailed: false,
                    blockNumber: tx.blockNumber,
                    transactionIndex: tx.transactionIndex,
                    nonce: tx.nonce,
                    gasPrice: tx.gasPrice,
                    gasLimit: tx.gasLimit,
                    gasUsed: tx.gasUsed
                )
            }

            return (array, initial)
        } catch {
            return ([], initial)
        }
    }
}
