// ignore_for_file: prefer_final_fields, file_names, empty_catches, use_build_context_synchronously, unused_local_variable, avoid_print, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pos/models/products/unit-model.dart';

import '../../../api-helpers/services-endpoints.dart';
import 'package:http/http.dart' as http;

class UnitProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  TextEditingController searchController =
      TextEditingController(); // For Search

  // TextEditingController unitAddController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  List<UnitModel> _unitList = [];
  List<UnitModel> _filterUnitList = [];

  List<UnitModel> get unitList => _unitList;
  List<UnitModel> get filterUnitList => _filterUnitList;

  bool _isEdit = false;
  bool get isEdit => _isEdit;

  UnitModel? _unitModel;
  UnitModel? get unitModel => _unitModel;

  void setEditModel(UnitModel model) {
    _unitModel = model;
    _isEdit = true;
    unitController.text = model.unitName ?? '';
    notifyListeners();
  }

  Future<void> addUnit(String unitName, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final url = Uri.parse('${SEP.BASE_URL}${SEP.addUnit}unit_name=$unitName');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Unit added successfully")));
        // await fetchCategory();
        await fetchUnits();
        unitController.clear();
        // categoryController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add unit: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUnits() async {
    _isLoading = false;
    notifyListeners();

    try {
      String unitsUrl = '${SEP.BASE_URL}${SEP.unitList}';
      final response = await http.get(Uri.parse(unitsUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List units = data['response']['units'];
        _unitList = units.map((e) => UnitModel.fromJson(e)).toList();
        _filterUnitList = List.from(_unitList);
      } else {
        print("Failed to fetch unit : ${response.statusCode}");
      }
    } catch (e) {
      print('Error fetching unit: ${e}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearEditState() {
    _unitModel = null;
    _isEdit = false;
    unitController.clear();
    notifyListeners();
  }

  void filterUnits(String query) {
    if (query.isEmpty) {
      _filterUnitList = List.from(_unitList);
    } else {
      _filterUnitList = _unitList.where((unit) {
        final unitName = unit.unitName?.toLowerCase();
        return unitName!.contains(query.toLowerCase());
      }).toList();
      notifyListeners();
    }
  }

  //clear search and reset filter
  void clearSearch() {
    searchController.clear();
    _filterUnitList = List.from(_unitList);
    notifyListeners();
  }

  Future<bool> updateUnit(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    bool success = false;
    try {
      // 🔹 Optimistic update (update local state first)
      if (_unitModel != null) {
        final index = _unitList.indexWhere((u) => u.id == _unitModel!.id);
        if (index != -1) {
          _unitList[index] = UnitModel(
            id: _unitModel!.id,
            unitName: unitController.text, // updated value
            status: _unitModel!.status, // keep existing status
          );
          _filterUnitList = List.from(_unitList);
          notifyListeners();
        }
      }

      // 🔹 API call
      final updateUrl =
          '${SEP.BASE_URL}${SEP.updateUnit}id=${unitModel?.id}&unit_name=${unitController.text}';

      final response = await http.post(Uri.parse(updateUrl));

      if (response.statusCode == 200) {
        success = true;
        print("Update success: ${response.body}");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Unit updated successfully")),
        );

        // Optional: re-fetch to stay in sync with backend
        await fetchUnits();
        clearSearch();
      } else {
        print("Update failed: ${response.statusCode} - ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to update Unit: ${response.statusCode}"),
          ),
        );
      }
    } catch (e) {
      print("Error updating Unit : $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error Updating Unit : $e")));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return success;
  }
}
