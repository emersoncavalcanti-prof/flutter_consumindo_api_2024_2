import 'package:flutter/material.dart';
import 'package:flutter_consumindo_api/data/http/exceptions.dart';
import 'package:flutter_consumindo_api/data/local/local_storage.dart';
import 'package:flutter_consumindo_api/data/models/user_model.dart';
import 'package:flutter_consumindo_api/data/repositories/user_repository.dart';

class UserStore {
  final UserRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<List<UserModel>> state = ValueNotifier([]);
  final ValueNotifier<UserModel?> currentUser = ValueNotifier<UserModel?>(null);
  final ValueNotifier<String> error = ValueNotifier('');

  UserStore({required this.repository});

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    error.value = '';

    try {
      final Map<String, dynamic> data = {
        "email": email,
        "password": password,
      };

      final user = await repository.login(data: data);

      if (user.token.isNotEmpty) {
        LocalStorage.saveString('token', user.token);
      }

      currentUser.value = user;
      return user;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
    return null;
  }
}
