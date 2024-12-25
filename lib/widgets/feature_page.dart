import 'package:flutter/material.dart';

class FeaturePage extends StatefulWidget {
  final String featureId;
  final Map<String, dynamic> feature;

  const FeaturePage({
    Key? key,
    required this.featureId,
    required this.feature,
  }) : super(key: key);

  @override
  State<FeaturePage> createState() => _FeaturePageState();
}

class _FeaturePageState extends State<FeaturePage> {
  final TextEditingController _linkController = TextEditingController();
  List<String> links = [];

  void _addLink() {
    if (_linkController.text.isNotEmpty) {
      setState(() {
        links.add(_linkController.text);
        _linkController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.feature['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.feature['description']),
            const SizedBox(height: 20),
            
            // Links Section
            const Text('Links', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: links.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(links[index]),
                  );
                },
              ),
            ),

            // Add Link Section
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _linkController,
                    decoration: const InputDecoration(
                      hintText: 'Enter new link',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addLink,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _linkController.dispose();
    super.dispose();
  }
} 