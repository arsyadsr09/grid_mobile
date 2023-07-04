import 'package:flutter/material.dart';
import 'package:grid_mobile/models/transaction_model.dart';
import './latest_transactions.dart';

abstract class LatestTransactionsViewModel extends State<LatestTransactions> {
  List<TransactionModel> transactions = [
    TransactionModel(
        id: "1",
        datetime: 1687508546096,
        type: 'in',
        value: 250000,
        info: "Top up e-wallet"),
    TransactionModel(
        id: "2",
        datetime: 1687508546096,
        type: 'out',
        value: 20000,
        info: "Indomaret Rest Area 51"),
    TransactionModel(
        id: "3",
        datetime: 1687508546096,
        type: 'in',
        value: 350000,
        info: "Top up e-wallet"),
    TransactionModel(
        id: "4",
        datetime: 1687508546096,
        type: 'out',
        value: 60000,
        info: "Hotel Nata Segara Banyuwangi"),
  ];
}
