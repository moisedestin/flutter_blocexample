import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blocexample/models/ImageForm.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'bloc/ListingFormBloc.dart';
import 'data/ListingRepository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ListingFormPage(),
    );
  }
}

class ListingFormPage extends StatelessWidget {
  const ListingFormPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ListingRepository>(
      create: (_) => ListingRepository(),
      child: BlocProvider<ListingFormBloc>(
        create: (context) => ListingFormBloc(
            listingRepository: context.repository<ListingRepository>())
          ..add(InitImageFormList()),
        child: ListingForm(),
      ),
    );
  }
}

class ListingForm extends StatelessWidget {
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.30,
          child: BlocBuilder<ListingFormBloc, ListingFormState>(
            builder: (context, state) {
              if (state is ListingFormLoaded) {
                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.listingForm.imageFormList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 150,
                          width: 150,
                          child: GestureDetector(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 3, color: Colors.black12),
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 0,
                                child: _MediaWidget(
                                  imageForm:
                                      state.listingForm.imageFormList[index],
                                  index: index,
                                ),
                              ),
                              onTap: () async {
                                var imgFile = await _picker.getImage(
                                    source: ImageSource.camera);

                                context.bloc<ListingFormBloc>().add(AddNewImage(
                                    imageForm:
                                        ImageForm(imagePath: imgFile.path)));
                              }),
                        ),
                      );
                    });
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _MediaWidget extends StatelessWidget {
  const _MediaWidget({
    Key key,
    @required this.imageForm,
    @required this.index,
  }) : super(key: key);

  final ImageForm imageForm;
  final int index;

  @override
  Widget build(BuildContext context) {
    return imageForm.isEmpty
        ? Icon(
            Icons.camera_alt,
            color: Colors.blue,
            size: 36.0,
          )
        : Container(
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.file(
                      File(imageForm.imagePath),
                      fit: BoxFit.cover,
                      height: 400.0,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    padding: EdgeInsets.all(0.0),
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.redAccent,
                      size: 24.0,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          );
  }
}
