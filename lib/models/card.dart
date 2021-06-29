class Card {
  late String cardNum;
  late String cvv;
  late String expiryMonth;
  late String expiryYear;

  Card(String cardNum, String expiryMonth, String expiryYear, String cvv) {
    this.cardNum = cardNum;
    this.expiryMonth = expiryMonth;
    this.expiryYear = expiryYear;
    this.cvv = cvv;
  }

  Map<String, dynamic> toJSON() => {
        "cardNum": cardNum,
        "cardExpiry": {"month": expiryMonth, "year": expiryYear},
        "cvv": cvv
      };
}
