import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as GeoLocation;
import 'package:taukeet/src/entities/address.dart';
import 'package:taukeet/src/libraries/settings_library.dart';
import 'package:taukeet/src/modules/settings/cubit/settings_cubit.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({required this.settingsCubit})
      : super(LocationState(
          isFetchingLocation: false,
          address: SettingsLibrary.getSettings().address,
        ));

  final SettingsCubit settingsCubit;

  String _makeAddress(Placemark placemark) {
    final components = [placemark.locality, placemark.country];

    // Filter out null and empty strings, then join with ", " separator
    final filteredComponents =
        components.where((component) => component?.isNotEmpty == true);

    // Join the filtered components into a single string with ", " separator
    final address = filteredComponents.join(', ');

    return address;
  }

  Future<void> fetchLocation() async {
    // emit location is fetching state
    emit(state.copyWith(isFetchingLocation: true));

    GeoLocation.Location location = GeoLocation.Location();

    // Check if location service is enable
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // Check if permission is granted
    GeoLocation.PermissionStatus permissionGranted =
        await location.hasPermission();
    if (permissionGranted == GeoLocation.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != GeoLocation.PermissionStatus.granted) {
        return;
      }
    }

    final locationData = await location.getLocation();
    final List<Placemark> placemarks = await placemarkFromCoordinates(
        locationData.latitude!, locationData.longitude!);

    String addressStr = _makeAddress(placemarks.first);
    Address address = Address(
      latitude: locationData.latitude!,
      longitude: locationData.longitude!,
      address: addressStr.isEmpty
          ? "${locationData.latitude}, ${locationData.longitude}"
          : addressStr,
    );

    await SettingsLibrary.updateAddress(address);

    emit(state.copyWith(isFetchingLocation: false, address: address));
    settingsCubit.updateLocation(address);
  }
}
