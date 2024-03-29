import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Drawer(
      child:
          Container(
          // color: AppTheme.backgroundcolor,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                Container(
                  height: screenSize.height * 0.28,
                  width: screenSize.width,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF7ED957),
                        Color(0xFF68C541),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenSize.height * 0.05,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Get.to(navigationPage.elementAt(_currentPage))
                            // Get.to(MyProfile());
                          },
                          child: Card(
                              elevation: 3,
                              shape: const CircleBorder(),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Container(
                                  margin: const EdgeInsets.all(4),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: const ShapeDecoration(
                                    shape: CircleBorder(),
                                    color: Colors.white,
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: "https://img.freepik.com/free-photo/man-smiling-with-hands-hips_1187-3017.jpg",
                                    height: screenSize.height * 0.12,
                                    width: screenSize.height * 0.12,
                                    errorWidget: (_, __, ___) => Image.asset(
                                      'assets/images/user_img.png',
                                      fit: BoxFit.cover,
                                      height: 50,
                                      width: 50,
                                    ),
                                    placeholder: (_, __) => const SizedBox(),
                                    fit: BoxFit.cover,
                                  ))),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      Text(
                         "Demo singh",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500)),
                      Text("demo@gmail.com",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400)),
                      const SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  // height: SizeConfig.heightMultiplier! * .5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      // _drawerTile(
                      //     active: true,
                      //     title: "My Orders",
                      //     icon: const ImageIcon(
                      //       AssetImage('assets/images/note-2.png'),
                      //       size: 22,
                      //       color: Color(0xFF4F535E),
                      //     ),
                      //     onTap: () {
                      //
                      //       // }
                      //     }),
                      // const Divider(
                      //   height: 1,
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15, top: 15, bottom: 12, left: 15),
                        child: InkWell(
                          onTap: () {

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.favorite_border,
                                color: Color(0xFF4F535E),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Text(
                                "Favorites".tr,
                                style: TextStyle(color: const Color(0xFF4F535E), fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        height: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15, top: 15, bottom: 12, left: 15),
                        child: InkWell(
                          onTap: () {

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.dashboard,
                                color: Color(0xFF4F535E),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Text(
                                "Orders",
                                style: TextStyle(color: const Color(0xFF4F535E), fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        height: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15, top: 15, bottom: 12, left: 15),
                        child: InkWell(
                          onTap: () {

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.shopping_cart,
                                color: Color(0xFF4F535E),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Text(
                                "Mycart",
                                style: TextStyle(color: const Color(0xFF4F535E), fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        height: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15, top: 15, bottom: 12, left: 15),
                        child: InkWell(
                          onTap: () {

                          },
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                               Icon(
                                Icons.account_circle_outlined,
                                color: Color(0xFF4F535E),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Text(
                                "MyProfile",
                                style: TextStyle(color: const Color(0xFF4F535E), fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // const Divider(
                      //   height: 1,
                      // ),
                      // _drawerTile(
                      //     active: true,
                      //     title: "Refer and Earn",
                      //     icon: const ImageIcon(
                      //       AssetImage('assets/images/notebook_reference.png'),
                      //       size: 22,
                      //       color: Color(0xFF4F535E),
                      //     ),
                      //     onTap: () async {
                      //
                      //     }),
                      const Divider(
                        height: 1,
                      ),
                      // _drawerTile(
                      //     active: true,
                      //     title: "Subscriptions",
                      //     icon: const ImageIcon(
                      //       AssetImage('assets/images/subscription.png'),
                      //       size: 22,
                      //       color: Color(0xFF4F535E),
                      //     ),
                      //     onTap: () async {
                      //       // if (controller.model.value.data![0].status == "Active") {
                      //       //   Get.toNamed(ThankYouScreen2.thankYouScreen2);
                      //       // } else {
                      //
                      //       // }
                      //
                      //       // }
                      //     }),
                      // const Divider(
                      //   height: 1,
                      // ),
                      // _drawerTile(
                      //     active: true,
                      //     title: "Privacy Policy",
                      //     icon: const ImageIcon(
                      //       AssetImage('assets/images/metro-security.png'),
                      //       size: 22,
                      //       color: Color(0xFF4F535E),
                      //     ),
                      //     onTap: () async {
                      //
                      //     }),
                      // const Divider(
                      //   height: 1,
                      // ),
                      // _drawerTile(
                      //     active: true,
                      //     title: "My Chats",
                      //     icon: const ImageIcon(
                      //       AssetImage('assets/images/chatchatting.png'),
                      //       size: 22,
                      //       color: Color(0xFF4F535E),
                      //     ),
                      //     onTap: () async {
                      //
                      //     }),
                      // const Divider(
                      //   height: 1,
                      // ),
                      // _drawerTile(
                      //     active: true,
                      //     title: "Help Center",
                      //     icon: const ImageIcon(
                      //       AssetImage('assets/images/helpICon.png'),
                      //       size: 22,
                      //       color: Color(0xFF4F535E),
                      //     ),
                      //     onTap: () async {
                      //       //Get.toNamed(MyRouters.helpCenterScreen);
                      //       // }
                      //     }),
                      // const Divider(
                      //   height: 1,
                      // ),
                      // _drawerTile(
                      //     active: true,
                      //     title: "Logout",
                      //     icon: const ImageIcon(
                      //       AssetImage('assets/images/logout.png'),
                      //       size: 22,
                      //       color: Color(0xFF4F535E),
                      //     ),
                      //     onTap: () async {
                      //
                      //     }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

    );
  }

  Widget _drawerTile({required bool active, required String title, required ImageIcon icon, required VoidCallback onTap}) {
    return ListTile(
      selectedTileColor: Colors.yellow.withOpacity(0.95),
      leading: icon,
      minLeadingWidth: 30,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF4F535E),
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: active ? onTap : null,
    );
  }
}
