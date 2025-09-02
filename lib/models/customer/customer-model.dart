// ignore_for_file: unnecessary_question_mark, file_names

class CustomerModel {
  String? customerId;
  String? customerName;
  String? customerAddress;
  String? address2;
  String? customerMobile;
  String? customerEmail;
  String? emailAddress;
  String? contact;
  String? phone;
  String? fax;
  String? city;
  String? state;
  String? zip;
  String? country;
  String? status;
  dynamic? createdDate;
  String? createBy;
  String? customerBalance;

  CustomerModel({
    this.customerId,
    this.customerName,
    this.customerAddress,
    this.address2,
    this.customerMobile,
    this.customerEmail,
    this.emailAddress,
    this.contact,
    this.phone,
    this.fax,
    this.city,
    this.state,
    this.zip,
    this.country,
    this.status,
    this.createdDate,
    this.createBy,
    this.customerBalance,
  });
  CustomerModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    customerAddress = json['customer_address'];
    address2 = json['address2'];
    customerMobile = json['customer_mobile'];
    customerEmail = json['customer_email'];
    emailAddress = json['email_address'];
    contact = json['contact'];
    phone = json['phone'];
    fax = json['fax'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    country = json['country'];
    status = json['status'];
    createdDate = json['create_date'];
    createBy = json['create_by'];
    customerBalance = json['customer_balance'];
  }
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_id'] = customerId;
    data['customer_name'] = customerName;
    data['customer_address'] = customerAddress;
    data['address2'] = address2;
    data['customer_mobile'] = customerMobile;
    data['customer_email'] = customerEmail;
    data['email_address'] = emailAddress;
    data['contact'] = contact;
    data['phone'] = phone;
    data['fax'] = fax;
    data['city'] = city;
    data['state'] = state;
    data['zip'] = zip;
    data['country'] = country;
    data['status'] = status;
    data['create_date'] = createdDate;
    data['create_by'] = createBy;
    data['customer_balance'] = customerBalance;
    return data;
  }
}

// {
// "customer_id":"109",
// "customer_name":null,
// "customer_address":null,
// "address2":"",
// "customer_mobile":null,
// "customer_email":null,
// "email_address":null,
// "contact":null,
// "phone":null,
// "fax":null,
// "city":null,
// "state":null,
// "zip":null,
// "country":null,
// "status":"1",
// "create_date":"2025-08-2201:27:12",
// "create_by":null,
// "customer_balance":"0.00"
// }
