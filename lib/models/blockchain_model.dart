class BlockchainDetails {
  final num blockChainTokens;
  final num gasBalance;

  BlockchainDetails({
    this.blockChainTokens = 0,
    this.gasBalance = 0,
  });

  factory BlockchainDetails.fromJson(Map<String, dynamic> data) {
    return BlockchainDetails(
      blockChainTokens: data['tokens'] as num,
      gasBalance: data['gasBalancre'] as num,
    );
  }
}
