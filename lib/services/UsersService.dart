import 'package:http/http.dart' as http;

import 'package:chat_app/global/Environment.dart';
import 'package:chat_app/services/AuthServices.dart';
import 'package:chat_app/models/UsersResponse.dart';
import 'package:chat_app/models/User.dart';

class UsersService {
  Future<List<User>> getUsers() async {
    try {
      final resp = await http.get('${Environment.apiUrl}/users', headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken()
      });
      final usersResponse = usersResponseFromJson(resp.body);
      return usersResponse.users;
    } catch (e) {
      return [];
    }
  }
}
