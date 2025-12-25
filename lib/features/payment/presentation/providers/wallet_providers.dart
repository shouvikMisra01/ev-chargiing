import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/payment_entity.dart';
import '../../../../shared/models/enums.dart';

part 'wallet_providers.g.dart';

// Wallet State
@riverpod
class UserWallet extends _$UserWallet {
  @override
  WalletEntity build() {
    return const WalletEntity(
      id: 'wallet1',
      userId: 'user1',
      balance: 500.0, // Mock initial balance
      lastUpdated: null,
    );
  }

  Future<String?> addMoney(double amount) async {
    if (amount <= 0) {
      return 'Invalid amount';
    }

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    state = WalletEntity(
      id: state.id,
      userId: state.userId,
      balance: state.balance + amount,
      lastUpdated: DateTime.now(),
    );

    // Add transaction
    ref.read(walletTransactionsProvider.notifier).addTransaction(
          TransactionEntity(
            id: const Uuid().v4(),
            userId: state.userId,
            amount: amount,
            type: TransactionType.credit,
            description: 'Money added to wallet',
            createdAt: DateTime.now(),
          ),
        );

    return null; // No error
  }

  Future<String?> deductMoney(double amount, String description, {String? bookingId}) async {
    if (amount <= 0) {
      return 'Invalid amount';
    }

    if (state.balance < amount) {
      return 'Insufficient balance';
    }

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    state = WalletEntity(
      id: state.id,
      userId: state.userId,
      balance: state.balance - amount,
      lastUpdated: DateTime.now(),
    );

    // Add transaction
    ref.read(walletTransactionsProvider.notifier).addTransaction(
          TransactionEntity(
            id: const Uuid().v4(),
            userId: state.userId,
            amount: amount,
            type: TransactionType.debit,
            description: description,
            bookingId: bookingId,
            createdAt: DateTime.now(),
          ),
        );

    return null; // No error
  }
}

// Wallet Transactions
@riverpod
class WalletTransactions extends _$WalletTransactions {
  @override
  List<TransactionEntity> build() {
    return _getMockTransactions();
  }

  List<TransactionEntity> _getMockTransactions() {
    final now = DateTime.now();

    return [
      TransactionEntity(
        id: 'txn1',
        userId: 'user1',
        amount: 500.0,
        type: TransactionType.credit,
        description: 'Initial balance',
        createdAt: now.subtract(const Duration(days: 30)),
      ),
      TransactionEntity(
        id: 'txn2',
        userId: 'user1',
        amount: 100.0,
        type: TransactionType.debit,
        description: 'Charging session payment',
        bookingId: 'booking1',
        createdAt: now.subtract(const Duration(days: 5)),
      ),
      TransactionEntity(
        id: 'txn3',
        userId: 'user1',
        amount: 200.0,
        type: TransactionType.credit,
        description: 'Money added to wallet',
        createdAt: now.subtract(const Duration(days: 2)),
      ),
    ];
  }

  void addTransaction(TransactionEntity transaction) {
    state = [transaction, ...state];
  }

  List<TransactionEntity> get creditTransactions {
    return state.where((txn) => txn.type == TransactionType.credit).toList();
  }

  List<TransactionEntity> get debitTransactions {
    return state.where((txn) => txn.type == TransactionType.debit).toList();
  }
}
