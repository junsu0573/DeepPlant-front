import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';

class AdressSearchTest extends StatefulWidget {
  AdressSearchTest({
    Key? key,
  }) : super(key: key);

  @override
  _AdressSearchTestState createState() => _AdressSearchTestState();
}

class _AdressSearchTestState extends State<AdressSearchTest> {
  String postCode = '-';
  String roadAddress = '-';
  String jibunAddress = '-';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => KpostalView(
                      useLocalServer: false,
                      callback: (Kpostal result) {
                        setState(() {
                          postCode = result.postCode;
                          roadAddress = result.address;
                          jibunAddress = result.jibunAddress;
                        });
                      },
                    ),
                  ),
                );
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue)),
              child: Text(
                'Search Address',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              padding: EdgeInsets.all(40.0),
              child: Column(
                children: [
                  Text('postCode',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('result: $postCode'),
                  Text('road_address',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('result: $roadAddress'),
                  Text('jibun_address',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('result: $jibunAddress'),
                  Text('LatLng', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
