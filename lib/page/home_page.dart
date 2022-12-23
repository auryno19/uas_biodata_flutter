import 'package:flutter/material.dart';
import 'package:uas_biodata_flutter/database/DbHelper.dart';
import 'package:uas_biodata_flutter/model/user.dart';
import 'package:uas_biodata_flutter/page/create_page.dart';
import 'package:uas_biodata_flutter/page/detail_page.dart';
import 'package:uas_biodata_flutter/page/update_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbHelper? dbhelper;

  Future _refresh() async {
    setState(() {});
  }

  @override
  void initState() {
    dbhelper = DbHelper();
    initDatabase();
    super.initState();
  }

  Future initDatabase() async {
    await dbhelper!.database();
    setState(() {});
  }

  showAlertDialog(BuildContext contex, int idUser) {
    Widget okButton = TextButton(
      child: Text("Yakin"),
      onPressed: () {
        //delete disini
        dbhelper!.hapus(idUser);
        Navigator.of(contex, rootNavigator: true).pop();
        setState(() {});
      },
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text("Peringatan !"),
      content: Text("Anda yakin akan menghapus ?"),
      actions: [okButton],
    );

    showDialog(
        context: contex,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Biodata"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreatePage()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              FutureBuilder<List<User>>(
                  future: dbhelper!.getAll(),
                  builder: (context, snapshot) {
                    print('HASIL : ' + snapshot.data.toString());
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    } else {
                      if (snapshot.hasData) {
                        return Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => DetailPage(
                                                  user: snapshot.data![index],
                                                )))
                                        .then((value) {
                                      setState(() {});
                                    });
                                  },
                                  title: Text(snapshot.data![index].name!),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data![index].nim!.toString(),
                                      ),
                                      snapshot.data![index].type == 1
                                          ? Text(
                                              'Laki-laki',
                                              style: TextStyle(
                                                color: Colors.blueAccent,
                                              ),
                                            )
                                          : Text(
                                              'Perempuan',
                                              style: TextStyle(
                                                color: Colors.pinkAccent,
                                              ),
                                            )
                                    ],
                                  ),
                                  trailing: Wrap(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdatePage(
                                                          user: snapshot
                                                              .data![index],
                                                        )))
                                                .then((value) {
                                              setState(() {});
                                            });
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.grey,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            showAlertDialog(context,
                                                snapshot.data![index].id!);
                                          },
                                          icon: Icon(Icons.delete,
                                              color: Colors.red))
                                    ],
                                  ),
                                );
                              }),
                        );
                      } else {
                        return Text("Tidak ada data");
                      }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
