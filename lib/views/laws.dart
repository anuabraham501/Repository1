import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:women/colors.dart';
import 'package:women/services/laws.dart';
import 'package:women/views/external.dart';

class Laws extends StatefulWidget {
  const Laws({super.key});

  @override
  State<Laws> createState() => _LawsState();
}

class _LawsState extends State<Laws> {
  final launchIcon = const Icon(Icons.launch);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Laws and Information", style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 4),
        separatorBuilder: (context, index) => const Divider(
          height: 4, indent: 8, endIndent: 8, color: primaryColor
        ),
        itemCount: lawsLinks.length,
        itemBuilder: (context, index) {
          final item = lawsLinks[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
            titleAlignment: ListTileTitleAlignment.threeLine,
          
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                imageUrl: item[3],
                placeholder: (_, __) => launchIcon,
                errorWidget: (___, __, _) => launchIcon,
              ),
            ),
            title: Title(
              color: Colors.black,
              child: Text(
                item[0],
                softWrap: false,
                style: const TextStyle(fontSize: 12.0),
              ),
            ),
            subtitle: Text(
              item[1], 
              style: const TextStyle(fontSize: 10.0)
            ),
            onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => ExternalView(item: item))
            ),
          );
        }
      ),
    );
  }
}