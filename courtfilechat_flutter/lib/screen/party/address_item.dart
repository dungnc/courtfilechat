import 'package:common/model/address.dart';
import 'package:flutter/material.dart';

class AddressItem extends StatelessWidget {
  final Address address;
  final bool isActive;
  final ValueChanged<bool> onChangeActive;
  const AddressItem(
      {Key key, this.address, this.isActive: false, this.onChangeActive})
      // : assert(address != null),
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('line 1 information'),
        subtitle: Text('State and Contry'),
        trailing: Checkbox(
          onChanged: onChangeActive,
          value: isActive,
        ),
        // trailing: ,
        onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddressDetailScreen(
                      address: address,
                    ),
              ),
            ),
      ),
    );
  }
}

const kTextStyle = TextStyle(
  fontSize: 16.0,
  color: Colors.black,
);

const kTextStyleBold = TextStyle(
  fontSize: 16.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

class AddressDetailScreen extends StatelessWidget {
  final Address address;

  AddressDetailScreen({Key key, this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Line 1:',
              style: kTextStyleBold,
            ),
            Text(
              address?.line1 ?? 'Line 1 .....',
              style: kTextStyle,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Line 2:',
              style: kTextStyleBold,
            ),
            Text(
              address?.line2 ?? 'Line 2 .....',
              style: kTextStyle,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Line 3:',
              style: kTextStyleBold,
            ),
            Text(
              address?.line3 ?? 'Line 3 .....',
              style: kTextStyle,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'City:',
              style: kTextStyleBold,
            ),
            Text(
              address?.city ?? 'City .....',
              style: kTextStyle,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'State:',
              style: kTextStyleBold,
            ),
            Text(
              address?.state ?? 'state .....',
              style: kTextStyle,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Country:',
              style: kTextStyleBold,
            ),
            Text(
              address?.country ?? 'country .....',
              style: kTextStyle,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Primary Address:',
              style: kTextStyleBold,
            ),
            Text(
              address?.primaryAddress ?? 'primaryAddress .....',
              style: kTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
