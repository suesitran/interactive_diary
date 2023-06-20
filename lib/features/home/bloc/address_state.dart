part of 'address_cubit.dart';

abstract class AddressState extends Equatable {
  const AddressState();
}

class AddressInitial extends AddressState {
  @override
  List<Object> get props => [];
}

class AddressReadyState extends AddressState {
  final String? address;
  final String? countryCode;
  final String? postalCode;
  final String? business;

  const AddressReadyState(
      {required this.address,
      required this.countryCode,
      required this.postalCode,
      required this.business});

  @override
  List<Object?> get props => [address, countryCode, postalCode, business];
}
