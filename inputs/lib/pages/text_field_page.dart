import 'package:flutter/material.dart';
import 'package:inputs/models/country.dart';
import 'package:inputs/constants/countries.dart';
import 'package:flutter/services.dart';
import 'package:inputs/utils/capitalize_input_formatter.dart';

class TextFieldPage extends StatefulWidget {
  const TextFieldPage({Key? key}) : super(key: key);

  @override
  State<TextFieldPage> createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  final _textEditingController = TextEditingController();
  late final List<Country> _countries;

  @override
  void initState() {
    super.initState();
    _countries = countries
        .map(
          (e) => Country.fromJson(e),
        )
        .toList();
    _textEditingController.text = 'Ec';
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _textEditingController.text;
    late final List<Country> filteredList;
    if (query.isEmpty) {
      filteredList = _countries;
    } else {
      filteredList = _countries
          .where(
            (e) => e.name.toLowerCase().contains(
                  query.toLowerCase(),
                ),
          )
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: TextField(
          controller: _textEditingController,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'^[a-zA-Z\s]*$'),
            ),
            CapitalizeInputFormatter(),
          ],
          onChanged: (_) {
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: "Search ...",
            prefixIcon: const Icon(
              Icons.search_rounded,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                _textEditingController.text = '';

                FocusScope.of(context).unfocus();
              },
              icon: const Icon(Icons.clear),
            ),
            hintStyle: const TextStyle(
              color: Colors.black26,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 12,
            ),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
      body: ListView.builder(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemBuilder: (_, index) {
          final country = filteredList[index];
          return ListTile(
            title: Text(country.name),
          );
        },
        itemCount: filteredList.length,
      ),
    );
  }
}
