// // ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, file_names, deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:pos/models/customer/customer-model.dart';
// import 'package:pos/view/user-panel/customer-ui/add-customer.dart';
// import 'package:provider/provider.dart';

// import '../../../providers/cusomters/add-customer-provider.dart';
// import '../../../providers/cusomters/customers-provider.dart';

// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, file_names, deprecated_member_use, use_build_context_synchronously, unused_import, must_be_immutable

import 'package:flutter/material.dart';
import 'package:pos/models/customer/customer-model.dart';
import 'package:pos/view/user-panel/customer-ui/add-customer.dart';
import 'package:provider/provider.dart';

import '../../../providers/cusomters/add-update-customer-provider.dart';
import '../../../providers/cusomters/fetch-customers-provider.dart';

class CustomerProfile extends StatefulWidget {
  final String customerId; // 👈 only pass ID, not whole model
  String? creditBalance;
  CustomerProfile({required this.customerId, this.creditBalance});

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  bool isCredit = false;

  @override
  void initState() {
    super.initState();
    // fetch fresh customer details by ID
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CustomerProvider>(
        context,
        listen: false,
      ).customerById(widget.customerId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final provider = Provider.of<CustomerProvider>(context);
    isCredit = widget.creditBalance != null ? true : false;

    final customer = provider.selectedCustomer;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Customer Profile",
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
        ),
        body: customer == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Divider(thickness: 1.5),
                    SizedBox(height: mq.height * 0.02),
                    Center(
                      child: Card(
                        elevation: 7,
                        shape: CircleBorder(),
                        color: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 60,
                          child: Text(
                            customer.customerName?.isNotEmpty == true
                                ? customer.customerName![0]
                                : 'N',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: mq.height * 0.02),
                    _buildRow(
                      mIcon: Icons.person,
                      iconSize: 35,
                      iColor: Colors.black.withOpacity(0.6),
                      mText: customer.customerName ?? '',
                      fSize: 18,
                    ),
                    _buildRow(
                      mIcon: Icons.phone,
                      iconSize: 35,
                      iColor: Colors.black.withOpacity(0.6),
                      mText: customer.customerMobile ?? '',
                      fSize: 18,
                    ),
                    _buildRow(
                      mIcon: Icons.location_on,
                      iconSize: 35,
                      iColor: Colors.black.withOpacity(0.6),
                      mText: customer.customerAddress ?? '',
                      fSize: 18,
                    ),
                    SizedBox(height: 10),
                    Visibility(
                      visible: isCredit,
                      child: _buildRow(
                        mIcon: Icons.currency_pound_rounded,
                        iconSize: 35,
                        iColor: Colors.red,
                        mText: widget.creditBalance ?? '',
                        fSize: 18,
                        fColor: Colors.red,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(thickness: 1.5),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'MORE INFO',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangeNotifierProvider(
                                    create: (_) => AddCustomerProvider(
                                      customerModel: customer,
                                      editMode: true,
                                    ),
                                    child: AddCustomer(
                                      customerModel: customer,
                                      isEdit: true,
                                    ),
                                  ),
                                ),
                              ).then((result) {
                                if (result == true) {
                                  // 👇 re-fetch customer details after editing
                                  Provider.of<CustomerProvider>(
                                    context,
                                    listen: false,
                                  ).customerById(widget.customerId);
                                }
                              });
                            },
                            child: Text(
                              'EDIT PROFILE',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'VIEW PURCHASE HISTORY',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildRow({
    IconData? mIcon,
    String? mText,
    double? iconSize,
    double? fSize,
    Color? fColor,
    Color? iColor,
  }) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Icon(mIcon, size: iconSize, color: iColor),
          SizedBox(width: 20),
          Text(
            mText.toString(),
            style: TextStyle(fontSize: fSize, color: fColor),
          ),
        ],
      ),
    );
  }
}

// class CustomerProfile extends StatefulWidget {
//   final CustomerModel? customerModel;
//   CustomerProfile({this.customerModel});

//   @override
//   State<CustomerProfile> createState() => _CustomerProfileState();
// }

// class _CustomerProfileState extends State<CustomerProfile> {
//   @override
//   Widget build(BuildContext context) {
//     final mq = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text(
//           "Customer Profile",
//           style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
//         ),
//         // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.edit))],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Divider(thickness: 1.5),
//             SizedBox(height: mq.height * 0.02),
//             Center(
//               child: Card(
//                 elevation: 7,
//                 shape: CircleBorder(),
//                 color: Colors.white,
//                 child: CircleAvatar(
//                   backgroundColor: Colors.white,
//                   radius: 60,
//                   child: Text(
//                     widget.customerModel?.customerName?.isNotEmpty == true
//                         ? widget.customerModel!.customerName![0]
//                         : 'N',
//                     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: mq.height * 0.02),
//             _buildRow(
//               mIcon: Icons.email,
//               iconSize: 35,
//               iColor: Colors.black.withOpacity(0.6),
//               mText: widget.customerModel?.customerName ?? '',
//               fSize: 18,
//             ),
//             SizedBox(height: mq.height * 0.001),
//             _buildRow(
//               mIcon: Icons.phone,
//               iconSize: 35,
//               iColor: Colors.black.withOpacity(0.6),
//               mText: widget.customerModel?.customerMobile ?? '',
//               fSize: 18,
//             ),
//             SizedBox(height: mq.height * 0.001),
//             _buildRow(
//               mIcon: Icons.location_on,
//               iconSize: 35,
//               iColor: Colors.black.withOpacity(0.6),
//               mText: widget.customerModel?.customerAddress ?? '',
//               fSize: 18,
//             ),
//             SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Divider(thickness: 1.5),
//                   TextButton(
//                     onPressed: () {},
//                     child: Text(
//                       'MORE INFO',
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 18,
//                         // fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: mq.height * 0.001),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ChangeNotifierProvider(
//                             create: (_) => AddCustomerProvider(
//                               customerModel: widget
//                                   .customerModel, // pass existing customer
//                               editMode: true,
//                             ),
//                             child: AddCustomer(
//                               customerModel: widget.customerModel,
//                               isEdit: true,
//                             ),
//                           ),
//                         ),
//                       ).then((result) {
//                         if (result == true) {
//                           // 👇 refresh customers when coming back
//                           Provider.of<CustomerProvider>(
//                             context,
//                             listen: false,
//                           ).fetchCustomers();
//                         }
//                       });

//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (context) => ChangeNotifierProvider(
//                       //       create: (_) => AddCustomerProvider(
//                       //         customerModel: widget
//                       //             .customerModel, // pass existing customer
//                       //         editMode: true,
//                       //       ),
//                       //       child: AddCustomer(
//                       //         customerModel: widget.customerModel,
//                       //         isEdit: true,
//                       //       ),
//                       //     ),
//                       //   ),
//                       // );
//                     },
//                     child: Text(
//                       'EDIT PROFILE',
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 18,
//                         // fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: mq.height * 0.001),
//                   TextButton(
//                     onPressed: () {},
//                     child: Text(
//                       'VIEW PURCHASE HISTORY',
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 18,
//                         // fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildRow({
//     IconData? mIcon,
//     String? mText,
//     double? iconSize,
//     double? fSize,
//     Color? fColor,
//     Color? iColor,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Row(
//         children: [
//           Icon(mIcon, size: iconSize, color: iColor),
//           SizedBox(width: 20),
//           Text(
//             mText.toString(),
//             style: TextStyle(fontSize: fSize, color: fColor),
//           ),
//         ],
//       ),
//     );
//   }
// }
