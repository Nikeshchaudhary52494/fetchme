import 'dart:io';
import 'package:fetchme/providers/product_data_provider.dart';
import 'package:fetchme/providers/theme_provider.dart';
import 'package:fetchme/widgets/my_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tflite_v2/tflite_v2.dart';
import '../models/product_model.dart';

class MySearchBar2 extends StatefulWidget {
  final List<Product> productList;
  final void Function(List<Product>) onSearchResultsUpdated;

  const MySearchBar2({
    Key? key,
    required this.productList,
    required this.onSearchResultsUpdated,
  }) : super(key: key);

  @override
  State<MySearchBar2> createState() => _MySearchBar2State();
}

class _MySearchBar2State extends State<MySearchBar2> {
  List<Product> searchResults = [];
  bool showSearchResults = false;

  // late File _image;
  late List _results;
  bool imageSelect = false;
  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    ))!;
    print("Models loading status: $res");
  }

  Future imageClassification(File image) async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _results = recognitions!;
      // _image = image;
      imageSelect = true;

      if (_results.isNotEmpty) {
        final String resultLabel = _results[0]['label'] ?? '';
        print(resultLabel);
        _performSearch(resultLabel);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          margin:
              const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onBackground,
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: [
              const SizedBox(width: 8.0),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _SearchField(onSearch: _performSearch),
                ),
              ),
              const SizedBox(width: 8.0),
              IconButton(
                onPressed: () {
                  showImagePicker(context, (File image) {
                    imageClassification(image);
                  });
                },
                icon: const Icon(Icons.camera_alt),
              ),
              const SizedBox(width: 8.0),
            ],
          ),
        ),
      ],
    );
  }

  void _performSearch(String query) {
    setState(() {
      searchResults = Provider.of<ProductDataProvider>(context, listen: false)
          .searchFromAllProducts(query);
      showSearchResults = searchResults.isNotEmpty;
    });
    widget.onSearchResultsUpdated(searchResults);
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final Function(String) onSearch;

  _SearchField({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onSubmitted: onSearch,
      decoration: const InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
      ),
    );
  }
}
