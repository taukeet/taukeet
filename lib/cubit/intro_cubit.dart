import 'dart:ffi';

import 'package:adhan/adhan.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taukeet/contracts/prayer_service.dart';

part 'intro_state.dart';

class IntroCubit extends Cubit<IntroState> {
  IntroCubit({
    required PrayerService prayerService,
  })  : _prayerService = prayerService,
        super(const IntroState());

  final PrayerService _prayerService;

  void initialize() {
    emit(
      state.copyWith(
        calculationMethods: _prayerService.calculationMethods,
      ),
    );
  }

  void locateUser() async {
    bool serviceEnabled;
    LocationPermission permission;

    emit(state.copyWith(
      isAddressFetching: true,
    ));

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      // return Future.error('Location services are disabled.');
      print("Location services are disabled.");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        // return Future.error('Location permissions are denied');
        print("Location permissions are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
      print(
          "Location permissions are permanently denied, we cannot request permissions.");
    }

    final result = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(result.latitude, result.longitude);

    String address = placemarks.first.administrativeArea ?? "";
    address = placemarks.first.country != null
        ? address + ", " + placemarks.first.country!
        : "";
    address = address != ""
        ? address
        : result.latitude.toString() + ", " + result.longitude.toString();

    emit(state.copyWith(
      isAddressFetching: false,
      isAddressFetched: true,
      address: address,
      latitude: result.latitude,
      longitude: result.longitude,
    ));
  }

  void changeCalculationMethod(String method) => emit(
        state.copyWith(
          calculationMethod: method,
        ),
      );

  void changeMadhab(String madhab) => emit(
        state.copyWith(
          madhab: madhab,
        ),
      );
}
