import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductBloc extends BlocBase {

  String categoryID;
  DocumentSnapshot product;

  ProductBloc({this.categoryID, this.product}) {

  }

  @override
  void dispose() {

  }


}