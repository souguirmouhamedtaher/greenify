enum UserTypeEnum { employee, farmer, admin }

extension UserTypeEnumExtension on UserTypeEnum {
  String get value {
    switch (this) {
      case UserTypeEnum.employee:
        return 'employee';
      case UserTypeEnum.farmer:
        return 'farmer';
      case UserTypeEnum.admin:
        return 'admin';
      default:
        throw ArgumentError('Unknown UserTypeEnum value');
    }
  }

  static UserTypeEnum fromValue(String value) {
    switch (value) {
      case 'employee':
        return UserTypeEnum.employee;
      case 'farmer':
        return UserTypeEnum.farmer;
      case 'admin':
        return UserTypeEnum.admin;
      default:
        throw ArgumentError('Unknown UserTypeEnum value: $value');
    }
  }
}
