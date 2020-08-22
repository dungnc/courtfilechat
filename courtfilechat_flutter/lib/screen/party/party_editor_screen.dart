import 'package:common/model/party.dart';
import 'package:courtfilechat_flutter/screen/party/address_item.dart';
import 'package:flutter/material.dart';

class PartyEditorScreen extends StatefulWidget {
  final Party party;

  const PartyEditorScreen({Key key, this.party}) : super(key: key);
  @override
  _PartyEditorScreenState createState() => _PartyEditorScreenState();
}

class _PartyEditorScreenState extends State<PartyEditorScreen> {
  int _tabIndex = 1;
  bool _asCompany = false;
  @override
  Widget build(BuildContext context) {
    print('party = ${widget.party.companyName}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Party Editor'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Text(
                    'General Info',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(text: 'Country: '),
                  TextSpan(text: '${widget.party.partyCode}'),
                ])),
                Text.rich(TextSpan(children: [
                  TextSpan(text: 'Lead Attorney: '),
                  TextSpan(text: '${widget.party.firstName}'),
                ])),
                Text.rich(TextSpan(children: [
                  TextSpan(text: 'Case Category: '),
                  TextSpan(text: '${widget.party.caseId}'),
                ])),
                 Text.rich(TextSpan(children: [
                  TextSpan(text: 'Case Type: '),
                  TextSpan(text: '${widget.party.partyType}'),
                ])),
                SizedBox(
                  height: 20.0,
                ),
                TabBar(
                  labelColor: Colors.blue,
                  tabs: [
                    Tab(text: 'User List'),
                    Tab(text: 'Company List'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      Container(
                        child: ListView(
                          children: _dummyCompany(),
                        ),
                      ),
                      Container(
                        child: ListView(
                          children: _dummyUsers(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _dummyCompany() {
    return <Widget>[
      RaisedButton(
        color: Colors.blue,
        onPressed: () {},
        child: Text(
          'Add User',
          style: TextStyle(color: Colors.white),
        ),
      ),
      ListTile(
        title: Text('Company Name'),
        subtitle: Text('Address ˝'),
      ),
      ListTile(
        title: Text('Company Name'),
        subtitle: Text('Address ˝'),
      ),
      ListTile(
        title: Text('Company Name'),
        subtitle: Text('Address ˝'),
      ),
    ];
  }

  _dummyUsers() {
    return <Widget>[
      RaisedButton(
        color: Colors.blue,
        onPressed: () {},
        child: Text(
          'Add Company',
          style: TextStyle(color: Colors.white),
        ),
      ),
      ListTile(
        title: Text('John Dan'),
        subtitle: Text('United  '),
      ),
      ListTile(
        title: Text('Company Name'),
        subtitle: Text('UK '),
      ),
      ListTile(
        title: Text('Company Name'),
        subtitle: Text('Hamilton '),
      ),
    ];
  }
}
