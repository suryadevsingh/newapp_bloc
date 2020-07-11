import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:newapp/jsonclass.dart';

class ArticlesScreen extends StatelessWidget {
  final List<Article> newsResponsees;

  ArticlesScreen({Key key, this.newsResponsees}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height - 150,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: newsResponsees.length,
          itemBuilder: (context, index) {
            return Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Container(
                                width: 130,

                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      stops: [
                                    0.1,
                                    0.3,
                                    0.7,
                                    1
                                  ],
                                      colors: [
                                    Colors.green,
                                    Colors.blue,
                                    Colors.orange,
                                    Colors.pink
                                  ])),
                              child: Padding(
                                padding:  EdgeInsets.only(left: 6),
                                child: Text(
                                  newsResponsees[index].author!=null?newsResponsees[index].author:"ABC",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                            width: 200,
                            child: Text(

                              newsResponsees[index].description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    width: 150,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35.0),
                      ),
                      child: Image.network(
                        newsResponsees[index].urlToImage,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
