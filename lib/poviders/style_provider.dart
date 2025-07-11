import 'package:flutter/foundation.dart';

class StyleProvider with ChangeNotifier {
  String _skinType = '';
  String _hairType = '';
  List<String> _skinCareRoutine = [];
  List<String> _hairCareRoutine = [];
  String _currentStyle = '';
  List<String> _wardrobeItems = [];

  String get skinType => _skinType;
  String get hairType => _hairType;
  List<String> get skinCareRoutine => _skinCareRoutine;
  List<String> get hairCareRoutine => _hairCareRoutine;
  String get currentStyle => _currentStyle;
  List<String> get wardrobeItems => _wardrobeItems;

  void setSkinType(String type) {
    _skinType = type;
    _updateSkinCareRoutine();
    notifyListeners();
  }

  void setHairType(String type) {
    _hairType = type;
    _updateHairCareRoutine();
    notifyListeners();
  }

  void _updateSkinCareRoutine() {
    switch (_skinType) {
      case 'Oily':
        _skinCareRoutine = ['Cleanser', 'Toner', 'Moisturizer', 'Sunscreen'];
        break;
      case 'Dry':
        _skinCareRoutine = ['Gentle Cleanser', 'Hydrating Serum', 'Rich Moisturizer', 'Sunscreen'];
        break;
      case 'Combination':
        _skinCareRoutine = ['Mild Cleanser', 'Balancing Toner', 'Light Moisturizer', 'Sunscreen'];
        break;
      default:
        _skinCareRoutine = ['Cleanser', 'Moisturizer', 'Sunscreen'];
    }
  }

  void _updateHairCareRoutine() {
    switch (_hairType) {
      case 'Oily':
        _hairCareRoutine = ['Clarifying Shampoo', 'Light Conditioner', 'Dry Shampoo'];
        break;
      case 'Dry':
        _hairCareRoutine = ['Moisturizing Shampoo', 'Deep Conditioner', 'Hair Oil'];
        break;
      default:
        _hairCareRoutine = ['Regular Shampoo', 'Conditioner', 'Styling Product'];
    }
  }

  void addWardrobeItem(String item) {
    _wardrobeItems.add(item);
    notifyListeners();
  }
}