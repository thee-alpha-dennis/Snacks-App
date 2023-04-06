import 'package:flutter/material.dart';

class Me extends StatefulWidget {
  @override
  _MeState createState() => _MeState();
}

class _MeState extends State<Me> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            ClipOval(
                      child: Image.asset(
                        'assets/me.jpg',
                        width: width / 2,
                        height: height / 4,
                        fit: BoxFit.cover,
                      ),
                    ),

            const SizedBox(height: 10),
             const Text(
                    'Dennis Opwotsi Ongong\'a',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
            const SizedBox(height: 5),
            const Text(
                    'dennisongonga28@gmail.com',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Edit My Info',style: TextStyle(color: Colors.blue),),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {

              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
