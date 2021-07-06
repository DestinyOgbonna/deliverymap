import 'dart:async';

import 'package:deliverymap/Assistant/assistant_methods.dart';
import 'package:deliverymap/DataHandler/app_data.dart';
import 'package:deliverymap/widgets/Divider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapcontroller;

  //global key created for the opening of the drawer
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

//Getting User Location Start..
  // creating an instance of position to get the user lat and long  current position in the mao
   late Position currentPosition;
   var geolocator = Geolocator();

   double bottomPadding = 0;

   //creating a method for the user current location
   void locatePosition()async{
     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
     currentPosition = position;

     LatLng latlngPosition = LatLng(position.latitude,position.longitude);

     //Getting User Location End..

     //Making the Camera move according to new Position
     CameraPosition cameraPosition =  CameraPosition(target: latlngPosition, zoom: 14);
     newGoogleMapcontroller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address = await AssistantMethods.searchCoordinateAddress(position, context);
    // ignore: avoid_print
    print('This is your Address :: ' + address);
   }

  //creating a variable for the camera location to be called in the map
  static const CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    key: scaffoldKey,


      //  Drawer Navigation Start

      drawer: Container(
        color: Colors.white,
        width: 300.0,
        child: Drawer(
          child: ListView(
            children: [
              // ignore: sized_box_for_whitespace
              Container(
                  height: 205.0,
                  child: DrawerHeader(
                    decoration:const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                         UserAccountsDrawerHeader(
                          accountName: Text(
                            'Destiny Ogbonna', style: GoogleFonts.montserrat(
                            color: Colors.black,),),
                          accountEmail: Text('destinyogbonna@gmail.com',
                            style: GoogleFonts.montserrat(color: Colors
                                .black,),),
                          currentAccountPicture: GestureDetector(
                            child: const  CircleAvatar(
                           backgroundImage: AssetImage('images/icons/user_icon.jpg'),
                            ),
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),

                      ],
                    ),
                  )

              ),

             const DividerWidget(),

             const  SizedBox(height: 11.0,),

              //Drawer Controllers Start

              ListTile(
                leading:const Icon(Icons.history),
                title: Text('Booking History', style: GoogleFonts.montserrat(fontSize: 15.0,),),
              ),
              ListTile(
                leading:const Icon(Icons.person),
                title: Text('Profile', style: GoogleFonts.montserrat(fontSize: 15.0,),),
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: Text('About', style: GoogleFonts.montserrat(fontSize: 15.0,),),
              ),


              //Drawer Controllers End
            ],
          ),
        ),


      ),
      //  Drawer Navigation End

      //Displaying the GoogleMap Start
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPadding),
            mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: _kGooglePlex,

            //displaying the location button start.
            myLocationButtonEnabled:true ,
            zoomGesturesEnabled: true,

            //displaying the location button End.

            //creating the googleMap Controller
            onMapCreated: (GoogleMapController controller)
            {
              _controllerGoogleMap.complete(controller);
              newGoogleMapcontroller = controller;

              setState(() {
                bottomPadding = 300.0;
              });

              //calling the new camera position to locate new area in the google map
              locatePosition();
            },
          ),

          //Displaying the GoogleMap End

//Drawer Hamburger Button Start

        Positioned(
          top: 65.0,
          left: 22.0,
          child: GestureDetector(
            onTap: (){
              //calling the scaffoldKey to open the nav Drawer
                scaffoldKey.currentState!.openDrawer();
            },
            child: Container(
              decoration: BoxDecoration(
                color:Colors.orangeAccent,
                borderRadius: BorderRadius.circular(22.0),
                  boxShadow:const [
    BoxShadow(
      color: Colors.black,
      blurRadius: 6.0,
      spreadRadius: 0.5,
      offset: Offset(
            0.7, 0.7
      )
    ),
                  ]
              ),
              child:const CircleAvatar(
                backgroundColor: Colors.white,
                  child: Icon(Icons.menu, color: Colors.black,),
                radius: 20.0,
              ),
            ),
          ),
        ),

          //Drawer Hamburger Button End


          //Botton Container Start
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 300.0,
              decoration: const BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        0.7,
                        0.7,
                      ))
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const    SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      'Hi, there',
                      style: GoogleFonts.montserrat(fontSize: 12.0, color: Colors.white),
                    ),
                    Text(
                      'Deliver to?',
                      style: GoogleFonts.montserrat(fontSize: 20.0,color: Colors.white),
                    ),
                  const   SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow:const  [
                          BoxShadow(
                              color: Colors.black54,
                              blurRadius: 6.0,
                              spreadRadius: 0.5,
                              offset: Offset(
                                0.7,
                                0.7,
                              ))
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children:const [
                         Icon(
                              Icons.search,
                              color: Colors.orangeAccent,
                            ),
                          SizedBox(
                              width: 10.0,
                            ),
                         Text('Search Drop Location'),
                          ],
                        ),
                      ),
                    ),
                const    SizedBox(
                      height: 24.0,
                    ),
                    Row(
                      children: [
                    const    Icon(Icons.home, color: Colors.white),
                    const    SizedBox(width: 12.0),
                        Column(
                          children: [
                            // ignore: unnecessary_null_comparison
                            Text(Provider.of<AppData>(context).pickUpLocation != null ?
                            Provider.of<AppData>(context).pickUpLocation.placeName
                        : 'Add Home',

                                style:GoogleFonts.montserrat(color: Colors.white)),
                        const    SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              'Residential Address',
                              style: GoogleFonts.montserrat(
                                  color: Colors.white70, fontSize: 12.0,),
                            ),
                          ],
                        )
                      ],
                    ),

                 const   SizedBox(
                      height: 10.0,
                    ),
                const    DividerWidget(),
                const    SizedBox(height: 16.0,),
                    Row(
                      children: [
                   const     Icon(Icons.work, color: Colors.white),
                   const  SizedBox(width: 12.0),
                        Column(
                          children: [
                            Text('Add Work',style: GoogleFonts.montserrat(
                                color: Colors.white, fontSize: 12.0),),
                         const   SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              'Office Address',
                              style: GoogleFonts.montserrat(
                                  color: Colors.white70, fontSize: 12.0),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

          //Botton Container End
        ],
      ),
    );
  }
}
