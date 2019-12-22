import 'package:carpool/Theme/theme.dart';
import 'package:carpool/future/CustomFuture.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class searchResult extends StatefulWidget {
  String query;

  searchResult(this.query);

  @override
  State<StatefulWidget> createState() => searchResultState(query);
}

class searchResultState extends State<searchResult> {
  String query;
  searchResultState(this.query);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: CustomTheme().colorCustom),
      home: Scaffold(
          appBar: AppBar(
            title: Text("Search result for $query"),
          ),
          body: FutureBuilder(
              future: CustomFuture().getsearchOfUser(query),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Image.asset('assets/images/load.gif'),
                    ),
                  );
                } else if (snapshot.data.length == 0) {
                  return Container(
                    child: Center(
                      child: Image.asset('assets/images/load.gif'),
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return rideItem(context, index, snapshot);
                      });
                }
              })
          /*,*/
          ),
    );
  }

  Widget rideItem(BuildContext context, int index, AsyncSnapshot snapshot) {
    return Card(
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(4.0),
        onTap: () {},
        child: Row(
          children: <Widget>[
            Image.asset(
              'assets/images/bike.jpg',
              width: 120,
              height: 80,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            snapshot.data[index].start_location.toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                            softWrap: true,
                          ),
                        ),
                        Container(
                          child: RaisedButton(
                            onPressed: () {
                              Toast.show("You requested for the ride", context);
                              postRequest(snapshot.data[index].id);
                              },
                            child: Text("Request"),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: parseDate(snapshot.data[index].datetime),
                          ),
                        ],
                      ),
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      children: <Widget>[
                        Text("Condition"),
                        const SizedBox(width: 10.0),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String parseDate(String date) {
    DateTime d = DateTime.parse(date);
    return d.day.toString() +
        "-" +
        d.month.toString() +
        "-" +
        d.year.toString();
  }

  void postRequest(String id) async{
    String response = await CustomFuture().postRequestRide(id);
    print(response);
  }
}
