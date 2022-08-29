import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_chat_app/controller/search_controller.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  SearchController schController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
   schController.getCurrentUserIdandName();
    return Scaffold(
      
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      title: const Text('Search',style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold,color: Colors.black),),
      ),
      body: GetBuilder<SearchController>(
      
        builder: (controller) {
          return Column(children: [
            Container(color: const Color.fromARGB(255, 255, 255, 255),
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            child: Row(children: [
              Expanded(
                child: TextFormField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: "Search groups....",
                    border: OutlineInputBorder(borderSide: BorderSide.none)
                   ),
              
                ),
              ),
              Container(
                
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(40)),
                child: GestureDetector(
                  onTap: (){
                  schController. initiateSearchMethod(searchController.text);
                  },
                  child: const Icon(Icons.search,size: 30,color:Colors.black)),
              )
            ]),
            ),
           schController. isloading ? Center(child: CircularProgressIndicator(),):schController. groupList()
          ]);
        }
      ),
    );
  }

 

 
}