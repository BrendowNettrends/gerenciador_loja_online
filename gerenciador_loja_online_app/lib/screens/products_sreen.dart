import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_loja_online/blocs/product_bloc.dart';

class ProductScreen extends StatelessWidget {

  final String categoryID;
  final DocumentSnapshot product;

  final ProductBloc _productBloc;

  final  _formKey = GlobalKey<FormState>();

  ProductScreen({this.categoryID, this.product}) :
      _productBloc = ProductBloc(categoryID: categoryID, product: product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        elevation: 0,
        title: Text("Criar Produto"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {

              }
          ),
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {

              }
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[

          ],
        ),
      )
    );
  }
}
