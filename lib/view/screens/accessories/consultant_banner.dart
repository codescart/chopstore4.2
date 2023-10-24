import 'dart:async';
import 'dart:convert';
import 'package:chopstore/utill/color_resources.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
class Slider_wer extends StatefulWidget {
  const Slider_wer({Key key}) : super(key: key);

  @override
  State<Slider_wer> createState() => _Slider_werState();
}

class _Slider_werState extends State<Slider_wer> {

  PageController pageController;
  int pageNo =0;

 Timer carasouelTimer;

  _Slider_werState();
  Timer getTimer(){
    return Timer.periodic( Duration(seconds: 1),(timer){
      if(pageNo==lgth){
        pageNo=0;
      }
      pageController.animateToPage(pageNo, duration: const Duration(seconds: 1),
          curve: Curves.easeInOutCirc);
      pageNo++;
    });
  }




  get controller => null;
  @override
  void initState() {
    pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.85,


    );
    carasouelTimer = getTimer();
    super.initState();
  }
  var lgth =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
              height: 180,
              child: FutureBuilder<List<Alb>>(
                  future: bowe(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? PageView.builder(
                        itemCount: snapshot.data.length,
                        controller: pageController,
                        onPageChanged: (index) {
                          pageNo = index;
                          setState(() {
                            lgth=snapshot.data.length;
                          });
                          print(snapshot.data.length);
                        },
                        itemBuilder: (_, index) {
                          return AnimatedBuilder(
                            animation: pageController,
                            builder: (context, child) {
                              return child;
                            },
                            child: Container(

                              margin: EdgeInsets.symmetric(horizontal: 10),
                              height: 150,

                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(snapshot.data[index].images),
                                    fit: BoxFit.cover,
                                  ),

                                borderRadius: BorderRadius.circular(10),),
                            ),

                          );
                        }
                    ):Text('aaaaaa');

                  }

              )

          ),

          Positioned(
            bottom: 5, left: 0, right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:List.generate(lgth, (index) => Container(
                margin: EdgeInsets.all(2.0),
                child: Icon(Icons.circle,size: 12.0,
                  color: pageNo==index?  Theme.of(context).primaryColor : ColorResources.getCardBgColor(context)),
              )),
            ),
          )
        ],
      ),
    );
  }
}
class Alb {
  String images;
  Alb(this.images);

}
Future<List<Alb>> bowe() async{
  final response = await http.get(
    Uri.parse("https://admin.chopstore.in/consultant_view_slider.php")
  );

  var jsond = json.decode(response.body)["id"];
  print(jsond);


  print('wwwwwwwwwwwwwwww');
  List<Alb> allround = [];
  for (var o in jsond)  {
    Alb al = Alb(
      o["images"]
    );

    allround.add(al);
  }
  return allround;
}