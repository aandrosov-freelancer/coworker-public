enum AccountType {
  performer,
  customer;

  bool get isCustomer => this == AccountType.customer;
  bool get isPerformer => this == AccountType.performer;
}
