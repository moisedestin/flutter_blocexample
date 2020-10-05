import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blocexample/data/ListingRepository.dart';
import 'package:flutter_blocexample/models/ImageForm.dart';
import 'package:flutter_blocexample/models/ListingForm.dart';

import '../models/ImageForm.dart';
import '../models/ListingForm.dart';

part 'ListingFormEvent.dart';
part 'ListingFormState.dart';

class ListingFormBloc extends Bloc<ListingFormEvent, ListingFormState> {
  ListingFormBloc({@required ListingRepository listingRepository})
      : assert(listingRepository != null),
        _listingRepository = listingRepository,
        super(ListingFormInitialState());

  final ListingRepository _listingRepository;

  @override
  void onTransition(Transition<ListingFormEvent, ListingFormState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<ListingFormState> mapEventToState(ListingFormEvent event) async* {
    final _state = state;

    if (event is InitImageFormList) {
      final listingForm = _listingRepository.loadListing();
      yield ListingFormLoaded(listingForm);
      return;
    }

    if (event is AddNewImage) {
      if (_state is ListingFormLoaded) {
        final listingForm = _state.listingForm;

        final newFormImages = List<ImageForm>.from(listingForm.imageFormList)
          ..add(ImageForm(imagePath: event.imageForm.imagePath));

        yield ListingFormLoaded(ListingForm(imageFormList: newFormImages));
      }
    }
  }
}
