


import 'package:flutter/material.dart';
import 'package:newapp/apiresponse.dart';
import 'package:newapp/bloc.dart';
import 'package:newapp/jsonclass.dart';
import 'package:newapp/newsslide.dart';

void main()=>runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Articlesbloc _bloc ;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          bottomNavigationBar: BottomNavigationBar(

            fixedColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            items:
          [
            BottomNavigationBarItem(
              icon:new Icon(Icons.dns, color: Colors.grey[700],),
              title: new Text("Discover"),

            ),
            BottomNavigationBarItem(
              icon:new Icon(Icons.category, color: Colors.grey[700]),
              title: new Text("Categories"),

            ),
            BottomNavigationBarItem(
              icon:new Icon(Icons.search, color: Colors.grey[700]),
              title: new Text("Search"),

            ),
            BottomNavigationBarItem(
              icon:new Icon(Icons.bookmark, color: Colors.grey[700]),
              title: new Text("Saved"),


            ),
          ],



          ),
          body: SafeArea(
            child: SingleChildScrollView(

              child: Column(
                children: <Widget>[

                  Container(height: 60,
                    child: Text("Saved Articles",style: TextStyle(fontSize: 32,fontWeight:FontWeight.bold),),
                  ),

                 Padding(
                   padding: EdgeInsets.all(9.0),
                   child: TextFormField(
                     cursorColor: Colors.grey,
                     decoration: new InputDecoration(
                      prefixIcon: Icon(Icons.search),
                       labelText: "search",
                       fillColor: Colors.grey,
                       border: new OutlineInputBorder(
                         borderRadius: BorderRadius.circular(25.0),
                       ),
                     ),
                   ),
                 ),

                  Container(
                    child: RefreshIndicator(
                      onRefresh: ()=> _bloc.fetchArticlesbloc(),
                      child: StreamBuilder<ApiResponse<BusinessModel>>(

                        stream:_bloc.streamData,
                        builder: (context, snapshot){
                          if (snapshot.hasData){
                            switch (snapshot.data.status){
                              case Status.LOADING:
                                return Loading(loadingMessage: snapshot.data.message);
                                break;
                              case Status.COMPLETED:
                                return ArticlesScreen(newsResponsees: snapshot.data.data.articles);
                                break;
                              case Status.ERROR:
                                return Error(
                                    errorMessage: snapshot.data.message,
                                    onRetryPressed:()=> _bloc.fetchArticlesbloc()
                                );
                                break;
                            }
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      );

  }
  @override
  void initState() {
    _bloc = Articlesbloc();
    _bloc.fetchArticlesbloc();
  }
  @override
  void dispose() {

    super.dispose();
  }
}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            child: Text('Retry', style: TextStyle(color: Colors.white)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}

