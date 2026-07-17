import 'package:image_picker/image_picker.dart';

abstract class MediaService {
  Future<XFile?> pickImage(ImageSource source, {int imageQuality});
  Future<List<XFile>> pickMultiImage({int imageQuality});
}

class MediaServiceImpl implements MediaService {
  final ImagePicker _picker;

  MediaServiceImpl({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  @override
  Future<XFile?> pickImage(ImageSource source, {int imageQuality = 70}) async {
    return _picker.pickImage(source: source, imageQuality: imageQuality);
  }

  @override
  Future<List<XFile>> pickMultiImage({int imageQuality = 70}) async {
    return _picker.pickMultiImage(imageQuality: imageQuality);
  }
}
