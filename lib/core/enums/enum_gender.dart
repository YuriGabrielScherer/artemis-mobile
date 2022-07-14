enum EnumGender {
  male,
  female;
}

extension EnumGenderExtension on EnumGender {
  String get name {
    switch (this) {
      case EnumGender.male:
        return 'Masculino';
      case EnumGender.female:
      default:
        return 'Feminino';
    }
  }
}
