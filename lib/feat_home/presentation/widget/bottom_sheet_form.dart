import 'package:flutter/material.dart';

class BottomSheetForm extends StatefulWidget {
  final Function(String, String, String, String) onSubmit;
  final VoidCallback? onDelete; // Optional callback for delete
  final String? initialName; // For auto-filling during updates
  final String? initialAddress;
  final String? initialLatitude;
  final String? initialLongitude;

  const BottomSheetForm({
    super.key,
    required this.onSubmit,
    this.onDelete,
    this.initialName,
    this.initialAddress,
    this.initialLatitude,
    this.initialLongitude,
  });

  @override
  State<BottomSheetForm> createState() => _BottomSheetFormState();
}

class _BottomSheetFormState extends State<BottomSheetForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _namaController;
  late TextEditingController _alamatController;
  late TextEditingController _latitudeController;
  late TextEditingController _longitudeController;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with initial values (if provided)
    _namaController = TextEditingController(text: widget.initialName ?? '');
    _alamatController = TextEditingController(text: widget.initialAddress ?? '');
    _latitudeController =
        TextEditingController(text: widget.initialLatitude ?? '');
    _longitudeController =
        TextEditingController(text: widget.initialLongitude ?? '');
  }

  @override
  void dispose() {
    _namaController.dispose();
    _alamatController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Tambah/Update Lokasi',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Column(
              children: [
                // Nama Field
                TextFormField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    hintText: 'Masukkan nama',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Alamat Field
                TextFormField(
                  controller: _alamatController,
                  decoration: InputDecoration(
                    labelText: 'Alamat',
                    hintText: 'Masukkan alamat',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Alamat tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Latitude Field
                TextFormField(
                  controller: _latitudeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Latitude',
                    hintText: 'Masukkan latitude',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Latitude tidak boleh kosong';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Latitude harus berupa angka';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Longitude Field
                TextFormField(
                  controller: _longitudeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Longitude',
                    hintText: 'Masukkan longitude',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Longitude tidak boleh kosong';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Longitude harus berupa angka';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Submit Button
                SizedBox(
                  width: double.infinity, // Makes the button take full width
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onSubmit(
                          _namaController.text.trim(),
                          _alamatController.text.trim(),
                          _latitudeController.text.trim(),
                          _longitudeController.text.trim(),
                        );
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      backgroundColor: Colors.blue[700],
                    ),
                    child: const Text(
                      'Simpan',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                // Delete Button (Optional)
                if (widget.onDelete != null) ...[
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        // Show a confirmation dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Konfirmasi"),
                              content: const Text("Apakah Anda yakin ingin menghapus?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: const Text("Batal"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    widget.onDelete!(); // Call the delete function
                                    Navigator.of(context).pop(); // Close the dialog
                                    Navigator.of(context).pop(); // Close the current screen
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.red, // Red confirmation button
                                  ),
                                  child: const Text("Hapus"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        side: BorderSide(color: Colors.red[700]!), // Outline color
                      ),
                      child: const Text(
                        'Hapus',
                        style: TextStyle(color: Colors.red), // Text color matching outline
                      ),
                    ),
                  ),

                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}