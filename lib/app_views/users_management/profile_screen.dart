
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

class ProfileScreen extends StatefulWidget {
  static const id = "user-profile";
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController roleController;

  bool onlyReadName = true;
  bool onlyReadRole = true;

  @override
  void initState() {
    nameController = TextEditingController();
    roleController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    nameController.dispose();
    roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile",),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: 200.w,
                height: 200.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network("src"),

              ),
              const SizedBox(height: 32.0,),
              const Text("ali99@gmail.com", style: k16Normal,),
              const SizedBox(height: 16.0,),
              Form(
                key: _formKey, child: Column(
                children: [
                  TextFormField(
                    readOnly: onlyReadName,
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "name",
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          onlyReadRole = !onlyReadName;
                        });
                      }, icon: const Icon(Icons.edit_calendar_sharp))

                    ),

                  ),
                  const SizedBox(height: 8.0,),
                  TextFormField(
                    readOnly: onlyReadRole,
                    controller: roleController,
                    decoration: InputDecoration(
                        labelText: "role",
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            onlyReadRole = !onlyReadName;
                          });
                        }, icon: const Icon(Icons.edit_calendar_sharp))

                    ),

                  ),
                  const SizedBox(height: 8.0,),

                ],
              ),

              ),
              const SizedBox(height: 40,),
              ListTile(
                tileColor: const Color(0xFFAFAFAF).withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                onTap: (){},
                leading: const Icon(Icons.key),
                title: const Text("Change Password"),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const SizedBox(height: 32.0,),
              GestureDetector(
                onTap: (){},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12.0)
                  ),
                  child: const Text("Delete"),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


const TextStyle k18Normal = TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black);
const TextStyle k16Normal = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black);
const TextStyle k14Normal = TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black);
const TextStyle k12Normal = TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black);

const TextStyle k18w = TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black);
const TextStyle k16w = TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black);
const TextStyle k14w = TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black);
const TextStyle k12w = TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black);