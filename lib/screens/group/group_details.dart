import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:unity_funds/modals/group.dart';

class GroupDetails extends StatelessWidget {
  const GroupDetails({super.key, required this.group});

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(group.name)),
      body: Column(
        children: [
          Stack(
            children: [
              FadeInImage(
                image: FileImage(group.image),
                placeholder: MemoryImage(kTransparentImage),
                fit: BoxFit.cover,
                height: 250,
                width: double.infinity,
              ),
              Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: Container(
                    width: double.infinity,
                    height: 50,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                    ),
                    child: Column(
                      children: [
                        Text(
                          group.name,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.group_add_sharp),
                label: Text("Contribution"),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.exposure_zero),
                label: Text("Expense"),
              )
            ],
          )
        ],
      ),
    );
  }
}
