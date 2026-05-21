import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_radius.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';
import 'package:lexa_pos/core/utils/validators.dart';
import 'package:lexa_pos/core/widgets/app_button.dart';
import 'package:lexa_pos/core/widgets/app_text_field.dart';
import 'package:lexa_pos/core/widgets/app_toast.dart';
import 'package:lexa_pos/features/catalog/domain/entities/product.dart';
import 'package:lexa_pos/core/database/database_provider.dart';

class ProductFormDialog extends ConsumerStatefulWidget {
  const ProductFormDialog({super.key, this.initialData});

  final Product? initialData;

  static Future<void> show(BuildContext context, {Product? product}) {
    return showDialog(
      context: context,
      builder: (context) => ProductFormDialog(initialData: product),
    );
  }

  @override
  ConsumerState<ProductFormDialog> createState() => _ProductFormDialogState();
}

class _ProductFormDialogState extends ConsumerState<ProductFormDialog> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _stockController;
  late TextEditingController _minStockController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialData?.name ?? '');
    _priceController = TextEditingController(text: widget.initialData?.priceRupiah.toString() ?? '');
    _stockController = TextEditingController(text: widget.initialData?.stockQuantity.toString() ?? '');
    _minStockController = TextEditingController(text: widget.initialData?.minStock.toString() ?? '10');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _minStockController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final repo = ref.read(productCatalogRepositoryProvider);
    
    final id = widget.initialData?.id ?? 'prod_${DateTime.now().millisecondsSinceEpoch}';
    final name = _nameController.text.trim();
    final price = int.tryParse(_priceController.text) ?? 0;
    final stock = int.tryParse(_stockController.text) ?? 0;
    final minStock = int.tryParse(_minStockController.text) ?? 10;
    
    final product = Product(
      id: id,
      name: name,
      priceRupiah: price,
      stockQuantity: stock,
      minStock: minStock,
      categoryId: widget.initialData?.categoryId ?? 'cat_general',
      isActive: true,
      updatedAtMillis: DateTime.now().millisecondsSinceEpoch,
    );

    try {
      await repo.upsertProduct(product);
      if (mounted) {
        Navigator.pop(context);
        showAppToast(
          context,
          message: widget.initialData == null ? 'Produk berhasil ditambahkan' : 'Produk diperbarui',
          icon: Icons.check_circle,
          backgroundColor: AppColors.success,
        );
      }
    } catch (e) {
      if (mounted) {
        showAppToast(
          context,
          message: 'Gagal menyimpan produk',
          icon: Icons.error,
          backgroundColor: AppColors.danger,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.initialData != null;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.dialog)),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(AppSpacing.s24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                isEditing ? 'Edit Produk' : 'Tambah Produk Baru',
                style: AppTextStyles.heading24,
              ),
              const SizedBox(height: AppSpacing.s24),
              
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Produk',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.isEmpty ? 'Nama wajib diisi' : null,
              ),
              const SizedBox(height: AppSpacing.s16),
              
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Harga (Rp)',
                  border: OutlineInputBorder(),
                  prefixText: 'Rp ',
                ),
                validator: (val) => val == null || val.isEmpty ? 'Harga wajib diisi' : null,
              ),
              const SizedBox(height: AppSpacing.s16),
              
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _stockController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Stok Awal',
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) => val == null || val.isEmpty ? 'Stok wajib diisi' : null,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.s16),
                  Expanded(
                    child: TextFormField(
                      controller: _minStockController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Min. Stok',
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) => val == null || val.isEmpty ? 'Min stok wajib diisi' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.s32),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton.secondary(
                    text: 'Batal',
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: AppSpacing.s12),
                  AppButton.primary(
                    text: 'Simpan',
                    onPressed: _submit,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
