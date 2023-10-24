import 'package:chopstore/provider/theme_provider.dart';
import 'package:chopstore/utill/color_resources.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
class Jobs extends StatefulWidget {
  const Jobs() : super();

  @override
  JobsState createState() => JobsState();
}

class Debouncer {
  int milliseconds;
  VoidCallback action;
  Timer timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer  .cancel();
    }
    timer = Timer(
      const Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}

class JobsState extends State<Jobs> {
  final _debouncer = Debouncer();

  List<Subject> ulist = [];
  List<Subject> userLists = [];
  //API call for All Subject List

  String url = 'https://admin.chopstore.in/api/interior_search.php';

  Future<List<Subject>> getAllulistList() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // print(response.body);
        List<Subject> list = parseAgents(response.body);
        return list;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Subject> parseAgents(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Subject>((json) => Subject.fromJson(json)).toList();
  }

  @override
  void initState() {
    super.initState();
    getAllulistList().then((subjectFromServer) {
      setState(() {
        ulist = subjectFromServer;
        userLists = ulist;
      });
    });
  }

  //Main Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Users',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Column(
        children: <Widget>[
          //Search Bar to List of typed Subject
          Container(
            padding: const EdgeInsets.all(15),
            child: TextField(
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
                suffixIcon: const InkWell(
                  child: Icon(Icons.search),
                ),
                contentPadding: const EdgeInsets.all(15.0),
                hintText: 'Search ',
              ),
              onChanged: (string) {
                _debouncer.run(() {
                  setState(() {
                    userLists = ulist
                        .where(
                          (u) => (u.name.toLowerCase().contains(
                        string.toLowerCase(),
                      )),
                    )
                        .toList();
                  });
                });
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.all(5),
              itemCount: userLists.length,
              itemBuilder: (BuildContext context, int index) {
               return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => interior_designer_form(snapshot.data[index]),
                      //   ),
                      // );
                    },
                    child: Container(
                      // height: 230,
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(Provider
                            .of<ThemeProvider>(context)
                            .darkTheme ? 0.05 : 1),
                        boxShadow: Provider
                            .of<ThemeProvider>(context)
                            .darkTheme
                            ? null
                            : [
                          BoxShadow(color: Colors.grey[200],
                              spreadRadius: 1,
                              blurRadius: 5)
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white.withOpacity(Provider
                                    .of<ThemeProvider>(context)
                                    .darkTheme ? 0.05 : 1),

                              ),
                              // height: 100,
                              height: MediaQuery.of(context).size.height*0.1,
                              child: Image.network(
                                  userLists[index].image),
                            ),
                            Text('Name : '+userLists[index].name, style: TextStyle(
                                color: ColorResources.getTextColor(
                                    context)
                            ),),
                            Text('City : '+userLists[index].city, style: TextStyle(
                                color: ColorResources.getTextColor(
                                    context)),),
                            Text('Experience: '+userLists[index].experience, style: TextStyle(
                                color: ColorResources.getTextColor(
                                    context)),),

                          ],
                        ),
                      ),
                    ),
                  ),
                );

              },
            ),
          ),
        ],
      ),
    );
  }
}

//Declare Subject class for json data or parameters of json string/data
//Class For Subject
class Subject {
  var id;
  var image;
  var name;
  var city;
  var experience;


  Subject({
    this.id,
    this.image,
    this.name,
    this.city,
    this.experience,

  });

  factory Subject.fromJson(Map<dynamic, dynamic> json) {
    return Subject(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      city: json['city'],
      experience: json['experience'],
    );
  }
}