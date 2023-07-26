import 'package:flutter/material.dart';
import 'package:team_management/customised/widgets/bottomnavigation.dart';
import 'package:team_management/src/auth/register/register.dart';
import 'package:team_management/src/dashboard/components/drawer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none_outlined),
            color: Colors.black,
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(child: CustomDrawer()),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: getHeight(context) * 0.02,
                ),
                Row(
                  children: [
                    Text(
                      'Hello,',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Ahmed ',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.waving_hand_rounded,
                      color: Colors.orange.shade600,
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.calendar_today_outlined))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    height: getHeight(context) * 0.22,
                    width: getwidth(context),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: ClampingScrollPhysics(),
                      itemCount: 10,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    // color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(15)),
                                height: getHeight(context) * 0.22,
                                width: getwidth(context) * 0.6,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '50% off',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 25),
                                    ),
                                    Text(
                                      'On everything today',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'with code:fscreation',
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 12),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        primary: Colors.black,
                                        onPrimary: Colors.white,
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        'Get now',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        "Your Team Members are :",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: 100,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: SizedBox(
                        height: getHeight(context) * 0.17,
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 15,
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Image.network(
                                    'https://images.unsplash.com/photo-1600185365926-3a2ce3cdb9eb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=725&q=80',
                                    width: getwidth(context) * 0.2,
                                    height: getHeight(context) * 0.1,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Gia Borghini',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('RHW Roise 1 Sandals'),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            Text('(4.5)'),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
