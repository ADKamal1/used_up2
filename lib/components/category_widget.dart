import 'package:bechdal_app/constants/colors.constants.dart';
import 'package:bechdal_app/provider/category_provider.dart';
import 'package:bechdal_app/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../forms/sell_car_form.dart';
import '../screens/category/category_list_screen.dart';
import '../screens/category/subcategory_screen.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    var categoryProvider = Provider.of<CategoryProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: FutureBuilder<QuerySnapshot>(
        future: authService.categories
            .orderBy('category_name', descending: false)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }

          return Container(
              height: 200,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                          child: Text(
                        'Categories',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, CategoryListScreen.screenId);
                          },
                          child: Row(
                            children: const [
                              Text('See All'),
                              SizedBox(
                                width: 2,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                              )
                            ],
                          )),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: ((context, index) {
                          var doc = snapshot.data?.docs[index];
                          return InkWell(
                            onTap: () {
                              categoryProvider
                                  .setCategory(doc!['category_name']);
                              categoryProvider.setCategorySnapshot(doc);
                              if (doc['subcategory'] == null) {
                                Navigator.of(context)
                                    .pushNamed(SellCarForm.screenId);
                              } else {
                                Navigator.pushNamed(
                                    context, SubCategoryScreen.screenId,
                                    arguments: doc);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(0),
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network(
                                    doc!['img'],
                                    height: 50,
                                    width: 50,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Flexible(
                                    child: Text(
                                      doc['category_name'],
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })),
                  )
                ],
              ));
        },
      ),
    );
  }
}
