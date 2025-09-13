import 'package:flutter/material.dart';
import 'package:yumquick/core/db_helper/ProductDBHelper.dart';
import 'package:yumquick/features/fav/views/widgets/fav_item.dart';

class ListviewItemFav extends StatefulWidget {
  const ListviewItemFav({super.key});

  @override
  State<ListviewItemFav> createState() => _ListviewItemFavState();
}

class _ListviewItemFavState extends State<ListviewItemFav> {
  List<Map<String, dynamic>> savedArticles = [];
    @override
  void initState() {
      loadProduct();
    super.initState();
  }
  Future<void> loadProduct() async {
    final data = await ProductDBHelper.getProducts();
    if (!mounted) return;
    setState(() {
      savedArticles = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context,index){
        return FavItem(
          product: savedArticles[index],
        );
      },itemCount: savedArticles.length,),
    );
  }
}
