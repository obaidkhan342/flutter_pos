//  ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages, file_names, avoid_print

// ignore_for_file: prefer_final_fields, unused_import, unused_local_variable, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pos/api-helpers/services-endpoints.dart';
import 'package:pos/models/customer/customer-model.dart';
import 'package:http/http.dart' as http;

enum CustomerFilter { all, credit, paid }

class CustomerProvider extends ChangeNotifier {
  // String url = '${SEP.BASE_URL}${SEP.customersList}';
  List<CustomerModel> _customersList = [];
  List<CustomerModel> _filterCustomers = [];
  bool _isLoading = false;
  String? _errorMessage;

  // for profile screen
  List<CustomerModel> get customerList => _customersList;
  List<CustomerModel> get filterCustomer => _filterCustomers;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // which list should call
  CustomerFilter _currentFilter = CustomerFilter.all;
  CustomerFilter get currentFilter => _currentFilter;

  // 👇 Setter for filter
  void setFilter(CustomerFilter filter) {
    _currentFilter = filter;
    fetchCustomers(); // reload based on filter
    // applyFilter();
    notifyListeners();
  }

  void applyFilter() {
    switch (_currentFilter) {
      case CustomerFilter.all:
        _filterCustomers = List.from(_customersList);
        break;
      case CustomerFilter.credit:
        _filterCustomers = _customersList
            .where((c) => c.customerBalance != null && c.customerBalance != "0")
            .toList();
        break;
      case CustomerFilter.paid:
        _filterCustomers = _customersList
            .where((c) => c.customerBalance == null || c.customerBalance == "0")
            .toList();
        break;
    }
  }

  // Fetch customers API
  Future<void> fetchCustomers() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    String url;

    switch (_currentFilter) {
      case CustomerFilter.all:
        url = '${SEP.BASE_URL}${SEP.customersList}';
        break;
      case CustomerFilter.credit:
        url = '${SEP.BASE_URL}${SEP.creditCustomerApi}';
        break;
      case CustomerFilter.paid:
        url = '${SEP.BASE_URL}${SEP.paidCustomersApi}';
        break;
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List customers = data['response']['customers'];
        _customersList = customers
            .map((e) => CustomerModel.fromJson(e))
            .toList();
        _filterCustomers = List.from(_customersList);
        print(response.body);
      } else {
        _errorMessage = 'Failed to Load Customers ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = "Error fetching customers: $e";
    }
    _isLoading = false;
    notifyListeners();
  }

  CustomerModel? _selectedCustomer;
  CustomerModel? get selectedCustomer => _selectedCustomer;

  //customer fetch by id
  Future<void> customerById(String id) async {
    String eUrl = '${SEP.BASE_URL}${SEP.editCustomer}id=$id';
    try {
      final response = await http.get(Uri.parse(eUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final customerData = data['response']['customers'];
        _selectedCustomer = CustomerModel.fromJson(customerData);
        notifyListeners();
      } else {
        throw Exception("Failed to load customer details");
      }
    } catch (e) {
      debugPrint("Error fetching customer by id: $e");
    }
  }

  //search customers by query
  void filterCustomers(String query) {
    if (query.isEmpty) {
      _filterCustomers = List.from(_customersList);
    } else {
      _filterCustomers = _customersList.where((customer) {
        final name = customer.customerName?.toLowerCase() ?? '';
        // final address = customer.customerAddress.toLowerCase() ?? '';
        final phone = customer.customerMobile?.toLowerCase() ?? '';
        final email = customer.customerMobile?.toLowerCase() ?? '';
        return name.contains(query.toLowerCase()) ||
            phone.contains(query.toLowerCase()) ||
            email.contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  //delete customer
  Future<void> deleteCustomer({
    String? uId,
    required BuildContext context,
  }) async {
    String deleteUrl = '${SEP.BASE_URL}${SEP.deleteCustomer}id=$uId';
    try {
      final response = await http.get(Uri.parse(deleteUrl));
      if (response.statusCode == 200) {
        fetchCustomers();
        // ScaffoldMessenger.of(context)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Customer deleted successfully!'),
            duration: Duration(seconds: 2), // how long it stays
            backgroundColor: Colors.lightBlue, // optional
          ),
        );

        print("user deleted successfully");
      } else {
        print("Error : ${response.statusCode}");
      }
    } catch (e) {
      print("Error : $e");
    }
  }

  void clearSearch() {
    _filterCustomers = List.from(_customersList);
    notifyListeners();
  }
}
