// ignore_for_file: unused_local_variable, unused_import, use_build_context_synchronously, file_names, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:pos/models/customer/customer-model.dart';
import 'package:pos/page-and-routes/routes-name.dart';
import 'package:pos/providers/cusomters/add-update-customer-provider.dart';
import 'package:pos/widgets/login/addCustomerTextField.dart';
import 'package:provider/provider.dart';

class AddCustomer extends StatefulWidget {
  CustomerModel? customerModel;
  bool? isEdit;
  AddCustomer({this.customerModel, this.isEdit = false});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  @override
  Widget build(BuildContext context) {
    final addProvider = Provider.of<AddCustomerProvider>(context);
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Create customer",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              addProvider.editMode!
                  ? await addProvider.updateCustomer(context: context)
                  : await addProvider.addCustomer(
                      context: context,
                      customerName: addProvider.cNameController.text,
                      customerAddress: addProvider.cAddressController.text,
                      customerPhone: addProvider.cPhoneController.text,
                      customerEmail: addProvider.cEmail1Controller.text,
                      customerPreviousBalance:
                          addProvider.cCustomerBalance.text,
                    );
              addProvider.clearControllers();
              Navigator.pop(context, true);
              // Navigator.pushNamed(context, RoutesName.customerScreen);
            },
            child: addProvider.isLoading
                ? CircularProgressIndicator()
                : addProvider.editMode!
                ? Text(
                    "update",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      fontSize: 18,
                    ),
                  )
                : Text(
                    "SAVE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      fontSize: 18,
                    ),
                  ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: mq.height * 0.02),
              addCustomerTextField(
                context: context,
                name: 'Customer Name',
                myIcon: Icons.person_2_outlined,
                iconSize: 35,
                controller: addProvider.cNameController,

                // prefixIcon: Icon(Icons.person),
              ),

              SizedBox(height: mq.height * 0.02),
              addCustomerTextField(
                context: context,
                name: 'Customer Email',
                myIcon: Icons.email,
                iconSize: 32,
                controller: addProvider.cEmail1Controller,

                // prefixIcon: Icon(Icons.person),
              ),
              SizedBox(height: mq.height * 0.02),
              addCustomerTextField(
                context: context,
                name: 'Mobile No',
                myIcon: Icons.contact_page_outlined,
                iconSize: 32,
                controller: addProvider.cMobileController,
                // prefixIcon: Icon(Icons.person),
              ),
              SizedBox(height: mq.height * 0.02),
              addCustomerTextField(
                context: context,
                name: 'Primary Address',
                myIcon: Icons.location_on_outlined,
                iconSize: 32,
                controller: addProvider.cAddressController,
                // : 2,
                // prefixIcon: Icon(Icons.person),
              ),
              SizedBox(height: mq.height * 0.02),
              addCustomerTextField(
                context: context,
                name: 'Second Email',
                myIcon: Icons.email,
                iconSize: 32,
                controller: addProvider.cEmail2Controller,
                // prefixIcon: Icon(Icons.person),
              ),

              SizedBox(height: mq.height * 0.02),
              addCustomerTextField(
                context: context,
                name: 'Contact',
                myIcon: Icons.contact_page,
                iconSize: 32,
                controller: addProvider.cContactController,
                // prefixIcon: Icon(Icons.person),
              ),
              SizedBox(height: mq.height * 0.02),
              addCustomerTextField(
                context: context,
                name: 'Phone',
                myIcon: Icons.phone,
                iconSize: 32,
                controller: addProvider.cPhoneController,
                // prefixIcon: Icon(Icons.person),
              ),
              SizedBox(height: mq.height * 0.02),
              addCustomerTextField(
                context: context,
                name: 'Fax',
                myIcon: Icons.fax_outlined,
                iconSize: 32,
                controller: addProvider.cFaxController,
                // prefixIcon: Icon(Icons.person),
              ),

              SizedBox(height: mq.height * 0.02),
              addCustomerTextField(
                context: context,
                name: 'Secondary Address',
                myIcon: Icons.location_on_outlined,
                noOfLine: 2,
                iconSize: 32,
                controller: addProvider.cAddress2Controller,
                // prefixIcon: Icon(Icons.person),
              ),
              SizedBox(height: mq.height * 0.02),
              addCustomerTextField(
                context: context,
                name: 'City',
                myIcon: Icons.home,
                // noOfLine: 2,
                iconSize: 32,
                controller: addProvider.cCityController,
                // prefixIcon: Icon(Icons.person),
              ),
              SizedBox(height: mq.height * 0.02),
              addCustomerTextField(
                context: context,
                name: 'State',
                myIcon: Icons.location_city,
                // noOfLine: 2,
                iconSize: 32,
                controller: addProvider.cStateController,
                // prefixIcon: Icon(Icons.person),
              ),
              SizedBox(height: mq.height * 0.02),
              addCustomerTextField(
                context: context,
                name: 'Zip Code',
                myIcon: Icons.place,
                // noOfLine: 2,
                iconSize: 32,
                controller: addProvider.cZipController,
                // prefixIcon: Icon(Icons.person),
              ),
              SizedBox(height: mq.height * 0.02),
              addCustomerTextField(
                context: context,
                name: 'Country',
                myIcon: Icons.public,
                // noOfLine: 2,
                iconSize: 32,
                controller: addProvider.cCountryController,
                // prefixIcon: Icon(Icons.person),
              ),
              SizedBox(height: mq.height * 0.02),

              addCustomerTextField(
                context: context,
                name: 'Previous Balance',
                myIcon: Icons.money,
                // noOfLine: 2,
                iconSize: 32,
                controller: addProvider.cCustomerBalance,
                // prefixIcon: Icon(Icons.person),
              ),
              SizedBox(height: mq.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
