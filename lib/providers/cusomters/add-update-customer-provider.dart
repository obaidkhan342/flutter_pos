// ignore_for_file: unused_local_variable, avoid_print, use_build_context_synchronously, file_names, unnecessary_brace_in_string_interps, unused_import

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pos/api-helpers/services-endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:pos/models/customer/customer-model.dart';
import 'package:pos/providers/cusomters/fetch-customers-provider.dart';
import 'package:provider/provider.dart';

import '../../page-and-routes/routes-name.dart';

class AddCustomerProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  CustomerModel? customerModel;
  bool? editMode;
  final cNameController = TextEditingController();
  final cAddressController = TextEditingController();
  final cAddress2Controller = TextEditingController();
  final cMobileController = TextEditingController();
  final cEmail1Controller = TextEditingController();
  final cEmail2Controller = TextEditingController();
  final cContactController = TextEditingController();
  final cPhoneController = TextEditingController();
  final cFaxController = TextEditingController();
  final cCityController = TextEditingController();
  final cStateController = TextEditingController();
  final cZipController = TextEditingController();
  final cCountryController = TextEditingController();
  final cStatusController = TextEditingController();
  final cCreatedByController = TextEditingController();
  final cCustomerBalance = TextEditingController();

  AddCustomerProvider({this.customerModel, this.editMode = false}) {
    cNameController.text = customerModel?.customerName ?? '';
    cAddressController.text = customerModel?.customerAddress ?? '';
    cAddress2Controller.text = customerModel?.address2 ?? '';
    cMobileController.text = customerModel?.customerMobile ?? '';
    cEmail1Controller.text = customerModel?.customerEmail ?? '';
    cEmail2Controller.text = customerModel?.emailAddress ?? '';
    cContactController.text = customerModel?.contact ?? '';
    cPhoneController.text = customerModel?.phone ?? '';
    cFaxController.text = customerModel?.fax ?? '';
    cCityController.text = customerModel?.city ?? '';
    cStateController.text = customerModel?.state ?? '';
    cZipController.text = customerModel?.zip ?? '';
    cCountryController.text = customerModel?.country ?? '';
    cStatusController.text = customerModel?.status ?? '';
    cCreatedByController.text = customerModel?.createBy ?? '';
    cCustomerBalance.text = customerModel?.customerBalance ?? '';

    cNameController.addListener(() {
      notifyListeners();
    });
    cAddressController.addListener(() {
      notifyListeners();
    });
    cAddress2Controller.addListener(() {
      notifyListeners();
    });
    cMobileController.addListener(() {
      notifyListeners();
    });
    cEmail1Controller.addListener(() {
      notifyListeners();
    });
    cEmail2Controller.addListener(() {
      notifyListeners();
    });
    cContactController.addListener(() {
      notifyListeners();
    });
    cPhoneController.addListener(() {
      notifyListeners();
    });
    cFaxController.addListener(() {
      notifyListeners();
    });
    cCityController.addListener(() {
      notifyListeners();
    });
    cStateController.addListener(() {
      notifyListeners();
    });
    cZipController.addListener(() {
      notifyListeners();
    });
    cCountryController.addListener(() {
      notifyListeners();
    });
    cStatusController.addListener(() {
      notifyListeners();
    });
    cCreatedByController.addListener(() {
      notifyListeners();
    });
    cCustomerBalance.addListener(() {
      notifyListeners();
    });
  }

  Future<void> addCustomer({
    String? customerName,
    String? customerAddress,
    String? customerPhone,
    String? customerEmail,
    String? customerPreviousBalance,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url =
        '${SEP.BASE_URL}${SEP.addCustomerApi}customer_name=$customerName&address=$customerAddress&mobile=$customerPhone&email=$customerEmail&customer_balance=$customerPreviousBalance';
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 500) {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Customer added successfully")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error : ${response.statusCode}")),
        );
      }
    } catch (e) {
      print("Error: ${e}");
    }
    _isLoading = false;

    notifyListeners();
  }

  Future<void> updateCustomer({required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();

    String url =
        '${SEP.BASE_URL}${SEP.updateCustomerApi}'
        'customer_id=${customerModel?.customerId.toString()}'
        '&oldname=${customerModel?.customerName}'
        '&customer_name=${cNameController.text}'
        '&address=${cAddressController.text}'
        '&mobile=${cMobileController.text}'
        '&email=${cEmail1Controller.text}'
        '&email=${cCustomerBalance.text}';

    try {
      final response = await http.post(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['response']['status'] == 'ok') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                data['response']['message'] ?? "Customer updated successfully",
              ),
            ),
          );

          // Notify previous screen to refresh customer list
          // Navigator.pop(context, true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['response']['message'] ?? "Update failed"),
            ),
          );
        }
      } else {
        // HTTP status not 200
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Server error: ${response.statusCode}")),
        );
      }
    } catch (e) {
      // Only network / parsing errors
      print("Error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error updating customer")));
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearControllers() {
    cNameController.clear();
    cAddressController.clear();
    cAddress2Controller.clear();
    cMobileController.clear();
    cEmail1Controller.clear();
    cEmail2Controller.clear();
    cContactController.clear();
    cPhoneController.clear();
    cFaxController.clear();
    cCityController.clear();
    cStateController.clear();
    cZipController.clear();
    cCountryController.clear();
    cStatusController.clear();
    cCreatedByController.clear();
    cCustomerBalance.clear();
    notifyListeners();
  }
}
