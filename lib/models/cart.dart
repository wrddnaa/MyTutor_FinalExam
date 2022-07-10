class cart {
  String? cartid;
  String? subjectName;
  String? price;
  String? cartqty;
  String? subjectID;
  String? subjectSessions;
  String? subjectRating;

  cart(
      {this.cartid,
      this.subjectName,
      this.price,
      this.cartqty,
      this.subjectID,
      this.subjectSessions,
      this.subjectRating});

  cart.fromJson(Map<String, dynamic> json) {
    cartid = json['cart_id'];
    subjectName = json['subject_name'];
    price = json['price'];
    cartqty = json['cart_qty'];
    subjectID = json['subject_id'];
    subjectSessions = json['subject_sessions'];
    subjectRating = json['subject_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_id'] = cartid;
    data['subject_name'] = subjectName;
    data['price'] = price;
    data['cart_qty'] = cartqty;
    data['subject_id'] = subjectID;
    data['subject_sessions'] = subjectSessions;
    data['subject_rating'] = subjectRating;
    return data;
  }
}