import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/fetchdataapi/Model/ViewPlace.dart';
import 'package:flutter_app/fetchdataapi/NetwrokUtils.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart' as Poly;
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:flutter_polyline_points/flutter_polyline_points.dart';
//import 'config.dart';

class map_open extends StatefulWidget {


  double _destLatitude,_destLongitude;
  map_open(@required this._destLatitude,@required this._destLongitude);

  @override
  _map_openState createState() => new _map_openState();
}

class _map_openState extends State<map_open> {

  LocationData _startLocation;
  LocationData _currentLocation;
//  List<GetViewPlace> getviewplace = new List();
  double _originLatitude , _originLongitude ;
//  double _destLatitude = 21.2378788, _destLongitude = 72.8633633;
  String googleAPiKey = "AIzaSyDk7xiRp1LsCU7l6-MJSriKpV9RPiWFEOg";
  StreamSubscription<LocationData> _locationSubscription;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  Location _locationService  = new Location();
  bool _permission = false;
  String error;
  Poly.PolylinePoints polylinePoints = Poly.PolylinePoints();
  bool currentWidget = true;
  List<LatLng> polylineCoordinates = [];
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _initialCamera = CameraPosition(
    target: LatLng(0, 0),
    zoom: 4,
  );

  CameraPosition _currentCameraPosition;
NetworkUtil networkUtil;
  GoogleMap googleMap;

  @override
  void initState() {
    super.initState();
//    _addMarker(LatLng(result.latitude, result.longitude), "origin", BitmapDescriptor.defaultMarker);

//    getdata();

    initPlatformState();




    _addMarker(LatLng(widget._destLatitude, widget._destLongitude), "destination", BitmapDescriptor.defaultMarkerWithHue(90));
//    slowRefresh();





    _addPolyLine();
    _getPolyline();
  }



  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    await _locationService.changeSettings(accuracy: LocationAccuracy.HIGH, interval: 1000);

    LocationData location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {
          location = await _locationService.getLocation();

          _locationSubscription = _locationService.onLocationChanged().listen((LocationData result) async {
            _currentCameraPosition = CameraPosition(
                target: LatLng(result.latitude, result.longitude),
                zoom: 16
            );

            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(_currentCameraPosition));

            _originLatitude=result.latitude;
            _originLongitude=result.longitude;
            _addPolyLine();
            _getPolyline();
            if(mounted){
              setState(() {
                _currentLocation = result;
                _addPolyLine();
                _getPolyline();

              });
            }
          });
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if(serviceStatusResult){
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      location = null;
    }

    setState(() {
      _startLocation = location;
    });

  }

  slowRefresh() async {
    _locationSubscription.cancel();
    await _locationService.changeSettings(accuracy: LocationAccuracy.BALANCED, interval: 10000);
    _locationSubscription = _locationService.onLocationChanged().listen((LocationData result) {

      _originLatitude=result.latitude;
      _originLongitude=result.longitude;


      if(mounted){
        setState(() {
          _currentLocation = result;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets;

    googleMap = GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      tiltGesturesEnabled: true,
      compassEnabled: true,
      scrollGesturesEnabled: true,
      zoomGesturesEnabled: true,
      markers: Set<Marker>.of(markers.values),
      initialCameraPosition: _initialCamera,
      polylines: Set<Polyline>.of(polylines.values),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );


    widgets = [
      Center(
        child: SizedBox(

            child: googleMap
        ),
      ),
    ];




    return new MaterialApp(
        home: new Scaffold(

          body: Container(


            child: googleMap
          ),


        )
    );
  }
  _addMarker(LatLng position, String id, BitmapDescriptor descriptor)
  {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }
  _addPolyLine()
  {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.red, points: polylineCoordinates
    );
    polylines[id] = polyline;
    setState(() {
    });
  }
  _getPolyline()async
  {
    List<Poly.PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates(googleAPiKey,
        _originLatitude, _originLongitude,widget._destLatitude, widget._destLongitude);
    if(result.isNotEmpty){
      result.forEach((Poly.PointLatLng point){
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      );
    }
//    _addPolyLine();
  }

}