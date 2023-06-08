import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nartus_geocoder/nartus_geocoder.dart';

import 'package:interactive_diary/service_locator/service_locator.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  final GeocoderService _geocoderService =
      ServiceLocator.instance.get<GeocoderService>();

  Future<void> loadAddress(LatLng latLng) async {
    String? address;
    String? business;
    String? postalCode;
    String? countryCode;

    try {
      final LocationDetail gcData = await _geocoderService
          .getCurrentPlaceCoding(latLng.latitude, latLng.longitude);

      address = gcData.address;
      business = gcData.business;
      postalCode = gcData.postalCode;
      countryCode = gcData.countryCode;

      emit(AddressReadyState(
          address: address,
          countryCode: countryCode,
          postalCode: postalCode,
          business: business));
    } on GetAddressFailedException catch (_) {}
  }
}
