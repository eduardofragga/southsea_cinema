
import 'package:flutter/material.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController(text: 'Alex Morgan');
  final _emailController = TextEditingController(
    text: 'alex.morgan@example.com',
  );
  final _phoneController = TextEditingController(text: '07123456789');
  final _addressController = TextEditingController(
    text: '12 Cinema Lane, Portsmouth',
  );

  bool _emailNews = true;
  bool _profileSaved = false;

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _profileSaved = true;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          onChanged: () {
            if (_profileSaved) {
              setState(() {
                _profileSaved = false;
              });
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Customer Profile'),
              const SizedBox(height: 16),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      !value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),

              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                ),
              ),

              CheckboxListTile(
                title: const Text('Receive email news'),
                value: _emailNews,
                onChanged: (value) {
                  setState(() {
                    _emailNews = value ?? false;
                    _profileSaved = false;
                  });
                },
              ),

              const SizedBox(height: 16),

              PrimaryButton(
                label: 'Save Profile',
                onPressed: _saveProfile,
              ),

              if (_profileSaved)
                const Text('Profile saved'),
            ],
          ),
        ),
      ),
    );
  }
}
