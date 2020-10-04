part of 'ListingFormBloc.dart';

abstract class ListingFormState extends Equatable {
  const ListingFormState();

  @override
  List<Object> get props => [];
}

class ListingFormInitialState extends ListingFormState {}

class ListingFormLoaded extends ListingFormState {
  ListingFormLoaded(this.listingForm);

  final ListingForm listingForm;

  @override
  List<Object> get props => [listingForm];
}
