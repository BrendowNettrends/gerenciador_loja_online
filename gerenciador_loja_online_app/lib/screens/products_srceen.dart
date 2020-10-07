import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_loja_online/blocs/product_bloc.dart';
import 'package:gerenciador_loja_online/widgets/images_widget.dart';

class ProductScreen extends StatefulWidget {

  final String categoryID;
  final DocumentSnapshot product;

  ProductScreen({this.categoryID, this.product});

  @override
  _ProductScreenState createState() => _ProductScreenState(categoryID, product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductBloc _productBloc;

  final  _formKey = GlobalKey<FormState>();

_ProductScreenState(String categoryID, DocumentSnapshot product) :
      _productBloc = ProductBloc(categoryID: categoryID, product: product);


  @override
  Widget build(BuildContext context) {

    InputDecoration _buildDecoration(String label) {

      return InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey)
      );
    }

    final _filedStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
    );

    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
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
        child: StreamBuilder<Map>(
          stream: _productBloc.outData,
          builder: (context, snapshot) {
            if(!snapshot.hasData) return Container();
            return ListView(
              padding: EdgeInsets.all(16),
              children: <Widget>[
                Text(
                  "Imagens",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                ImagesWidget(
                  context: context,
                  initialValue: snapshot.data["images"],
                  onSaved: (l){},
                  validator: (l){},
                ),
                TextFormField(
                  initialValue: snapshot.data["title"],
                  style: _filedStyle,
                  decoration: _buildDecoration("Título"),
                  onSaved: (t){},
                  validator: (t){},
                ),
                TextFormField(
                  initialValue: snapshot.data["description"],
                  style: _filedStyle,
                  maxLines: 6,
                  decoration: _buildDecoration("Descrição"),
                  onSaved: (t){},
                  validator: (t){},
                ),
                TextFormField(
                  initialValue: snapshot.data["price"]?.toStringAsFixed(2),
                  style: _filedStyle,
                  decoration: _buildDecoration("Preço"),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onSaved: (t){},
                  validator: (t){},
                ),
              ],
            );
          }
        ),
      )
    );
  }
}
