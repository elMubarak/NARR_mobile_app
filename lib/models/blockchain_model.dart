class BlockchainDtails {
  final String privateKey;
  final String publicKey;
  final num blockChaintokens;
  final String gasBalance;

  BlockchainDtails({
    this.privateKey,
    this.publicKey,
    this.blockChaintokens,
    this.gasBalance,
  });

  factory BlockchainDtails.fromJson(Map<String, dynamic> data) {
    return BlockchainDtails(
      privateKey: data['privateKey'] as String,
      publicKey: data['publicKey'] as String,
      blockChaintokens: data['tokens'] as num,
      gasBalance: data['gasBalancre'] as String,
    );
  }
}
