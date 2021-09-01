import 'package:biometric_storage/biometric_storage.dart';

class BiometricStorageMock implements BiometricStorage {
  final bool isAuth;

  BiometricStorageMock({this.isAuth = false});

  final Map<String, String> map = <String, String>{};

  @override
  Future<CanAuthenticateResponse> canAuthenticate() async =>
      isAuth ? CanAuthenticateResponse.success : CanAuthenticateResponse.statusUnknown;

  @override
  Future<bool?> delete(String name, PromptInfo promptInfo) async {
    map.remove(name);
  }

  @override
  Future<BiometricStorageFile> getStorage(String name,
      {StorageFileInitOptions? options,
      bool forceInit = false,
      PromptInfo promptInfo = PromptInfo.defaultValues}) async {
    return BiometricStorageFile(this, 'Hello', PromptInfo.defaultValues);
  }

  @override
  Future<bool> linuxCheckAppArmorError() {
    // TODO: implement linuxCheckAppArmorError
    throw UnimplementedError();
  }

  @override
  Future<String?> read(String name, PromptInfo promptInfo) async {
    return map[name];
  }

  @override
  Future<void> write(String name, String content, PromptInfo promptInfo) async {
    map[name] = content;
  }
}
