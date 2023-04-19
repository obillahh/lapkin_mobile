import 'package:dicebear_training/model/api/api_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _avatarUrl = '';
  String _name = '';
  final DicebearApiService _api = DicebearApiService();

  @override
  void initState() {
    super.initState();
    _fetchAvatar();
  }

  void _fetchAvatar() async {
    try {
      String avatarUrl = await _api.getAvatarUrl(_name);

      setState(() {
        _avatarUrl = avatarUrl;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              _name = value;
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _fetchAvatar,
            child: const Text('Generate'),
          ),
          const SizedBox(height: 16),
          if (_avatarUrl.isNotEmpty)
            SizedBox(
              height: 100,
              width: 100,
              child: Image.network(_avatarUrl),
            ),
        ],
      ),
    );
  }
}
