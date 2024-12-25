class NavigationModel {
  final String path;
  final String label;
  final List<MenuItem>? menuItems;

  NavigationModel({
    required this.path,
    required this.label,
    this.menuItems,
  });

  factory NavigationModel.fromJson(Map<String, dynamic> json) {
    return NavigationModel(
      path: json['path'] ?? '',
      label: json['label'] ?? '',
      menuItems: json['items'] != null 
        ? List<MenuItem>.from(json['items'].map((x) => MenuItem.fromJson(x)))
        : null,
    );
  }
}

class MenuItem {
  final String id;
  final String label;
  final String? path;
  final List<ThemeOption>? themeOptions;

  MenuItem({
    required this.id,
    required this.label,
    this.path,
    this.themeOptions,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      label: json['label'],
      path: json['path'],
      themeOptions: json['options'] != null
        ? List<ThemeOption>.from(json['options'].map((x) => ThemeOption.fromJson(x)))
        : null,
    );
  }
}

class ThemeOption {
  final String id;
  final String label;

  ThemeOption({
    required this.id,
    required this.label,
  });

  factory ThemeOption.fromJson(Map<String, dynamic> json) {
    return ThemeOption(
      id: json['id'],
      label: json['label'],
    );
  }
} 