part of 'payment_collection_bloc.dart';

abstract class PaymentCollectionEvent extends Equatable {
  const PaymentCollectionEvent();
  @override
  List<Object?> get props => [];
}
class GetInvoicesFromDB extends PaymentCollectionEvent {
  const GetInvoicesFromDB(
      {required this.customerId,
      });

  final int customerId;


  @override
  List<Object> get props => [customerId];
}
class AddCollectedPayment extends PaymentCollectionEvent {
  const AddCollectedPayment(
      {required this.invoiceStatement,
      });

  final InvoiceStatementItem invoiceStatement;


  @override
  List<Object> get props => [invoiceStatement];
}
class GetLatestInvoiceStatement extends PaymentCollectionEvent {
  const GetLatestInvoiceStatement(
      {required this.invoiceId,
      });

  final int invoiceId;


  @override
  List<Object> get props => [invoiceId];
}
