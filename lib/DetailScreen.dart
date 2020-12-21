import 'package:flutter/material.dart';
import 'package:midterm/Books.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() => runApp(DetailScreen());

class DetailScreen extends StatefulWidget {
  final Books book;

  const DetailScreen({Key key, this.book}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double screenHeight, screenWidth;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          widget.book.booktitle,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: screenHeight / 2,
              width: screenWidth / 0.3,
              child: CachedNetworkImage(
                imageUrl:
                    "http://slumberjer.com/bookdepo/bookcover/${widget.book.cover}.jpg",
                fit: BoxFit.scaleDown,
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(
                  Icons.broken_image,
                  size: screenWidth / 2,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.confirmation_number, color: Colors.black),
                Text(
                  ' Book ID : '+widget.book.bookid,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
             SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.book, color: Colors.orange),
                  Text(
                    ' Book Title : '+widget.book.booktitle,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.person, color: Colors.blue),
                  Text(
                    ' Author : '+widget.book.author,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.money, color: Colors.black),
                  Text(
                    ' Price: RM'+widget.book.price,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.description, color: Colors.greenAccent),
                  Text(
                    ' Description : ',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                    child:
                  Text(
                    widget.book.description,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                     textAlign: TextAlign.center,
                  ),),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.star, color: Colors.yellow),
                  Text(
                    ' Rating : '+widget.book.rating,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.group, color: Colors.blue),
                  Text(
                   ' Publisher : '+ widget.book.publisher,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.list, color: Colors.red),
                  Text(
                    ' ISBN : '+ widget.book.isbn,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      ),
    );
  }
}
