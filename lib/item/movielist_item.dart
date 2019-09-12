import 'package:flutter/material.dart';
import 'package:flutter_app/model/movie.dart';

class MovieListItem extends StatelessWidget{
  final Movice movice;
  MovieListItem(this.movice);

  @override
  Widget build(BuildContext context) {
     /// TODO: implement build

    return Padding(
      padding: const EdgeInsets.only(top: 3.0,left: 5.0,right: 5.0,bottom: 3.0),
      child: SizedBox(
        child: Card(
          elevation: 0.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,left: 10,bottom: 5
                          ),
                          child: Text(movice.title,style: TextStyle(color: Colors.blueAccent,fontSize: 24.0),),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 10.0
                                ),
                                child: Text(movice.size),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}