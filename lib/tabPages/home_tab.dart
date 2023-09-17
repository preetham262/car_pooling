import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/global/location_services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:Carpooling/tabPages/home_geolocator.dart';



class HomeTabPage extends StatefulWidget  {
  const HomeTabPage({Key? key}) : super(key: key);

  @override
  State<HomeTabPage> createState(
      ) => _HomeTabPageState();
}



class _HomeTabPageState extends State<HomeTabPage>
{

  late GoogleMapController newGoogleMapController;
  final Completer<GoogleMapController> _controllerGoogleMaps = Completer();

  TextEditingController _searchController = TextEditingController();


  // Initialize _kGooglePlexMarker with initial values
  Marker _kGooglePlexMarker = Marker(
    markerId: MarkerId('kGooglePlex'),
    infoWindow: InfoWindow(title: "Google Plex"),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(19.1231827,72.8335405),
  );

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(19.1231827,72.8335405),
    zoom: 14.4746,
  );


  static final CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(19.111750, 72.839370),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  static final Marker _kLakeMarker = Marker(
    markerId: MarkerId('kLakeMarker'),
    infoWindow: InfoWindow(title: "Lake"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: LatLng(19.111750, 72.839370),
  );

  blackThemeGoogleMap()
  {
    newGoogleMapController.setMapStyle('''
                    [
                      {
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "featureType": "administrative.locality",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#263c3f"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#6b9a76"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#38414e"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#212a37"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#9ca5b3"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#1f2835"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#f3d19c"
                          }
                        ]
                      },
                      {
                        "featureType": "transit",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#2f3948"
                          }
                        ]
                      },
                      {
                        "featureType": "transit.station",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#515c6d"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      }
                    ]
                ''');
  }

  static const Polyline _kPolyline = const Polyline(polylineId: PolylineId('_kPolyline'),
    points: [
      LatLng(19.111750, 72.839370),
      LatLng(19.111750, 72.839370),

    ],
    width: 5,


  );


  static const Polygon _kPolygons = Polygon(polygonId: PolygonId('_kPolygon'),
    points: [
      LatLng(19.111750, 72.839370),
      LatLng(19.111750, 72.839370),
      LatLng(37.418, -122.002),
      LatLng(37.435, -122.092),

    ],
    strokeWidth: 5,
    strokeColor: Color(0xFF15b495),
    fillColor: Colors.transparent,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Car Pooling'),),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                    controller: _searchController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(hintText: 'Search by City'),
                    onChanged: (value) {
                      print(value);
                    },
                  )),



              IconButton(
                onPressed: () async {
                  var place =
                  await LocationServices().getPlace(_searchController.text);
                  _goToPlace(place);
                },
                icon: Icon(Icons.search),
              ),
            ],),


          Expanded(
            child: GoogleMap(
                mapType: MapType.normal,
                markers: {_kGooglePlexMarker,
                },
                myLocationButtonEnabled: true,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller)
                {
                  _controllerGoogleMaps.complete(controller);
                  newGoogleMapController = controller;

                  // black theme google map
                  blackThemeGoogleMap();
                }
            ),
          ),
        ],


      ),
    );

  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controllerGoogleMaps.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom:12),
      ),
    );
  }


  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controllerGoogleMaps.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

