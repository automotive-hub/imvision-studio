import 'package:http/http.dart' as http;

class SubmitVinSearch {
  Future<String> submitVin(String vinId) async {
    final response = await http.get(Uri.parse(vinId));

    if (response.statusCode == 200) {
      print(response);
      return 'dasda';
    } else {
      throw Exception('Failed to load album');
    }
  }
}
