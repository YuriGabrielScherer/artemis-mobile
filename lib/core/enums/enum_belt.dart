enum EnumBelt {
  white,
  yellow,
  red,
  orange,
  green,
  purple,
  brown,
  black,
  black_2,
  black_3,
  black_4,
  black_5,
  black_6,
  black_7,
  black_8,
  black_9,
  black_10;
}

extension EnumBeltExtension on EnumBelt {
  String get name {
    switch (this) {
      case EnumBelt.white:
        return 'Branca';
      case EnumBelt.yellow:
        return 'Amarela';
      case EnumBelt.red:
        return 'Vermelha';
      case EnumBelt.orange:
        return 'Laranja';
      case EnumBelt.green:
        return 'Verde';
      case EnumBelt.purple:
        return 'Roxa';
      case EnumBelt.brown:
        return 'Marrom';
      case EnumBelt.black:
        return 'Preta';
      case EnumBelt.black_2:
        return 'Segundo Dan';
      case EnumBelt.black_3:
        return 'Terceiro Dan';
      case EnumBelt.black_4:
        return 'Quarto Dan';
      case EnumBelt.black_5:
        return 'Quinto Dan';
      case EnumBelt.black_6:
        return 'Sexto Dan';
      case EnumBelt.black_7:
        return 'Sétimo Dan';
      case EnumBelt.black_8:
        return 'Oitavo Dan';
      case EnumBelt.black_9:
        return 'Nono Dan';
      case EnumBelt.black_10:
        return 'Décimo Dan';
      default:
        return 'Something went wrong';
    }
  }
}
