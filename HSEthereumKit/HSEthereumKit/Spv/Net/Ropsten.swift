class Ropsten: INetwork {

    let id = 3
    let genesisBlockHash = Data(hex: "41941023680923e0fe4d74a34bdac8141f2540e3ae90623718e47d66d1ca4a2d")

    let checkpointBlock = BlockHeader(
            hashHex: Data(hex: "195689d4f1d1095465f1e887a9c9055c9baf0da838e3e630aa01105448ae6e8b"),
            totalDifficulty: BInt("18529791467262594")!,
            parentHash: Data(hex: "20e8c8b14f38c813f1e48fbb77cf9cb9ebe9205de165a4c46efdf588f10db332"),
            unclesHash: Data(hex: "1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347"),
            coinbase: Data(hex: "635b4764d1939dfacd3a8014726159abc277becc"),
            stateRoot: Data(hex: "8c8195a0a9c1a7b45c25667bd56c6b915405598b0843337025988f5c11b5aca9"),
            transactionsRoot: Data(hex: "2de3887602ee9f7745567450f616d08559d3247f4bc313046135969a274a6e7e"),
            receiptsRoot: Data(hex: "92011c4e13f917275c6470e17e128c6a13eb8276783c6d036e69ffdcf0f86b60"),
            logsBloom: Data(hex: "04000000000000000000100c00000000000000000000001000000000000400000120000000000000001000000410000400000000420000800000000000140180000000000420600800000008000204000000200000040400000000001000000000020000020000040000010000000800800800080020400000000010000000000000002000000000000000000040a000000000400100000000000044000000800000800000000000000081000000000020000000008000040000400000004040000000020000800000000000040041280000000100020000000000000000600000000000040000410000008000000028000000000081008c0000001000000000"),
            difficulty: BInt("1721287811")!,
            height: BInt(5194692),
            gasLimit: 8000029,
            gasUsed: 7770902,
            timestamp: 1552472262,
            extraData: Data(hex: "de8302020b8f5061726974792d457468657265756d86312e33322e30826c69"),
            mixHash: Data(hex: "6c707002af871c882a136df311be4c8d374dacb44029ba3d075fe6d4ecf487a1"),
            nonce: Data(hex: "dac1087b226b6abb")
    )

    let coinType = UInt32(1)
    let privateKeyPrefix: UInt32 = 0x04358394
    let publicKeyPrefix: UInt32 = 0x043587cf

}
