import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/controller/firebase.dart';
import 'package:firebase/controller/homeController.dart';
import 'package:firebase/modal/modalData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({Key? key}) : super(key: key);

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  HomeController homeController = Get.put(
    HomeController(),
  );
  TextEditingController txtName = TextEditingController();
  TextEditingController txtStd = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtId = TextEditingController();

  TextEditingController Name = TextEditingController();
  TextEditingController Std = TextEditingController();
  TextEditingController Mobile = TextEditingController();
  TextEditingController Id = TextEditingController();

  List<ModelData> dataList = [];
  List<ModelData> alldataList = [];

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  void getProfile() async {
    homeController.userlist.value = await userProfile();
    print("${homeController.userlist.value}");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("DashBord"),
          actions: [
            IconButton(
              onPressed: () {
                logout();
                Get.offNamed('/splash');
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              TextField(
                controller: txtId,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: txtName,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: txtMobile,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: txtStd,
              ),
              ElevatedButton(
                onPressed: () {
                  insertData(
                      txtId.text, txtName.text, txtMobile.text, txtStd.text);
                },
                child: Text("Insert"),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: readData(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      List<QueryDocumentSnapshot> listDocs = snapshot.data!.docs;
                      alldataList.clear();

                      for (var d1 in listDocs) {
                        Map m1 = d1.data() as Map<String, dynamic>;
                        String key = d1.id;
                        String id = m1['id'];
                        String name = m1['name'];
                        String mobile = m1['mobile'];
                        String std = m1['std'];

                        ModelData modelData = ModelData(
                            std: std,
                            name: name,
                            mobile: mobile,
                            id: id,
                            key: key);
                        alldataList.add(modelData);
                      }
                      return ListView.builder(
                          itemCount: alldataList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Text("${alldataList[index].id}"),
                              title: Text("${alldataList[index].name}"),
                              subtitle: Text("${alldataList[index].key}"),
                              trailing: SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        deleteData("${alldataList[index].key}");
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {

                                        Id =TextEditingController(text: alldataList[index].id);
                                        Name =TextEditingController(text: alldataList[index].name);
                                        Mobile =TextEditingController(text: alldataList[index].mobile);
                                        Std =TextEditingController(text: alldataList[index].std);

                                        Get.defaultDialog(
                                          content: Column(
                                            children: [
                                              TextField(controller: Id,),
                                              TextField(controller: Name,),
                                              TextField(controller: Mobile,),
                                              TextField(controller: Std,),

                                              ElevatedButton(onPressed: (){
                                                updateData("${alldataList[index].key}",
                                                    "${Id.text}", "${Name.text}", "${Mobile.text}", "${Std.text}");

                                              }, child: Text("Update"),),
                                            ],
                                          ),

                                        );

                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
