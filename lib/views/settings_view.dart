import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

class SettingsView extends StatefulWidget {
  final SharedPreferencesAsync? preferences;

  const SettingsView({
    super.key,
    this.preferences,
  });

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

  late final SharedPreferencesAsync _preferences;

  @override
  void initState() {
    super.initState();
    _preferences = widget.preferences ?? SharedPreferencesAsync();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final name = await _preferences.getString('profile_name');
    final email = await _preferences.getString('profile_email');
    final phone = await _preferences.getString('profile_phone');
    final address = await _preferences.getString('profile_address');
    final emailNews = await _preferences.getBool('profile_email_news');

    if (!mounted) return;

    setState(() {
      if (name != null) _nameController.text = name;
      if (email != null) _emailController.text = email;
      if (phone != null) _phoneController.text = phone;
      if (address != null) _addressController.text = address;
      if (emailNews != null) _emailNews = emailNews;
    });
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    await _preferences.setString(
      'profile_name',
      _nameController.text,
    );
    await _preferences.setString(
      'profile_email',
      _emailController.text,
    );
    await _preferences.setString(
      'profile_phone',
      _phoneController.text,
    );
    await _preferences.setString(
      'profile_address',
      _addressController.text,
    );
    await _preferences.setBool('profile_email_news', _emailNews);

    if (!mounted) return;

    setState(() {
      _profileSaved = true;
    });
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
              if (_profileSaved) const Text('Profile saved'),
            ],
          ),
        ),
      ),
    );
  }
}
