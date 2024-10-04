import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'dart:convert' as converter;
import './models/product_model.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final String apiUrl =
      "http://192.168.99.139/flutter-api/products/getAllProducts.php";
  final productModel = ProductModel();
  List<dynamic> productList = []; //* first time productList is empty

  //* method to get all products
  getAllProducts() async {
    try {
      var resp = await http.get(Uri.parse(apiUrl));
      if (resp.statusCode == 200) {
        var respConvert =
            converter.json.decode(resp.body); //* value from REST API
        if (respConvert["status"] == "OK") {
          debugPrint("RESPONSE: ${respConvert["message"]}");
          List<dynamic> allProducts = respConvert["data"];
          return allProducts;
        } else {
          throw Exception("ERROR:  While getting all products");
        }
      } else {
        throw Exception(
            "ERROR: Failed connect to server with status code ${resp.statusCode}");
      }
    } catch (e) {
      debugPrint("ERROR: $e");
    }
  }

  List<dynamic> productSearch = [];

  @override
  void initState() {
    super.initState();
    getAllProducts().then((data) {
      setState(() {
        productSearch = data;
        productList = productSearch;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        strokeWidth: 3,
        color: Colors.green,
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 5), () {
            setState(() {
              getAllProducts().then((data) {
                setState(() {
                  productList = data;
                });
              });
            });
            const snackBar = SnackBar(
              content: Text('Success to refresh product data'),
              showCloseIcon: true,
              closeIconColor: Colors.white,
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        },
        child: Center(
          child: Column(
            children: [
              //* search product feature
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                margin: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                child: TextField(
                  textInputAction: TextInputAction.search,
                  decoration: const InputDecoration(
                    hintText: 'Search product name',
                    suffixIcon: Icon(Icons.search),
                  ),
                  onChanged: (keyword) {
                    setState(() {
                      productList = productSearch
                          .where((found) => found["name"]
                              .toLowerCase()
                              .contains(keyword.toLowerCase()))
                          .toList();
                    });
                  },
                ),
              ),
              //* display all products
              Expanded(
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(6),
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width * 0.85,
                      color: Colors.grey.shade300,
                      child: Dismissible(
                        key: Key("index:${productList[index]["id"]}"),
                        background: Container(
                          color: Colors.red,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child:
                                      Icon(Icons.delete, color: Colors.white)),
                              Text('Delete',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                        secondaryBackground: Container(
                          color: Colors.blue,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Edit',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Icon(Icons.edit, color: Colors.white)),
                            ],
                          ),
                        ),
                        confirmDismiss: (direction) async {
                          Future deleteProduct(BuildContext context) async {
                            const String apiUrlDelete =
                                "http://192.168.99.139/flutter-api/products/deleteProduct.php";
                            await http.post(
                              Uri.parse(apiUrlDelete),
                              body: {
                                "id": productList[index]["id"],
                              },
                            );
                            setState(() {
                              getAllProducts().then((data) {
                                setState(() {
                                  productList = data;
                                });
                              });
                            });

                            //* quick-alert
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              text: 'Success to delete product!',
                            );
                          }

                          Future showConfirmDelete(BuildContext context) async {
                            if (await confirm(
                              context,
                              title: const Text('Confirm Delete'),
                              content: const Text(
                                  'Are you sure to delete this product?'),
                              textOK: const Text('Yes'),
                              textCancel: const Text('Cancel'),
                            )) {
                              return deleteProduct(context);
                            } else {
                              return debugPrint("Cancel to delete product");
                            }
                          }

                          if (direction == DismissDirection.startToEnd) {
                            //* show confirm delete using alert dialog
                            return await showConfirmDelete(context);
                          } else if (direction == DismissDirection.endToStart) {
                            //* TextEditingController
                            TextEditingController productNameCtrl =
                                TextEditingController();
                            TextEditingController productPriceCtrl =
                                TextEditingController();
                            TextEditingController productDescriptionCtrl =
                                TextEditingController();

                            setState(() {
                              productNameCtrl.text = productList[index]["name"];
                              productPriceCtrl.text =
                                  productList[index]["price"];
                              productDescriptionCtrl.text =
                                  productList[index]["description"];
                            });

                            Future updateProduct(context) async {
                              const String apiUrlUpdate =
                                  "http://192.168.99.139/flutter-api/products/updateProduct.php";
                              await http.post(
                                Uri.parse(apiUrlUpdate),
                                body: {
                                  "id": productList[index]["id"],
                                  "name": productNameCtrl.text,
                                  "price": productPriceCtrl.text,
                                  "description": productDescriptionCtrl.text,
                                },
                              );
                              setState(() {
                                getAllProducts().then((data) {
                                  setState(() {
                                    productList = data;
                                  });
                                });
                              });
                            }

                            //* show edit form
                            return await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Edit Product"),
                                  backgroundColor: Colors.grey.shade300,
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        alignment: Alignment.center,
                                        backgroundColor: Colors.grey,
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        alignment: Alignment.center,
                                        backgroundColor: Colors.blue,
                                      ),
                                      onPressed: () {
                                        updateProduct(context);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        "Update",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                  content: Form(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextFormField(
                                          controller: productNameCtrl,
                                          decoration: InputDecoration(
                                            labelText: "Product Name",
                                            filled: true,
                                            fillColor: Colors.grey.shade300,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                          ),
                                        ),
                                        const Padding(
                                            padding: EdgeInsets.only(top: 12)),
                                        TextFormField(
                                          controller: productPriceCtrl,
                                          decoration: InputDecoration(
                                            labelText: "Product Price",
                                            filled: true,
                                            fillColor: Colors.grey.shade300,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                          ),
                                        ),
                                        const Padding(
                                            padding: EdgeInsets.only(top: 12)),
                                        TextFormField(
                                          controller: productDescriptionCtrl,
                                          decoration: InputDecoration(
                                            labelText: "Product Description",
                                            filled: true,
                                            fillColor: Colors.grey.shade300,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                          ),
                                        ),
                                        const Padding(
                                            padding: EdgeInsets.only(top: 12)),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          return true;
                        },
                        child: Card(
                          borderOnForeground: true,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1,
                              )),
                          margin: const EdgeInsets.all(4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListTile(
                                tileColor: Colors.white,
                                dense: false,
                                leading: Image(
                                  image: NetworkImage(
                                      productList[index]["image_path"]),
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                  productList[index]["name"].toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                                subtitle: Text(
                                    productList[index]["price"].toString()),
                                onTap: () {
                                  debugPrint(
                                      "PRODUCT NAME: ${productList[index]["name"]}");
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return ListView(
                                        children: [
                                          Wrap(
                                            alignment: WrapAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.5,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 12),
                                                      width: 100,
                                                      height: 100,
                                                      child: Image(
                                                          image: NetworkImage(
                                                              productList[index]
                                                                  [
                                                                  "image_path"]),
                                                          fit: BoxFit.cover),
                                                    ),
                                                    Text(
                                                      productList[index]
                                                          ["name"],
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(productList[index]
                                                        ["price"]),
                                                    Text(productList[index]
                                                        ["createdAt"]),
                                                    Text(productList[index]
                                                        ["description"]),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'New Product',
        elevation: 8,
        mini: false,
        splashColor: Colors.blue,
        onPressed: () {
          //* form create product
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
