import 'package:chopstore/helper/responsive_helper.dart';
import 'package:chopstore/provider/theme_provider.dart';
import 'package:chopstore/utill/color_resources.dart';
import 'package:chopstore/utill/dimensions.dart';
import 'package:chopstore/utill/styles.dart';
import 'package:chopstore/view/screens/accessories/interior_designer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class interior_designer_form extends StatefulWidget {
  final String name;
  final String city;
  final String experience;
  final String image;
  final String description;
  final String whatsappnumber;
  final String number;
  interior_designer_form({this.name,this.experience,this.city,
    this.image,this.description,this.whatsappnumber,this.number});
  @override
  State<interior_designer_form> createState() => _interior_designer_formState();
}

class _interior_designer_formState extends State<interior_designer_form> {
  bool pj= false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar:AppBar(
        title: Text('Interior Designer', style: poppinsMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
            color: Theme.of(context).textTheme.bodyText1.color)),
        centerTitle: true,
        leading:  IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Theme.of(context).textTheme.bodyText1.color,
          onPressed: () => Navigator.pop(context),
        ) ,
        backgroundColor: Theme.of(context).cardColor,
        elevation: 2,

      ),
      body: SingleChildScrollView(
        physics: ResponsiveHelper.isMobilePhone()? BouncingScrollPhysics():null,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 250,
              child: Image.network(widget.image),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height*0.08,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(Provider.of<ThemeProvider>(context).darkTheme ? 0.05 : 1),
                boxShadow: Provider.of<ThemeProvider>(context).darkTheme
                    ? null
                    : [BoxShadow(color: Colors.grey[200], spreadRadius: 1, blurRadius: 5)],
              ),
              child:Center(child: Text(widget.name, style: poppinsMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            pj=false;
                          });
                          _launchCaller();
                        },
                        child: Container(
                          height: 50,width: 150,
                          decoration: BoxDecoration(
                            color: pj==false? Color(0xffff7f00):Color(0xFFADC4C8),


                            borderRadius:
                            BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Center(child:
                          Text('CALL',style: TextStyle(
                              color:ColorResources.getTextColor(context),
                              fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      InkWell(
                        onTap: (){

                          setState(() {
                            pj=true;
                          });
                          openwhatsapp();
                        },
                        child: Container(
                          height: 50,width: 150,
                          decoration: BoxDecoration(
                            color: pj==true? Color(0xffff7f00):Color(0xFFADC4C8),


                            borderRadius:
                            BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Center(child: Text('WHATSAPP',style: TextStyle(
                              color:ColorResources.getTextColor(context),
                              fontWeight: FontWeight.bold),)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50,),
                  Center(
                      child:
                      Text('Discription',
                          style: poppinsMedium.copyWith(fontSize:
                          Dimensions.FONT_SIZE_LARGE))),

                  SingleChildScrollView(
                    padding: const EdgeInsets.all(8.0),
                    physics: const BouncingScrollPhysics(),
                    child: Expanded(
                      child: Text(widget.description,
                          textAlign: TextAlign.justify,
                            style: poppinsMedium.copyWith(fontSize:
                            Dimensions.FONT_SIZE_EXTRA_SMALL)),

                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    ));
  }

  _launchCaller() async {
    var url = "tel:${widget.number}";
    if (await canLaunch(url)) {
      await launch(url);
    } else    {
      throw 'Could not launch $url';
    }
  }
  openwhatsapp() async{
    var whatsapp =widget.whatsappnumber;
    var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=hello";
    var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("hello")}";

    if( await canLaunch(whatsappURl_android)){
      await launch(whatsappURl_android);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: new Text("whatsapp no installed")));
    }
  }
}
