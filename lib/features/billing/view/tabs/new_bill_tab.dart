import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class NewBillTab extends StatelessWidget {
  const NewBillTab({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;
        
        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildPatientInformationCard(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildServicesItemsCard(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildDiscountSchemeCard(),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    _buildBillSummaryCard(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildPaymentMethodCard(),
                  ],
                ),
              ),
            ],
          );
        }

        return Column(
          children: [
            _buildPatientInformationCard(),
            const SizedBox(height: AppSpacing.lg),
            _buildServicesItemsCard(),
            const SizedBox(height: AppSpacing.lg),
            _buildDiscountSchemeCard(),
            const SizedBox(height: AppSpacing.lg),
            _buildBillSummaryCard(),
            const SizedBox(height: AppSpacing.lg),
            _buildPaymentMethodCard(),
          ],
        );
      },
    );
  }

  Widget _buildPatientInformationCard() {
    return _buildCard(
      title: 'Patient Information',
      icon: Icons.person_outline_rounded,
      action: OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.search_rounded, size: 16),
        label: const Text('Search Patient'),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          minimumSize: const Size(0, 36),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildTextField('UHID / MRD No', hint: 'Enter UHID...')),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: _buildTextField('Patient Name', hint: 'Ramesh Kumar')),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: _buildTextField('Age / Sex', hint: '42 / M')),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(child: _buildDropdown('Visit Type', value: 'OPD')),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: _buildDropdown('Department', value: 'General Medicine')),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: _buildDropdown('Consulting Doctor', value: 'Dr. Priya Sharma')),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(child: _buildTextField('Mobile', hint: '98765-43210')),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: _buildDropdown('Payment Type', value: 'Cash')),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: _buildTextField('Date', hint: '12/04/2025', suffixIcon: Icons.calendar_today_rounded)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServicesItemsCard() {
    return _buildCard(
      title: 'Services & Items',
      icon: Icons.list_alt_rounded,
      action: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.add_rounded, size: 16),
        label: const Text('Add Service'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.success,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          minimumSize: const Size(0, 36),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Expanded(flex: 3, child: Text('Service / Item', style: AppTextStyles.labelSmall.copyWith(color: AppColors.success, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('Category', style: AppTextStyles.labelSmall.copyWith(color: AppColors.success, fontWeight: FontWeight.bold))),
                Expanded(flex: 1, child: Text('Qty', style: AppTextStyles.labelSmall.copyWith(color: AppColors.success, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('Rate (₹)', style: AppTextStyles.labelSmall.copyWith(color: AppColors.success, fontWeight: FontWeight.bold))),
                const SizedBox(width: 48, child: Text('Action', style: TextStyle(color: AppColors.success, fontSize: 12, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Service Item 1
          Row(
            children: [
              Expanded(flex: 3, child: _buildDropdown(null, value: 'OPD Consultation')),
              const SizedBox(width: 8),
              Expanded(flex: 2, child: _buildDropdown(null, value: 'Consultation')),
              const SizedBox(width: 8),
              Expanded(flex: 1, child: _buildTextField(null, hint: '1')),
              const SizedBox(width: 8),
              Expanded(flex: 2, child: _buildTextField(null, hint: '300')),
              const SizedBox(width: 8),
              SizedBox(
                width: 40,
                child: IconButton(
                  icon: const Icon(Icons.delete_outline, color: AppColors.error, size: 20),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Service Item 2
          Row(
            children: [
              Expanded(flex: 3, child: _buildDropdown(null, value: 'CBC')),
              const SizedBox(width: 8),
              Expanded(flex: 2, child: _buildDropdown(null, value: 'Pathology')),
              const SizedBox(width: 8),
              Expanded(flex: 1, child: _buildTextField(null, hint: '1')),
              const SizedBox(width: 8),
              Expanded(flex: 2, child: _buildTextField(null, hint: '250')),
              const SizedBox(width: 8),
              SizedBox(
                width: 40,
                child: IconButton(
                  icon: const Icon(Icons.delete_outline, color: AppColors.error, size: 20),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.search_rounded, size: 16),
            label: const Text('Browse Service Catalogue'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscountSchemeCard() {
    return _buildCard(
      title: 'Discount & Scheme',
      icon: Icons.local_offer_outlined,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildDropdown('Discount Type', value: 'None')),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: _buildTextField('Value', hint: '0')),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: _buildTextField('Approved By', hint: 'Doctor / Admin name')),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(child: _buildDropdown('Govt. Scheme', value: 'None')),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: _buildTextField('Scheme ID / Card No', hint: 'Scheme card / policy number')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBillSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.receipt_long_rounded, size: 20, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                'Bill Summary',
                style: AppTextStyles.titleMedium.copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildSummaryRow('Consultation', '₹300'),
          _buildSummaryRow('Investigation', '₹250'),
          _buildSummaryRow('Procedures', '₹0'),
          _buildSummaryRow('Medicine / Pharmacy', '₹0'),
          _buildSummaryRow('Room / Bed Charges', '₹0'),
          const Divider(color: AppColors.border, height: 24),
          _buildSummaryRow('Subtotal', '₹550', isBold: true),
          _buildSummaryRow('Discount', '- ₹0.00'),
          _buildSummaryRow('CGST (5%)', '₹27.50'),
          _buildSummaryRow('SGST (5%)', '₹27.50'),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('GRAND TOTAL', style: AppTextStyles.titleSmall.copyWith(color: AppColors.success)),
                Text('₹605', style: AppTextStyles.titleMedium.copyWith(color: AppColors.success)),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Amount Received (₹)', style: AppTextStyles.labelSmall.copyWith(color: AppColors.secondaryText)),
          const SizedBox(height: 8),
          TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: '0',
              hintStyle: const TextStyle(color: AppColors.secondaryText),
              filled: true,
              fillColor: AppColors.background,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Balance Due', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primaryText)),
              Text('₹605', style: AppTextStyles.titleSmall.copyWith(color: AppColors.error)),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.check_rounded, size: 18),
            label: const Text('Generate Bill & Print'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 44),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.save_rounded, size: 18),
            label: const Text('Save Draft'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.card,
              foregroundColor: AppColors.primaryText,
              side: const BorderSide(color: AppColors.border),
              minimumSize: const Size(double.infinity, 44),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.delete_outline, size: 18),
            label: const Text('Clear'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.card,
              foregroundColor: AppColors.error,
              side: const BorderSide(color: AppColors.border),
              minimumSize: const Size(double.infinity, 44),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard() {
    return _buildCard(
      title: 'Payment Method',
      icon: Icons.credit_card_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPaymentToggle('Cash', Icons.money_rounded, isSelected: true),
              _buildPaymentToggle('UPI', Icons.qr_code_rounded),
              _buildPaymentToggle('Card', Icons.credit_card_rounded),
              _buildPaymentToggle('NEFT', Icons.account_balance_rounded),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildTextField('Transaction / Reference No', hint: 'UTR / Txn Reference (if any)'),
        ],
      ),
    );
  }

  Widget _buildPaymentToggle(String label, IconData icon, {bool isSelected = false}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.success.withValues(alpha: 0.1) : AppColors.background,
          border: Border.all(color: isSelected ? AppColors.success : AppColors.border),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            Icon(icon, size: 24, color: isSelected ? AppColors.success : AppColors.secondaryText),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? AppColors.success : AppColors.secondaryText,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isBold ? AppColors.primaryText : AppColors.secondaryText,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 13,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required String title, required IconData icon, required Widget child, Widget? action}) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, size: 20, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Text(title, style: AppTextStyles.titleSmall),
                ],
              ),
              if (action != null) action,
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          child,
        ],
      ),
    );
  }

  Widget _buildTextField(String? label, {required String hint, IconData? suffixIcon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label, style: AppTextStyles.labelSmall.copyWith(color: AppColors.secondaryText)),
          const SizedBox(height: 4),
        ],
        TextField(
          style: const TextStyle(color: Colors.white, fontSize: 13),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.secondaryText, fontSize: 13),
            filled: true,
            fillColor: AppColors.background,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            suffixIcon: suffixIcon != null ? Icon(suffixIcon, size: 16, color: AppColors.secondaryText) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(String? label, {required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label, style: AppTextStyles.labelSmall.copyWith(color: AppColors.secondaryText)),
          const SizedBox(height: 4),
        ],
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.secondaryText, size: 18),
              dropdownColor: AppColors.card,
              style: const TextStyle(color: Colors.white, fontSize: 13),
              items: [
                DropdownMenuItem(value: value, child: Text(value)),
              ],
              onChanged: (_) {},
            ),
          ),
        ),
      ],
    );
  }
}
