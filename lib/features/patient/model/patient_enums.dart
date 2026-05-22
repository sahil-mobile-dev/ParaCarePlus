// No imports needed here currently

enum PatientTitle {
  mr('Mr.'),
  mrs('Mrs.'),
  ms('Ms.'),
  dr('Dr.');

  const PatientTitle(this.label);
  final String label;
}

enum Gender {
  male('Male'),
  female('Female'),
  other('Other');

  const Gender(this.label);
  final String label;
}

enum BloodGroup {
  unknown('Unknown'),
  aPositive('A+'),
  aNegative('A-'),
  bPositive('B+'),
  bNegative('B-'),
  oPositive('O+'),
  oNegative('O-'),
  abPositive('AB+'),
  abNegative('AB-');

  const BloodGroup(this.label);
  final String label;
}

enum MaritalStatus {
  single('Single'),
  married('Married'),
  widowed('Widowed'),
  divorced('Divorced');

  const MaritalStatus(this.label);
  final String label;
}

enum Religion {
  hindu('Hindu'),
  muslim('Muslim'),
  christian('Christian'),
  sikh('Sikh'),
  other('Other');

  const Religion(this.label);
  final String label;
}

enum Category {
  general('General'),
  obc('OBC'),
  sc('SC'),
  st('ST');

  const Category(this.label);
  final String label;
}
