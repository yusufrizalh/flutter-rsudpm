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
      body: Center(
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
                            subtitle:
                                Text(productList[index]["price"].toString()),
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
                                                  margin: const EdgeInsets.only(
                                                      bottom: 12),
                                                  width: 100,
                                                  height: 100,
                                                  child: Image(
                                                      image: NetworkImage(
                                                          productList[index]
                                                              ["image_path"]),
                                                      fit: BoxFit.cover),
                                                ),
                                                Text(
                                                  productList[index]["name"],
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
