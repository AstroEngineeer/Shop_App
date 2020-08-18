import 'package:Shop_App/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static String routeName = "editproductscreen";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocus = FocusNode();
  final _discriptionFocus = FocusNode();
  final _urlFocus = FocusNode();
  final urlController = TextEditingController();
  Product editedproduct =
      Product(description: "", id: null, imageUrl: "", price: 0, title: "");
  final _form = GlobalKey<FormState>();
  bool init = true;

  @override
  void initState() {
    _urlFocus.addListener(urlListener);
    super.initState();
  }

  @override
  void dispose() {
    _urlFocus.removeListener(urlListener);
    _priceFocus.dispose();
    _discriptionFocus.dispose();
    _urlFocus.dispose();
    urlController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (init) {
      final id = ModalRoute.of(context).settings.arguments as String;
      if (id != null) {
        editedproduct =
            Provider.of<Products>(context, listen: false).getById(id);
        urlController.text = editedproduct.imageUrl;
      }
    }
    init = false;
    super.didChangeDependencies();
  }

  void urlListener() {
    if (!_urlFocus.hasFocus) {
      setState(() {});
    }
  }

  void saveForm() {
    _form.currentState.validate();
    _form.currentState.save();
    if (editedproduct.id == null) {
      Provider.of<Products>(context, listen: false).addProduct(editedproduct);
    } else {
      Provider.of<Products>(context, listen: false)
          .updateProduct(editedproduct.id, editedproduct);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: saveForm,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: editedproduct.title,
                  decoration: InputDecoration(labelText: "Title"),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(_priceFocus),
                  onSaved: (newValue) {
                    editedproduct = Product(
                        description: editedproduct.description,
                        id: editedproduct.id,
                        isFavorite: editedproduct.isFavorite,
                        imageUrl: editedproduct.imageUrl,
                        price: editedproduct.price,
                        title: newValue);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter a value";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: editedproduct.price.toString(),
                  decoration: InputDecoration(labelText: "Price"),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocus,
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(_discriptionFocus),
                  onSaved: (newValue) {
                    editedproduct = Product(
                        description: editedproduct.description,
                        id: editedproduct.id,
                        isFavorite: editedproduct.isFavorite,
                        imageUrl: editedproduct.imageUrl,
                        price: double.parse(newValue),
                        title: editedproduct.title);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter a value";
                    }
                    if (double.tryParse(value) == null) {
                      return "Enter a number";
                    }
                    if (double.parse(value) <= 0) {
                      return "Enter a number greater than 0";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: editedproduct.description,
                  decoration: InputDecoration(labelText: "Discription"),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _discriptionFocus,
                  onSaved: (newValue) {
                    editedproduct = Product(
                        description: newValue,
                        id: editedproduct.id,
                        isFavorite: editedproduct.isFavorite,
                        imageUrl: editedproduct.imageUrl,
                        price: editedproduct.price,
                        title: editedproduct.title);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter a value";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: urlController.text.isEmpty
                            ? Text(
                                "Provide URL",
                                textAlign: TextAlign.center,
                              )
                            : Image.network(
                                urlController.text,
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: "Image Url"),
                          keyboardType: TextInputType.url,
                          controller: urlController,
                          textInputAction: TextInputAction.done,
                          focusNode: _urlFocus,
                          onFieldSubmitted: (value) {
                            saveForm();
                          },
                          onSaved: (newValue) {
                            editedproduct = Product(
                                description: editedproduct.description,
                                id: editedproduct.id,
                                isFavorite: editedproduct.isFavorite,
                                imageUrl: newValue,
                                price: editedproduct.price,
                                title: editedproduct.title);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter a value";
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
