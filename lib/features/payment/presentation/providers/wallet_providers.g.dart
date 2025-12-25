// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userWalletHash() => r'87db8b9fc132d1bbd5d0871bee467041f0915e67';

/// See also [UserWallet].
@ProviderFor(UserWallet)
final userWalletProvider =
    AutoDisposeNotifierProvider<UserWallet, WalletEntity>.internal(
  UserWallet.new,
  name: r'userWalletProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userWalletHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserWallet = AutoDisposeNotifier<WalletEntity>;
String _$walletTransactionsHash() =>
    r'c5d393d48ee63c3fa8c92c67299e0be80f47c4e8';

/// See also [WalletTransactions].
@ProviderFor(WalletTransactions)
final walletTransactionsProvider = AutoDisposeNotifierProvider<
    WalletTransactions, List<TransactionEntity>>.internal(
  WalletTransactions.new,
  name: r'walletTransactionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$walletTransactionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WalletTransactions = AutoDisposeNotifier<List<TransactionEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
