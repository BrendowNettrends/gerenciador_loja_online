import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_loja_online/blocs/product_bloc.dart';
import 'package:gerenciador_loja_online/validators/product_validator.dart';
import 'package:gerenciador_loja_online/widgets/images_widget.dart';
import 'package:gerenciador_loja_online/widgets/products_sizes.dart';

class ProductScreen extends StatefulWidget {

  final String categoryID;
  final DocumentSnapshot product;

  ProductScreen({this.categoryID, this.product});

  @override
  _ProductScreenState createState() => _ProductScreenState(categoryID, product);
}

class _ProductScreenState extends State<ProductScreen>  with ProductValidator {
  final ProductBloc _productBloc;

  final  _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: _scaffoldKey,
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 0,
        title: StreamBuilder<bool>(
          stream: _productBloc.outCreated,
          initialData: false,
          builder: (context, snapshot) {
            return Text(snapshot.data ? "Editar Produto" : "Criar Produto");
          }
        ),
        actions: <Widget>[
          StreamBuilder<bool>(
            stream: _productBloc.outCreated,
            initialData: false,
            builder: (context, snapshot) {
              if(snapshot.data)
                return StreamBuilder<Object>(
                    stream: _productBloc.outLoading,
                    initialData: false,
                    builder: (context, snapshot) {
                      return IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: snapshot.data ? null : () {
                          _productBloc.deleteProduct();
                          Navigator.of(context).pop();
                        },
                      );
                    }
                );
              else return Container();
            }
          ),

          StreamBuilder<Object>(
            stream: _productBloc.outLoading,
            initialData: false,
            builder: (context, snapshot) {
              return IconButton(
                  icon: Icon(Icons.save),
                  onPressed: snapshot.data ? null : saveProduct,
              );
            }
          ),
        ],
      ),
      body: Stack(
        children: [
          Form(
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
                      onSaved: _productBloc.saveImages,
                      validator: validateImages,
                    ),
                    TextFormField(
                      initialValue: snapshot.data["title"],
                      style: _filedStyle,
                      decoration: _buildDecoration("Título"),
                      onSaved: _productBloc.saveTitle,
                      validator: validateTitle,
                    ),
                    TextFormField(
                      initialValue: snapshot.data["description"],
                      style: _filedStyle,
                      maxLines: 6,
                      decoration: _buildDecoration("Descrição"),
                      onSaved: _productBloc.saveDescription,
                      validator: validateDescription,
                    ),
                    TextFormField(
                      initialValue: snapshot.data["price"]?.toStringAsFixed(2),
                      style: _filedStyle,
                      decoration: _buildDecoration("Preço"),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      onSaved: _productBloc.savePrice,
                      validator: validatePrice,
                    ),
                    Text(
                      "Tamanhos",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    ProductsSizes(
                      context: context,
                      initialValue: snapshot.data["sizes"],
                      onSaved: _productBloc.saveSizes,
                      validator: (s) {
                        if(s.isEmpty) return "Adicione um tamanho";
                      }
                    )
                  ],
                );
              }
            ),
          ),
          StreamBuilder<Object>(
              stream: _productBloc.outLoading,
              initialData: false,
              builder: (context, snapshot) {
                return IgnorePointer(
                  ignoring: !snapshot.data,
                  child: Container(
                    color: snapshot.data ? Colors.black54 : Colors.transparent,
                  ),
                );
              }
          ),
        ],
      )
    );
  }

  void saveProduct() async {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();

      _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Salvando produto...", style: TextStyle(color: Colors.white),),
          duration: Duration(minutes: 1),
          backgroundColor: Colors.greenAccent,
        )
      );

      bool success = await _productBloc.saveProduct();

      _scaffoldKey.currentState.removeCurrentSnackBar();

      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(success ? "Produto salvo!" : "Erro ao salvar produto!", style: TextStyle(color: Colors.white),),
            backgroundColor: Colors.greenAccent,
          )
      );
    }
  }
}
