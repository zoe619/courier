import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tcourier/modules/orders/courier_current_order_status.dart';
import 'package:tcourier/utils/constants.dart';
import 'package:tcourier/utils/margin_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryStatusUpdate extends StatefulWidget {
  final double lat;
  final double lng;

  const DeliveryStatusUpdate({this.lat, this.lng});
  @override
  _DeliveryStatusUpdateState createState() => _DeliveryStatusUpdateState();
}

class _DeliveryStatusUpdateState extends State<DeliveryStatusUpdate> {
  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  GoogleMapController mapController;

  double latitude;
  double longitude;

  // Future<Position> _currentLocation;
  Position _currentPosition;
  Position startCoordinates;

  double startLngg;
  double startLatt;
  double deliveryLat;
  double deliveryLng;

  String mapID;
  List startPlaceMark;

  Set<Marker> markers = {};

  List<Location> startPlacemark;
  List<Location> destinationPlacemark;

  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  String _destinationAddress = '';
  // String _startAddress = '';
  String _currentAddress = '';

  String _placeDistance;

  PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {
      setState(() {
        startLatt = value.latitude;
        startLngg = value.longitude;
      });
    });

    _getCurrentLocation();
    _getAddress();
  }

  launchURL() async {
    String homeLat = "${widget.lat}";
    //  "$deliveryLat";
    String homeLng = "${widget.lng}";
    // "$deliveryLng";
    print(homeLat + homeLng);
    final String googleMapslocationUrl =
        "https://www.google.com/maps/search/?api=1&query=$homeLat,$homeLng";

    final String encodedURl = Uri.encodeFull(googleMapslocationUrl);
    print(googleMapslocationUrl);
    if (await canLaunch(encodedURl)) {
      await launch(encodedURl);
    } else {
      print('Could not launch $encodedURl');
      throw 'Could not launch $encodedURl';
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Open In Maps"),
        icon: Icon(Icons.arrow_forward),
        backgroundColor: redColor,
        onPressed: () {
          launchURL(
              // lat: deliveryLat,
              // lng: deliveryLng,
              );
        },
      ),
      key: _scaffoldKey,
      body: startLngg == null && startLatt == null
          ? Container()
          : ListView(
              children: [
                Stack(
                  children: <Widget>[
                    // Map View
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                      height: height / 2,
                      child: GoogleMap(
                        polylines: Set<Polyline>.of(polylines.values),
                        onMapCreated: (GoogleMapController controller) {
                          mapController = controller;
                        },
                        mapType: MapType.normal,
                        buildingsEnabled: true,
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        zoomGesturesEnabled: true,
                        zoomControlsEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(startLatt, startLngg),
                          zoom: 12,
                        ),
                        markers: Set<Marker>.from(markers),
                      ),
                      //  FutureBuilder(
                      //     future: _currentLocation,
                      //     builder: (context, snapshot) {
                      //       if (snapshot.connectionState == ConnectionState.done) {
                      //         if (snapshot.hasData) {
                      //           // The user location returned from the snapshot
                      //           Position snapshotData = snapshot.data;
                      //           LatLng _userLocation =
                      //               LatLng(snapshotData.latitude, snapshotData.longitude);
                      //           return GoogleMap(
                      //             polylines: Set<Polyline>.of(polylines.values),
                      //             onMapCreated: (GoogleMapController controller) {
                      //               mapController = controller;
                      //             },
                      //             mapType: MapType.normal,
                      //             buildingsEnabled: true,
                      //             myLocationButtonEnabled: true,
                      //             myLocationEnabled: true,
                      //             zoomGesturesEnabled: true,
                      //             zoomControlsEnabled: false,
                      //             initialCameraPosition: CameraPosition(
                      //               target: _userLocation,
                      //               zoom: 12,
                      //             ),
                      //             markers: Set<Marker>.from(markers),
                      //           );
                      //         } else {
                      //           return Center(child: Text("Failed to get user location."));
                      //         }
                      //       }
                      //       // While the connection is not in the done state yet
                      //       return Center(child: CircularProgressIndicator());
                      //     }),
                    ),
                    // Show the place input fields & button for
                    // showing the route
                    SafeArea(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                ),
                                width: width * 0.9,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      // Text(
                                      //   'Places',
                                      //   style: TextStyle(fontSize: 20.0),
                                      // ),
                                      SizedBox(height: 10),
                                      // _textField(
                                      //     label: 'Destination',
                                      //     hint: 'Choose destination',
                                      //     prefixIcon: Icon(Icons.looks_one),
                                      //     controller: destinationAddressController,
                                      //     focusNode: desrinationAddressFocusNode,
                                      //     width: width,
                                      //     locationCallback: (String value) {
                                      //       setState(
                                      //         () {
                                      //           _destinationAddress = value;
                                      //         },
                                      //       );
                                      //     }),
                                      // SizedBox(height: 10),
                                      // Visibility(
                                      //   visible: _placeDistance == null ? false : true,
                                      //   child: Text(
                                      //     'DISTANCE: $_placeDistance km',
                                      //     style: TextStyle(
                                      //       fontSize: 16,
                                      //       fontWeight: FontWeight.bold,
                                      //     ),
                                      //   ),
                                      // ),
                                      // SizedBox(height: 5),
                                      ElevatedButton(
                                        onPressed: (_destinationAddress == '')
                                            ? () async {
                                                startAddressFocusNode.unfocus();
                                                desrinationAddressFocusNode.unfocus();
                                                setState(() {
                                                  if (markers.isNotEmpty) markers.clear();
                                                  if (polylines.isNotEmpty) polylines.clear();
                                                  if (polylineCoordinates.isNotEmpty)
                                                    polylineCoordinates.clear();
                                                  _placeDistance = null;
                                                });
                                                print("==============>>>>>>>>>>>>>>>>>>>");
                                                print(
                                                    "${widget.lat}  ================ ${widget.lng}");
                                                _calculateDistance().then((isCalculated) {
                                                  if (isCalculated) {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content:
                                                            Text('Distance Calculated Sucessfully'),
                                                      ),
                                                    );
                                                  } else {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text('Error Calculating Distance'),
                                                      ),
                                                    );
                                                  }
                                                });
                                              }
                                            : null,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Show Route'.toUpperCase(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              YMargin(80),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                CourierCurrentStatus(),
              ],
            ),
    );
  }

  // Method for retrieving the current location

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        // Store the position in the variable
        _currentPosition = position;

        print('CURRENT POS: $_currentPosition');

        // For moving the camera to current location
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
      await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  // Method for retrieving the address
  _getAddress() async {
    try {
      List<Placemark> p =
          await placemarkFromCoordinates(_currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];
      setState(
        () {
          _currentAddress =
              "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
          print("===========================================================");
          print("===>>>> ${_currentPosition.latitude}     ${_currentPosition.longitude}");
          print("===========================================================");
          startAddressController.text = _currentAddress;
          // _startAddress = _currentAddress;
        },
      );
    } catch (e) {
      print(e);
    }
  }

  // Method for calculating the distance between two places
  Future<bool> _calculateDistance() async {
    try {
      // Retrieving placemarks from addresses
      // List<Location> startPlacemark = await locationFromAddress(_startAddress);

      // List<Location> destinationPlacemark = await locationFromAddress(_destinationAddress);

      // Use the retrieved coordinates of the current position,
      // instead of the address if the start position is user's
      // current position, as it results in better accuracy.
      double startLatitude = _currentPosition.latitude;

      double startLongitude = _currentPosition.longitude;

      double destinationLatitude = widget.lat;
      // destinationPlacemark[0].latitude;
      double destinationLongitude = widget.lng;
      //  destinationPlacemark[0].longitude;

      String startCoordinatesString = '($startLatitude, $startLongitude)';
      String destinationCoordinatesString = '($destinationLatitude, $destinationLongitude)';
      print("======================================>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ");
      print(destinationCoordinatesString);
      // Start Location Marker
      Marker startMarker = Marker(
        markerId: MarkerId(startCoordinatesString),
        position: LatLng(startLatitude, startLongitude),
        infoWindow: InfoWindow(
          title: 'Start $startCoordinatesString',
          // snippet: _startAddress,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Destination Location Marker
      Marker destinationMarker = Marker(
        markerId: MarkerId(destinationCoordinatesString),
        position: LatLng(destinationLatitude, destinationLongitude),
        infoWindow: InfoWindow(
          title: 'Destination $destinationCoordinatesString',
          snippet: _destinationAddress,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Adding the markers to the list
      markers.add(startMarker);
      markers.add(destinationMarker);

      print(
        'START COORDINATES: ($startLatitude, $startLongitude)',
      );
      print(
        'DESTINATION COORDINATES: ($destinationLatitude, $destinationLongitude)',
      );
      setState(() {
        deliveryLat = destinationLatitude;
        deliveryLng = destinationLongitude;
      });

      // Calculating to check that the position relative
      // to the frame, and pan & zoom the camera accordingly.
      double miny = (startLatitude <= destinationLatitude) ? startLatitude : destinationLatitude;
      double minx =
          (startLongitude <= destinationLongitude) ? startLongitude : destinationLongitude;
      double maxy = (startLatitude <= destinationLatitude) ? destinationLatitude : startLatitude;
      double maxx =
          (startLongitude <= destinationLongitude) ? destinationLongitude : startLongitude;

      double southWestLatitude = miny;
      double southWestLongitude = minx;

      double northEastLatitude = maxy;
      double northEastLongitude = maxx;

      // Accommodate the two locations within the
      // camera view of the map
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          100.0,
        ),
      );

      // Calculating the distance between the start and the end positions
      // with a straight path, without considering any route
      // double distanceInMeters = await Geolocator().bearingBetween(
      //   startCoordinates.latitude,
      //   startCoordinates.longitude,
      //   destinationCoordinates.latitude,
      //   destinationCoordinates.longitude,
      // );

      await _createPolylines(
          startLatitude, startLongitude, destinationLatitude, destinationLongitude);

      double totalDistance = 0.0;

      // Calculating the total distance by adding the distance
      // between small segments
      for (int i = 0; i < polylineCoordinates.length - 1; i++) {
        totalDistance += _coordinateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude,
        );
      }

      setState(() {
        _placeDistance = totalDistance.toStringAsFixed(2);
        print('DISTANCE: $_placeDistance km');
      });

      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  // Formula for calculating distance between two coordinates
  // https://stackoverflow.com/a/54138876/11910277
  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a =
        0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  // Create the polylines for showing the route between two places
  _createPolylines(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCGFNvnNS9xY019XQjDz_Tl1FB8gOFEmGU", // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.transit,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
  }

  // ignore: unused_element
  Widget _textField({
    TextEditingController controller,
    FocusNode focusNode,
    String label,
    String hint,
    double width,
    Icon prefixIcon,
    Widget suffixIcon,
    Function(String) locationCallback,
  }) {
    return Container(
      width: width * 0.8,
      child: TextField(
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        focusNode: focusNode,
        decoration: new InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue.shade300,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(15),
          hintText: hint,
        ),
      ),
    );
  }
}
