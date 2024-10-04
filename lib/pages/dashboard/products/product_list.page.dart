import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as converter;
import './models/product_model.dart';

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

  @override
  void initState() {
    super.initState();
    getAllProducts().then((data) {
      setState(() {
        productList = data;
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
      body: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(6),
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 120,
            width: MediaQuery.of(context).size.width * 0.85,
            child: Card(
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
                      image: NetworkImage(productList[index]["image_path"]),
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      productList[index]["name"].toString(),
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(productList[index]["price"].toString()),
                    onTap: () {
                      debugPrint("PRODUCT NAME: ${productList[index]["name"]}");
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return ListView(
                            children: [
                              Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 60,
                                          height: 60,
                                          child: Image(
                                              image: NetworkImage(
                                                  productList[index]
                                                      ["image_path"]),
                                              fit: BoxFit.cover),
                                        ),
                                        Text(productList[index]["name"]),
                                        Text(productList[index]["price"]),
                                        Text(productList[index]["description"]),
                                        Text(productList[index]["createdAt"]),
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
          );
        },
      ),
    );
  }
}
