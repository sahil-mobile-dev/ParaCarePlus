// No imports needed here currently

enum PatientTitle {
  mr('Mr.'),
  mrs('Mrs.'),
  ms('Ms.'),
  dr('Dr.');

  final String label;
  const PatientTitle(this.label);
}

enum Gender {
  male('Male'),
  female('Female'),
  other('Other');

  final String label;
  const Gender(this.label);
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

  final String label;
  const BloodGroup(this.label);
}

enum MaritalStatus {
  single('Single'),
  married('Married'),
  widowed('Widowed'),
  divorced('Divorced');

  final String label;
  const MaritalStatus(this.label);
}

enum Religion {
  hindu('Hindu'),
  muslim('Muslim'),
  christian('Christian'),
  sikh('Sikh'),
  other('Other');

  final String label;
  const Religion(this.label);
}

enum Category {
  general('General'),
  obc('OBC'),
  sc('SC'),
  st('ST');

  final String label;
  const Category(this.label);
}
