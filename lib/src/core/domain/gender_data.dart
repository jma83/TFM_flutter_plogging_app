class Gender {
  static const NotDefined = "Gender - Not defined";
  static const Female = "Female";
  static const Male = "Male";

  static const NotDefinedIndex = 0;
  static const FemaleIndex = 1;
  static const MaleIndex = 2;

  static getGenderIndex(String gender) {
    switch (gender) {
      case Gender.NotDefined:
        return Gender.NotDefinedIndex;
      case Gender.Female:
        return Gender.FemaleIndex;
      case Gender.Male:
        return Gender.MaleIndex;
      default:
        return -1;
    }
  }

  static getGenderFromIndex(int index) {
    switch (index) {
      case Gender.NotDefinedIndex:
        return Gender.NotDefined;
      case Gender.FemaleIndex:
        return Gender.Female;
      case Gender.MaleIndex:
        return Gender.Male;
      default:
        return -1;
    }
  }
}
