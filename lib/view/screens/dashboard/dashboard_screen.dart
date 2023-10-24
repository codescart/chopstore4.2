import 'package:chopstore/view/screens/accessories/staff.dart';
import 'package:flutter/material.dart';
import 'package:chopstore/localization/language_constrants.dart';
import 'package:chopstore/utill/images.dart';
import 'package:chopstore/view/screens/address/address_screen.dart';
import 'package:chopstore/view/screens/cart/cart_screen.dart';
import 'package:chopstore/view/screens/category/all_category_screen.dart';
import 'package:chopstore/view/screens/chat/chat_screen.dart';
import 'package:chopstore/view/screens/coupon/coupon_screen.dart';
import 'package:chopstore/view/screens/home/home_screen.dart';
import 'package:chopstore/view/screens/order/my_order_screen.dart';
import 'package:chopstore/view/screens/settings/setting_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;
  List<Widget> _screens;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _screens = [
      HomeScreen(),
      AllCategoryScreen(),
      CartScreen(),
      MyOrderScreen(),
      AddressScreen(),
      CouponScreen(),
      ChatScreen(orderModel: null),
      SettingsScreen(),
      mainassories(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          currentIndex: _pageIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            _barItem(Images.home, getTranslated('home', context), 0),
            _barItem(Images.list, getTranslated('all_categories', context), 1),
            _barItem(Images.order_bag, getTranslated('shopping_bag', context), 2),
            _barItem(Images.order_list, getTranslated('my_order', context), 3),
            _barItem(Images.location, getTranslated('address', context), 4),
            _barItem(Images.coupon, getTranslated('coupon', context), 5),
            _barItem(Images.chat, getTranslated('live_chat', context), 6),
            _barItem(Images.settings, getTranslated('settings', context), 7),
            _barItem(Images.settings, getTranslated('Accessories', context), 8),
          ],
          onTap: (int index) {
            _setPage(index);
          },
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _barItem(String icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Image.asset(icon, color: index == _pageIndex ? Theme.of(context).primaryColor : Colors.grey, width: 25),
      label: label,
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
// class JobsState extends State<Jobs> {
//   final _debouncer = Debouncer();
//
//   List<Subject> ulist = [];
//   List<Subject> userLists = [];
//   //API call for All Subject List
//
//   String url = 'https://type.fit/api/quotes';
//
//   Future<List<Subject>> getAllulistList() async {
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         // print(response.body);
//         List<Subject> list = parseAgents(response.body);
//         return list;
//       } else {
//         throw Exception('Error');
//       }
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }
//
//   static List<Subject> parseAgents(String responseBody) {
//     final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//     return parsed.map<Subject>((json) => Subject.fromJson(json)).toList();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getAllulistList().then((subjectFromServer) {
//       setState(() {
//         ulist = subjectFromServer;
//         userLists = ulist;
//       });
//     });
//   }
//
//   //Main Widget
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'All Users',
//           style: TextStyle(fontSize: 25),
//         ),
//       ),
//       body: Column(
//         children: <Widget>[
//           //Search Bar to List of typed Subject
//           Container(
//             padding: const EdgeInsets.all(15),
//             child: TextField(
//               textInputAction: TextInputAction.search,
//               decoration: InputDecoration(
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25.0),
//                   borderSide: const BorderSide(
//                     color: Colors.grey,
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                   borderSide: const BorderSide(
//                     color: Colors.blue,
//                   ),
//                 ),
//                 suffixIcon: const InkWell(
//                   child: Icon(Icons.search),
//                 ),
//                 contentPadding: const EdgeInsets.all(15.0),
//                 hintText: 'Search ',
//               ),
//               onChanged: (string) {
//                 _debouncer.run(() {
//                   setState(() {
//                     userLists = ulist
//                         .where(
//                           (u) => (u.text.toLowerCase().contains(
//                         string.toLowerCase(),
//                       )),
//                     )
//                         .toList();
//                   });
//                 });
//               },
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               shrinkWrap: true,
//               physics: const ClampingScrollPhysics(),
//               padding: const EdgeInsets.all(5),
//               itemCount: userLists.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     side: BorderSide(
//                       color: Colors.grey.shade300,
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         ListTile(
//                           title: Text(
//                             userLists[index].text,
//                             style: const TextStyle(fontSize: 16),
//                           ),
//                           subtitle: Text(
//                             userLists[index].author ?? "null",
//                             style: const TextStyle(fontSize: 16),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// //Declare Subject class for json data or parameters of json string/data
// //Class For Subject
// class Subject {
//   var text;
//   var author;
//   Subject({
//     required this.text,
//     required this.author,
//   });
//
//   factory Subject.fromJson(Map<dynamic, dynamic> json) {
//     return Subject(
//       text: json['text'],
//       author: json['author'],
//     );
//   }
// }