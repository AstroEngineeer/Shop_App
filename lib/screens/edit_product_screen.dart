import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static String routeName = "editproductscreen";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocus = FocusNode();
  final _discriptionFocus = FocusNode();

  @override
  void dispose() {
    _priceFocus.dispose();
    _discriptionFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Form(
            child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Title"),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) =>
                  FocusScope.of(context).requestFocus(_priceFocus),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Price"),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocus,
              onFieldSubmitted: (value) =>
                  FocusScope.of(context).requestFocus(_discriptionFocus),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Discription"),
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              focusNode: _discriptionFocus,
            ),
          ],
        )),
      ),
    );
  }
}
