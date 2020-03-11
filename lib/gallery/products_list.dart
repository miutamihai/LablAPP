import 'package:flutter/material.dart';
import 'package:labl_app/gallery/product_widget.dart';
import 'package:labl_app/models/product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:labl_app/camera/show_image.dart';

class ProductList extends StatefulWidget {
  static const String id = 'gallery';
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin<ProductList> {

  @override
  bool get wantKeepAlive => true;


  final List<Product> _listOfProducts = [
    Product(
        name: 'Guinness',
        image: ("beers/guinness_can.jpg"),
        price: '2€',
        description: 'test',
        reviews: ''),
    Product(
        name: 'Carlsberg',
        image: ("beers/carlsberg_can.jpg"),
        price: '2€',
        description: 'test',
        reviews: ''),
    Product(
        name: 'Heineken',
        image: ("beers/heineken_can.jpg"),
        price: '2€',
        description: 'test',
        reviews: ''),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getImage() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ShowImage(image.path)),
      );
    });
  }

  Widget _uploadFromGalleryWidget(){
    return Align(
      alignment: Alignment.bottomLeft,
      child: GestureDetector(
        onTap: (){
          getImage();
        },
        child: Container(
            margin: const EdgeInsets.only(left: 20),
            width: 210,
            decoration: new BoxDecoration(
              color: Colors.amber[50],
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                    color: Colors.black,
                    blurRadius: 10.0,
                    offset: new Offset(0.0, 10.0))
              ],
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Pick from gallery',
                    style: TextStyle(
                        fontSize: 16.0, color: Colors.grey[800], fontWeight: FontWeight.w400
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 30,
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.add_photo_alternate,
                          size: 30,
                          color: Colors.white,
                        ),
                      )
                  ),
                )
              ],
            )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemBuilder: (_, int index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: index == this._listOfProducts.length
                  ? Container(
                height: 100,
              )
                  : ProductCard(this._listOfProducts[index]),
            ),
            itemCount: this._listOfProducts.length + 1,
          ),
          _uploadFromGalleryWidget(),
        ],
      )
    );
  }
}
