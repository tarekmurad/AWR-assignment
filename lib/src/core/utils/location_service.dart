import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  late List<LatLng> _routePoints;
  late StreamController<LatLng> _locationController;

  Stream<LatLng> get locationStream => _locationController.stream;

  LocationService() {
    _routePoints = [
      const LatLng(25.199429016702688, 55.27507425522772),
      const LatLng(25.19976128047399, 55.276659164149194),
      const LatLng(25.20070497201089, 55.27766121830333),
      const LatLng(25.201186066842276, 55.27798841965977),
      const LatLng(25.203054917190016, 55.27434830456928),
      const LatLng(25.20383205443402, 55.273448500839045),
      const LatLng(25.204202118044694, 55.273019049058696),
      const LatLng(25.20564535537731, 55.27203744498936),
      const LatLng(25.20675552629728, 55.27254869710881),
      const LatLng(25.207366116082866, 55.2729576989926),
      const LatLng(25.209715932677284, 55.274573255690065),
      const LatLng(25.211048092013147, 55.27512540797907),
      const LatLng(25.213286826940653, 55.276802314930876),
      const LatLng(25.214581944169165, 55.27759986843855),
      const LatLng(25.216765110367298, 55.27901092428824),
      const LatLng(25.217671667870974, 55.279726677255475),
      const LatLng(25.22037279915831, 55.28156718488549),
      const LatLng(25.222763237996826, 55.283280941878516),
      const LatLng(25.224313602741155, 55.28436941678441),
      const LatLng(25.226000125846504, 55.28551578961238),
      const LatLng(25.228074202796442, 55.28700954772792),
      const LatLng(25.22907980312968, 55.28863068056648),
      const LatLng(25.22984447287571, 55.29112027782615),
      const LatLng(25.230724360812246, 55.29460571342907),
      const LatLng(25.231363323061082, 55.2972805826127),
      const LatLng(25.231862921912413, 55.30041593289329),
      const LatLng(25.232288192129012, 55.30221095772743),
      const LatLng(25.2328809905551, 55.303336409805986),
      const LatLng(25.234856780823655, 55.30460501011074),
      const LatLng(25.236487150650063, 55.30518375798757),
      const LatLng(25.238715786098915, 55.306043612483016),
      const LatLng(25.240226448537836, 55.30782946307436),
      const LatLng(25.241108906027172, 55.30854049618017),
      const LatLng(25.243935718234663, 55.31105391553096),
      const LatLng(25.247450446082336, 55.313964191222574),
      const LatLng(25.24876657326917, 55.31745321413715),
      const LatLng(25.249768615090122, 55.31917292211401),
      const LatLng(25.251727807309422, 55.320958772705346),
      const LatLng(25.257934200176077, 55.326399003505976),
      const LatLng(25.258038883597944, 55.328763601974146),
      const LatLng(25.257904290610373, 55.33003684730316),
      const LatLng(25.25759023972598, 55.33097937955971),
      const LatLng(25.25998298797378, 55.3325171957663),
    ];
    _locationController = StreamController<LatLng>();
    _startSimulation();
  }

  void _startSimulation() {
    int currentIndex = 0;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentIndex < _routePoints.length) {
        _locationController.add(_routePoints[currentIndex]);
        currentIndex++;
      } else {
        timer.cancel();
      }
    });
  }

  void dispose() {
    _locationController.close();
  }
}
