import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/auth'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'expiresInMins': 30,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // JSON with token, user info, etc.
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  Future<void> logout() async {
    // Simulasi logout, biasanya di sini kita bisa menghapus token lokal atau
    // memanggil endpoint API jika ada.

    // Jika API menyediakan endpoint logout, kamu bisa gunakan ini:
    /*
    final response = await http.post(
      Uri.parse('https://dummyjson.com/auth/logout'),
      headers: {'Authorization': 'Bearer your_token_here'},
    );

    if (response.statusCode != 200) {
      throw Exception('Logout failed');
    }
    */

    // Karena dummyjson.com tidak punya endpoint logout, kita kosongkan saja
    await Future.delayed(Duration(milliseconds: 500)); // simulasi delay
    return;
  }
}
