import 'dart:async';
import 'dart:convert';
import 'package:chopstore/helper/responsive_helper.dart';
import 'package:chopstore/localization/language_constrants.dart';
import 'package:chopstore/view/base/custom_text_field.dart';
import 'package:chopstore/view/screens/accessories/customize_product_banner.dart';
import 'package:http/http.dart' as http;

import 'package:chopstore/provider/category_provider.dart';
import 'package:chopstore/provider/product_provider.dart';
import 'package:chopstore/provider/theme_provider.dart';
import 'package:chopstore/utill/color_resources.dart';
import 'package:chopstore/utill/dimensions.dart';
import 'package:chopstore/utill/styles.dart';
import 'package:chopstore/view/screens/accessories/customize_product_form.dart';
import 'package:chopstore/view/screens/home/widget/banners_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class customizeproduct extends StatefulWidget {
  @override
  State<customizeproduct> createState() => _customizeproductState();
}
class Debouncer {
  int milliseconds;
  VoidCallback action;
  Timer timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer.cancel();
    }
    timer = Timer(
      const Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}

class _customizeproductState extends State<customizeproduct> {

  final _debouncer = Debouncer();
  List<Subject> ulist = [];
  List<Subject> userLists = [];

 // String url = 'https://admin.chopstore.in/api/customize_product_view.php';

  Future<List<Subject>> getAllulistList() async {
    try {
      final response = await http.get(Uri.parse('https://admin.chopstore.in/api/customize_product_view.php'));

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
  final myController = TextEditingController();

  @override

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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Customize Product', style: poppinsMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: Theme.of(context).textTheme.bodyText1.color)),
          centerTitle: true,
          leading:  IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Theme.of(context).textTheme.bodyText1.color,
            onPressed: () => Navigator.pop(context),
          ) ,
          backgroundColor: Theme.of(context).cardColor,
          elevation: 2,

        ),
        body:RefreshIndicator(
          onRefresh: () async  {

            setState(() {

              //error
            });
          },
          child: ListView(
           // physics: ResponsiveHelper.isMobilePhone()? BouncingScrollPhysics():null,
            children: [
              SizedBox(
                height: 25,
              ),
              Container(
                height: 200,
                child: custmoised_Banner(),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
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
                              (u) => (u.city.toLowerCase().contains(
                            string.toLowerCase(),
                          )),
                        )
                            .toList();
                      });
                    });
                  },
                ),
              ),

              GridView.builder(
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => customize_product_form
                              (name:userLists[index].name,
                              experience: userLists[index].experience,
                              city: userLists[index].city,
                              number: userLists[index].mobile_number,
                              image: userLists[index].image,
                              whatsappnumber: userLists[index].whatsapp_number,
                              description: userLists[index].description,),
                          ),
                        );
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
            ],
          ),
        )
      ),
    );
  }

}
class Subject {
  var id;
  var image;
  var name;
  var city;
  var experience;
  var mobile_number;
  var whatsapp_number;
  var description;

  Subject({
    this.id,
    this.image,
    this.name,
    this.city,
    this.experience,
    this.mobile_number,
    this.whatsapp_number,
    this.description,
// print(mobile_number),

  });

  factory Subject.fromJson(Map<dynamic, dynamic> json) {
    return Subject(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      city: json['city'],
      experience: json['experience'],
      mobile_number: json['mobile_number'],
      whatsapp_number: json['whatsapp_number'],
      description: json['description'],
    );
  }
}

