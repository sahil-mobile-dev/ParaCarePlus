import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/blood_bank/view_model/blood_bank_view_model.dart';

class BbModals {
  static void showRecordDonation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => const _RecordDonationDialog(),
    );
  }

  static void showBloodRequest(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => const _BloodRequestDialog(),
    );
  }

  static void showRegisterDonor(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => const _RegisterDonorDialog(),
    );
  }
}

class _RecordDonationDialog extends ConsumerStatefulWidget {
  const _RecordDonationDialog();

  @override
  ConsumerState<_RecordDonationDialog> createState() => _RecordDonationDialogState();
}

class _RecordDonationDialogState extends ConsumerState<_RecordDonationDialog> {
  final _donorController = TextEditingController(text: 'Ramesh Bisht');
  String _bloodGroup = 'B+';
  final _volumeController = TextEditingController(text: '450');
  String _component = 'Whole Blood';
  String _campType = 'Walk-in';

  @override
  void dispose() {
    _donorController.dispose();
    _volumeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '🩸 Record Blood Donation',
                    style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.secondaryText),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(color: AppColors.border),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Donor ID / Name *'),
                        TextField(
                          controller: _donorController,
                          style: AppTextStyles.bodyMedium,
                          decoration: InputDecoration(
                            hintText: 'Search or enter name...',
                            filled: true,
                            fillColor: AppColors.card,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Blood Group'),
                        _buildDropdown(
                          value: _bloodGroup,
                          items: const ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'],
                          onChanged: (val) {
                            if (val != null) setState(() => _bloodGroup = val);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Volume (mL)'),
                        TextField(
                          controller: _volumeController,
                          style: AppTextStyles.bodyMedium,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.card,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Component'),
                        _buildDropdown(
                          value: _component,
                          items: const ['Whole Blood', 'PCV/RCC', 'Platelets', 'FFP'],
                          onChanged: (val) {
                            if (val != null) setState(() => _component = val);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              _buildLabel('Donation Type'),
              _buildDropdown(
                value: _campType,
                items: const ['Walk-in', 'Camp', 'Replacement'],
                onChanged: (val) {
                  if (val != null) setState(() => _campType = val);
                },
              ),
              const SizedBox(height: AppSpacing.md),
              _buildLabel('Mandatory Screening Checklist'),
              Wrap(
                spacing: 12,
                children: const [
                  Text('✔️ HIV I & II', style: TextStyle(fontSize: 11, color: AppColors.success)),
                  Text('✔️ Hepatitis B (HBsAg)', style: TextStyle(fontSize: 11, color: AppColors.success)),
                  Text('✔️ Hepatitis C (HCV)', style: TextStyle(fontSize: 11, color: AppColors.success)),
                  Text('✔️ Malaria Check', style: TextStyle(fontSize: 11, color: AppColors.success)),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('CANCEL', style: TextStyle(color: AppColors.secondaryText)),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF880E4F)),
                    onPressed: () {
                      final name = _donorController.text.trim();
                      final vol = int.tryParse(_volumeController.text.trim()) ?? 450;
                      if (name.isEmpty) return;

                      ref.read(bloodBankProvider.notifier).recordDonation(
                            donorName: name,
                            bloodGroup: _bloodGroup,
                            volume: vol,
                            component: _component,
                            campType: _campType,
                          );

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Donation recorded. Blood unit bag registered successfully.'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    },
                    child: const Text('SAVE DONATION', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          dropdownColor: AppColors.card,
          style: AppTextStyles.bodyMedium,
          isExpanded: true,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: AppColors.secondaryText,
          fontSize: 9.5,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _BloodRequestDialog extends ConsumerStatefulWidget {
  const _BloodRequestDialog();

  @override
  ConsumerState<_BloodRequestDialog> createState() => _BloodRequestDialogState();
}

class _BloodRequestDialogState extends ConsumerState<_BloodRequestDialog> {
  final _uhidController = TextEditingController(text: 'UK-00512');
  final _nameController = TextEditingController(text: 'Kishore Negi');
  String _bloodGroup = 'B+';
  String _component = 'PCV/RCC';
  final _unitsController = TextEditingController(text: '2');
  String _urgency = 'Urgent';
  String _ward = 'Surgery';
  final _doctorController = TextEditingController(text: 'Dr. Negi');

  @override
  void dispose() {
    _uhidController.dispose();
    _nameController.dispose();
    _unitsController.dispose();
    _doctorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '🩸 New Blood Request',
                    style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.secondaryText),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(color: AppColors.border),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Patient UHID *'),
                        TextField(
                          controller: _uhidController,
                          style: AppTextStyles.bodyMedium,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.card,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Patient Name *'),
                        TextField(
                          controller: _nameController,
                          style: AppTextStyles.bodyMedium,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.card,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Blood Group Required'),
                        _buildDropdown(
                          value: _bloodGroup,
                          items: const ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'],
                          onChanged: (val) {
                            if (val != null) setState(() => _bloodGroup = val);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Component Type'),
                        _buildDropdown(
                          value: _component,
                          items: const ['Whole Blood', 'PCV/RCC', 'Platelets', 'FFP', 'Cryoprecipitate'],
                          onChanged: (val) {
                            if (val != null) setState(() => _component = val);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Units Required'),
                        TextField(
                          controller: _unitsController,
                          style: AppTextStyles.bodyMedium,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.card,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Urgency Level'),
                        _buildDropdown(
                          value: _urgency,
                          items: const ['Routine', 'Urgent', 'Emergency'],
                          onChanged: (val) {
                            if (val != null) setState(() => _urgency = val);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Ward / Dept'),
                        _buildDropdown(
                          value: _ward,
                          items: const ['Surgery', 'Medicine', 'Ortho', 'Gynae', 'ICU', 'OT'],
                          onChanged: (val) {
                            if (val != null) setState(() => _ward = val);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Requesting Clinician'),
                        TextField(
                          controller: _doctorController,
                          style: AppTextStyles.bodyMedium,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.card,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('CANCEL', style: TextStyle(color: AppColors.secondaryText)),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC62828)),
                    onPressed: () {
                      final name = _nameController.text.trim();
                      final units = int.tryParse(_unitsController.text.trim()) ?? 1;
                      if (name.isEmpty) return;

                      ref.read(bloodBankProvider.notifier).submitRequest(
                            patientName: name,
                            group: _bloodGroup,
                            component: _component,
                            units: units,
                            urgency: _urgency,
                            ward: _ward,
                            doctor: _doctorController.text,
                          );

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Blood request submitted to bank dispatcher successfully.'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    },
                    child: const Text('SUBMIT REQUEST', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          dropdownColor: AppColors.card,
          style: AppTextStyles.bodyMedium,
          isExpanded: true,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: AppColors.secondaryText,
          fontSize: 9.5,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _RegisterDonorDialog extends ConsumerStatefulWidget {
  const _RegisterDonorDialog();

  @override
  ConsumerState<_RegisterDonorDialog> createState() => _RegisterDonorDialogState();
}

class _RegisterDonorDialogState extends ConsumerState<_RegisterDonorDialog> {
  final _nameController = TextEditingController();
  final _ageSexController = TextEditingController(text: '28/M');
  String _bloodGroup = 'A+';
  final _mobileController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageSexController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '👥 Register New Blood Donor',
                    style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.secondaryText),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(color: AppColors.border),
              const SizedBox(height: AppSpacing.md),
              _buildLabel('Full Name *'),
              TextField(
                controller: _nameController,
                style: AppTextStyles.bodyMedium,
                decoration: InputDecoration(
                  hintText: 'Enter donor\'s full name...',
                  filled: true,
                  fillColor: AppColors.card,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Age / Sex *'),
                        TextField(
                          controller: _ageSexController,
                          style: AppTextStyles.bodyMedium,
                          decoration: InputDecoration(
                            hintText: 'e.g. 28/M',
                            filled: true,
                            fillColor: AppColors.card,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Blood Group'),
                        _buildDropdown(
                          value: _bloodGroup,
                          items: const ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'],
                          onChanged: (val) {
                            if (val != null) setState(() => _bloodGroup = val);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              _buildLabel('Mobile Number *'),
              TextField(
                controller: _mobileController,
                style: AppTextStyles.bodyMedium,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Enter 10 digit number...',
                  filled: true,
                  fillColor: AppColors.card,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('CANCEL', style: TextStyle(color: AppColors.secondaryText)),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E7D32)),
                    onPressed: () {
                      final name = _nameController.text.trim();
                      final mobile = _mobileController.text.trim();
                      final ageSex = _ageSexController.text.trim();
                      if (name.isEmpty || mobile.isEmpty) return;

                      ref.read(bloodBankProvider.notifier).registerDonor(
                            name: name,
                            ageSex: ageSex,
                            bloodGroup: _bloodGroup,
                            mobile: mobile,
                          );

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Donor registered successfully in registry database.'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    },
                    child: const Text('REGISTER DONOR', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          dropdownColor: AppColors.card,
          style: AppTextStyles.bodyMedium,
          isExpanded: true,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: AppColors.secondaryText,
          fontSize: 9.5,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
