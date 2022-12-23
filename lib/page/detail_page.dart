import 'package:flutter/material.dart';
import 'package:uas_biodata_flutter/model/user.dart';

class DetailPage extends StatefulWidget {
  final User user;
  const DetailPage({Key? key, required this.user}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Biodata"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("NIM"),
              SizedBox(
                height: 10,
              ),
              Text(widget.user.nim!.toString()),
              SizedBox(
                height: 20,
              ),
              Text("Nama"),
              SizedBox(
                height: 10,
              ),
              Text(widget.user.name!),
              SizedBox(
                height: 20,
              ),
              Text("Alamat"),
              SizedBox(
                height: 10,
              ),
              Text(widget.user.alamat!),
              SizedBox(
                height: 20,
              ),
              Text("Jenis Kelamin"),
              SizedBox(
                height: 10,
              ),
              widget.user.type! == 1 ? Text('Laki-laki') : Text('Perempuan'),
              SizedBox(
                height: 20,
              ),
              Text("Tanggal Lahir"),
              SizedBox(
                height: 10,
              ),
              Text(widget.user.updatedAt.toString()),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
