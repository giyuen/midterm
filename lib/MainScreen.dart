import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:midterm/Books.dart';

import 'DetailScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List bookslist;
  String titlecenter = "No Data Available.";
  double screenHeight, screenWidth;
  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'List of Books',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black,
        ),
        body: Column(children: [
          bookslist == null
              ? Flexible(
                  child: Container(
                      child: Center(
                          child: Text(
                  titlecenter,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ))))
              : Flexible(
                  child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (screenWidth / screenHeight) / 0.89,
                      children: List.generate(bookslist.length, (index) {
                        return Padding(
                            padding: EdgeInsets.all(3),
                            child: Card(
                              child: InkWell(
                                  onTap: () => _loadbookDetail(index),
                                  child: Column(children: [
                                    Container(
                                      height: screenHeight / 3.85,
                                      width: screenWidth / 1.8,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "http://slumberjer.com/bookdepo/bookcover/${bookslist[index]['cover']}.jpg",
                                        fit: BoxFit.scaleDown,
                                        placeholder: (context, url) =>
                                            new CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            new Icon(
                                          Icons.broken_image,
                                          size: screenWidth / 2,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.book, color: Colors.red),
                                        Flexible(
                                          child: Text(
                                            ' ' + bookslist[index]['booktitle'],
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.person, color: Colors.blue),
                                        Flexible(
                                          child: Text(
                                            ' ' + bookslist[index]['author'],
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.money_sharp,
                                            color: Colors.black),
                                        Text(
                                          ' RM' + bookslist[index]['price'],
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.star, color: Colors.yellow),
                                        Text(
                                          ' ' + bookslist[index]['rating'],
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ])),
                            ));
                      })),
                )
        ]),
      ),
    );
  }

  void _loadBooks() {
    print("Loading...");

    http.post("http://slumberjer.com/bookdepo/php/load_books.php",
        body: {}).then((books) {
      print(books.body);
      if (books.body == "nodata") {
        bookslist = null;
      } else {
        setState(() {
          var jsondata = json.decode(books.body);
          bookslist = jsondata["books"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _loadbookDetail(int index) {
    print(bookslist[index]['booktitle']);
    Books books = new Books(
        bookid: bookslist[index]['bookid'],
        booktitle: bookslist[index]['booktitle'],
        author: bookslist[index]['author'],
        price: bookslist[index]['price'],
        description: bookslist[index]['description'],
        rating: bookslist[index]['rating'],
        publisher: bookslist[index]['publisher'],
        isbn: bookslist[index]['isbn'],
        cover: bookslist[index]['cover']);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => DetailScreen(book: books)));
  }
}
