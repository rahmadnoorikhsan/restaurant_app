import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';

class ReviewSheet extends StatefulWidget {
  const ReviewSheet({super.key});

  @override
  State<ReviewSheet> createState() => _ReviewSheetState();
}

class _ReviewSheetState extends State<ReviewSheet> {
  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Tulis Ulasan Anda',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                  labelText: 'Nama Anda', border: OutlineInputBorder()),
              validator: (value) =>
                  value!.isEmpty ? 'Nama tidak boleh kosong' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _reviewController,
              decoration: const InputDecoration(
                  labelText: 'Ulasan Anda', border: OutlineInputBorder()),
              maxLines: 3,
              validator: (value) =>
                  value!.isEmpty ? 'Ulasan tidak boleh kosong' : null,
            ),
            const SizedBox(height: 16),
            Consumer<RestaurantDetailProvider>(
              builder: (context, provider, child) {
                if (provider.isSubmitting) {
                  return const CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await provider.addReview(
                        _nameController.text,
                        _reviewController.text,
                      );

                      if (context.mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(provider.reviewMessage)),
                        );
                      }
                    }
                  },
                  child: const Text('Kirim Ulasan'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}