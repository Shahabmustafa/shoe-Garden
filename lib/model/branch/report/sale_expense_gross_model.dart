class SaleExpenseGrossModel {
  bool? success;
  dynamic? error;
  List<Body>? body;

  SaleExpenseGrossModel({this.success, this.error, this.body});

  SaleExpenseGrossModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    if (json['body'] != null) {
      body = <Body>[];
      json['body'].forEach((v) {
        body!.add(new Body.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.body != null) {
      data['body'] = this.body!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Body {
  String? date;
  int? sale;
  int? expense;
  int? gross;
  int? cashPaidToAdmin;
  int? difference;
  int? cashSale;
  int? cardPayment;

  Body(
      {this.date,
        this.sale,
        this.expense,
        this.gross,
        this.cashPaidToAdmin,
        this.difference,
        this.cashSale,
        this.cardPayment});

  Body.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    sale = json['sale'];
    expense = json['expense'];
    gross = json['gross'];
    cashPaidToAdmin = json['cash_paid_to_admin'];
    difference = json['difference'];
    cashSale = json['cash_sale'];
    cardPayment = json['card_payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['sale'] = this.sale;
    data['expense'] = this.expense;
    data['gross'] = this.gross;
    data['cash_paid_to_admin'] = this.cashPaidToAdmin;
    data['difference'] = this.difference;
    data['cash_sale'] = this.cashSale;
    data['card_payment'] = this.cardPayment;
    return data;
  }
}
