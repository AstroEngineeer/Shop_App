import 'package:Shop_App/screens/edit_product_screen.dart';
import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final imageUrl;
  final title;

  UserProductItem(this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: null,
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}
