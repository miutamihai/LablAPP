import 'package:flutter/material.dart';

class Gallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      //children: <Widget>[ListView.builder(itemBuilder: (ctx, index),)],
      children: List.generate(
        20,
        (index) {
          return Center(
            child: Container(
              child: Column(
                children: [
                  Text(
                    'Item ' + (index + 1).toString(),
                    style: Theme.of(context).textTheme.headline,
                  ),
                  Container(
                    height: 100,
                    child: Image.asset(
                      'assets/images/emoticon-heart-4mp-free.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
