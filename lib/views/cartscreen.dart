import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:my_tutor/views/paymentscreen.dart';
import '../constants.dart';
import '../models/cart.dart';
import '../models/user.dart';

class AddToCartScreen extends StatefulWidget{
  final User user;

  const AddToCartScreen({Key? key, required this.user}) : super(key: key);
  
  @override
  State<AddToCartScreen> createState() => _CartScreenState();
  }

  class _CartScreenState extends State<AddToCartScreen>{
    List<cart> cartList = <cart>[];
    String titlecenter = "Adding to your cart...";
    late double screenHeight, screenWidth, resWidth, resHeight;
    double totalpayable = 0.0;

    @override
      void initState(){
      super.initState();
      _loadCart();
    }

    @override
  Widget build(BuildContext context) {
    // TODO: implement build
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600){
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: cartList.isEmpty ?
      Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(titlecenter,
          style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        )
        : Padding(
          padding: const EdgeInsets.fromLTRB(0,10,0,0),
          child: Column(
            children: [
              Expanded(
                child: GridView.count(
                  crossAxisCount: 1,
                  childAspectRatio: 2.7/1,
                  children: List.generate(cartList.length,(index){
                    return Padding(
                      padding: const EdgeInsets.all(2),
                      child: Card(
                        elevation: 12.0,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: CONSTANT.server + "/my_tutor/mobile/assets/courses/" + 
                                                                cartList[index]
                                                                    .subjectName
                                                                    .toString() + '.png',

                                                                placeholder: (context, url) =>
                                                                    const LinearProgressIndicator(),
                                                                errorWidget: (context, url, error) => const Icon(Icons.error),
                                                                height: 106,
                                                                width: 100,
                                                                fit: BoxFit.cover),
                                                  
                                ],
                              ),
                            ),

                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets(10),
                                child:Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Fitted(
                                      fit: BoxFit.cover,
                                      child:Text(
                                        truncateWithSpacing(20,
                                        cartList[index].subjectName.toString(),
                                        )),
                                        style: const TextStyle(color: const Colors.lightBlue, fontSize: 14. fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.attach_money,
                                                      color: Colors.blueGrey,
                                                      size: 15.0,
                                                    ),
                                                    Flexible(
                                                        child: Text(
                                                      "RM " +
                                                          cartList[index]
                                                              .price
                                                              .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 13),
                                                    ))
                                                  ],
                                                ),
                                                const SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.access_time_filled,
                                                      color: Colors.blueGrey,
                                                      size: 15.0,
                                                    ),
                                                    Flexible(
                                                        child: Text(
                                                      " " +
                                                          cartList[index]
                                                              .subjectSessions
                                                              .toString() +
                                                          " sessions",
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.blueGrey,
                                                          fontSize: 13),
                                                    ))
                                                  ],
                                                ),
                                                const SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.reviews,
                                                      color: Colors.blueGrey,
                                                      size: 15.0,
                                                    ),
                                                    Flexible(
                                                        child: Text(
                                                      " " +
                                                          cartList[index]
                                                              .subjectRating
                                                              .toString(),
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.blueGrey,
                                                          fontSize: 13),
                                                    ))
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.delete),
                                                color: Colors.blueGrey,
                                                onPressed: () {
                                                  _deleteCartDialog(index);
                                                },
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )));
                          })),
                    ),
                    Card(
                      color: Colors.grey.shade200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Total Payment: RM " +
                                  totalpayable.toStringAsFixed(2),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            ElevatedButton(
                                onPressed: _onPaynowDialog,
                                child: const Text("Make A Payment"))
                          ],
                        ),
                      ),
                    )
                  ],
                )));
  }

  void _loadCart(){
    http.post(
      Uri.parse(
        CONSTANT.server + "/my_tutor/mobile/php/load_cart.php"),
      body: {
        'email': widget.user.email,
      }).timeout(
        const Duration(seconds: 3),
        onTimeout: (){
          return http.Response(
            'Error', 408);
        },
        ).timeout(
      const Duration(seconds: 3),
      onTimeout: () {
        titlecenter = "Timeout! Please try again later";
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },

      ).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        if (extractdata['cart'] != null) {
          cartList = <cart>[];
          extractdata['cart'].forEach((v) {
            cartList.add(cart.fromJson(v));
          });
          int qty = 0;
          totalpayable = 0.00;
          for (var element in cartList) {
            qty = qty + int.parse(element.cartqty.toString());
            totalpayable =
                totalpayable + double.parse(element.price.toString());
          }
          setState(() {});
        }
      } else {
        titlecenter = "Uh Oh Your Cart is Empty";
        cartList.clear();
        setState(() {});
      }
    });
  }

  void _onPaynowDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Make A Payment",
              style: TextStyle(),
            ),
            content: const Text("Continue with payment?", style: TextStyle()),
            actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => PaymentScreen(
                            user: widget.user, totalpayable: totalpayable)));
                _loadCart();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteCartDialog(int index) {
    showDialog(
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
        title: const Text(
          'Do you want to remove this subject?',
          style: TextStyle(fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Yes"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _deleteCart(index);
                    },
                  ),
                  TextButton(
                      child: const Text("No"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ]),
        context: context);
  }

  void _deleteCart(int index) {
    http.post(
        Uri.parse(
            CONSTANTS.server + "my_tutor/mobile/php/delete_cart.php"),
        body: {
          'email': widget.user.email,
          'cartid': cartList[index].cartid
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    ).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        _loadCart();
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    });
  }
}