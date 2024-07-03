import 'dart:convert';

import 'package:http/http.dart' as http;

  var apiLink = "https://opentdb.com/api.php?amount=10&category=18";

  getQuizData() async {
    var res = await http.get(Uri.parse(apiLink));

    if(res.statusCode == 200){
      var data = jsonDecode(res.body.toString());
      return data;
    }
  }