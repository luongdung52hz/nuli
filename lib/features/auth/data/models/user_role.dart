enum UserRole{
  admin,
  user;

  String toJson() =>name;

  static UserRole fromJson(String json) {
    return UserRole.values.firstWhere(
          (role) => role.name == json,
      orElse: () => UserRole.user,
    );
  }

  String get displayName {
    switch (this) {
      case UserRole.admin:
        return 'Quản trị viên';
      case UserRole.user:
        return 'Người dùng';
    }
  }

}