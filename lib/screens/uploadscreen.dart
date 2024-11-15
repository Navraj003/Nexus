import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nexus_app/categories/categ_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var cloudinary = Cloudinary.fromStringUrl(
    'cloudinary://654296379613984:Po2AFfi7CtgVewcbeFtXqWNNH5w@dtzo7u6vj');

final _firebase = FirebaseAuth.instance;

class Upload extends StatefulWidget {
  const Upload({super.key,});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldkey =
      GlobalKey<ScaffoldMessengerState>();
     // late List<dynamic> imageslist = widget.prolist['proimages'];
      
  late double price;
  late int qty;
  late String prodname;
  late String proddesc;
  late String prodid;
  String _selectedTask= "";

  String mainCatVal = 'select category';
  String subCatVal = 'subcategory';

  CollectionReference productss =
      FirebaseFirestore.instance.collection('products');
      CollectionReference donationn =
      FirebaseFirestore.instance.collection('Donation');


  List<String> subCategList = [];

  final ImagePicker _picker = ImagePicker();

  List<XFile> imageFileList = [];
  List<String> imageUrlList = [];
  // Ensures it’s initialized as an empty list
  dynamic _pickedImageError;

  void pickImages() async {
    try {
      final pickedImages = await _picker.pickMultiImage(
          maxHeight: 300, maxWidth: 300, imageQuality: 95);

      setState(() {
        imageFileList = pickedImages ?? [];
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  Widget previewImages() {
    if (imageFileList.isNotEmpty) {
      return ListView.builder(
          itemCount: imageFileList.length,
          itemBuilder: (context, index) {
            return Image.file(File(imageFileList[index].path));
          });
    } else {
      return const Center(
        child: Text(
          'You have not picked images yet',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      );
    }
  }

  List<String> maincateg = [
    'select category',
    'electronics',
    'accessories',
    'books and stuffs',
    'beauty',
    'clothes and footwear',
    'furniture and bedding',
  ];
  void selecledMaincateg(String? value) {
    if (value == 'select category') {
      subCategList = [];
    } else if (value == 'electronics') {
      subCategList = cat1;
    } else if (value == 'accessories') {
      subCategList = cat2;
    } else if (value == 'books and stuffs') {
      subCategList = cat3;
    } else if (value == 'beauty') {
      subCategList = cat4;
    } else if (value == 'clothes and footwear') {
      subCategList = cat5;
    } else if (value == 'furniture and bedding') {
      subCategList = cat6;
    }
    print(value);
    setState(() {
      mainCatVal = value!;
      subCatVal = 'subcategory';
    });
  }

  Future<void> uploadimgs() async {
    if (mainCatVal != 'select category' && subCatVal != 'subcategory') {
      if (_formkey.currentState?.validate() ?? false) {
        _formkey.currentState?.save();
        if (imageFileList.isNotEmpty) {
          try {
            const cloudName = 'dtzo7u6vj';
            const uploadPreset = 'products';
            for (var image in imageFileList) {
              String filePath = image.path;
              var request = http.MultipartRequest(
                'POST',
                Uri.parse(
                    'https://api.cloudinary.com/v1_1/$cloudName/image/upload'),
              );
              request.fields['upload_preset'] = uploadPreset;
              request.files
                  .add(await http.MultipartFile.fromPath('file', filePath));

              var response = await request.send();

              if (response.statusCode == 200) {
                var responseData = await response.stream.bytesToString();
                var data = json.decode(responseData);
                String imageUrl = data['secure_url'];
                imageUrlList.add(imageUrl); // Save the URL for later use
                print('Uploaded Image URL: $imageUrl');
              } else {
                print('Failed to upload image to Cloudinary');
              }
            }
          } catch (e) {
            print('Error uploading images: $e');
          }
          setState(() {
            imageFileList = [];
          });
          _formkey.currentState!.reset();
        } else {
          _scaffoldkey.currentState?.showSnackBar(
            const SnackBar(
              content: Text('Please pick an image.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        _scaffoldkey.currentState?.showSnackBar(
          const SnackBar(
            content: Text('Please fill out all fields correctly.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      _scaffoldkey.currentState?.showSnackBar(
        const SnackBar(
          content: Text('Please select categories'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void uploadData() async {
    print('price: $price, qty: $qty, prodname: $prodname, proddesc: $proddesc');
    if (imageUrlList.isNotEmpty) {
      print('mainCatVal: $mainCatVal, subCatVal: $subCatVal');
      CollectionReference productss =
          FirebaseFirestore.instance.collection('products');
      prodid = const Uuid().v4();
      await productss.doc(prodid).set({
        'maincateg': mainCatVal,
        'subcateg': subCatVal,
        'price': price,
        'instock': qty,
        'proname': prodname,
        'prodesc': proddesc,
        'sid': FirebaseAuth.instance.currentUser!.uid,
        'proimages': imageUrlList,
        'discount': 0,
        'proid': prodid,
      });
      setState(() {
        mainCatVal = 'select category';
        subCatVal = 'subcategory';
      });
      //context.read<Basket>().getbasketItems
    } else {
      print('no images');
    }
  }

  void donateData() async {
    print( 'prodname: $prodname, proddesc: $proddesc');
    if (imageUrlList.isNotEmpty) {
      print('mainCatVal: $mainCatVal, subCatVal: $subCatVal');
      CollectionReference donationn =
          FirebaseFirestore.instance.collection('Donation');
      prodid = const Uuid().v4();
      await donationn.doc(prodid).set({
        'maincateg': mainCatVal,
        'subcateg': subCatVal,
        'proname': prodname,
        'prodesc': proddesc,
        'sid': FirebaseAuth.instance.currentUser!.uid,
        'proimages': imageUrlList,
        'proid': prodid,
      });
      setState(() {
        mainCatVal = 'select category';
        subCatVal = 'subcategory';
      });
    } else {
      print('no images');
    }
  }
  void uploadProduct() async {
    // Call uploadimgs and then call uploadData only if uploadimgs was successful
    await uploadimgs();
    if (imageUrlList.isNotEmpty) {
      uploadData();
    } else {
      print(
          'No images were uploaded to Cloudinary, skipping Firestore upload.');
    }
  }
    void donateProduct() async {
    // Call uploadimgs and then call uploadData only if uploadimgs was successful
    await uploadimgs();
    if (imageUrlList.isNotEmpty) {
      donateData();
    } else {
      print(
          'No images were uploaded to Cloudinary, skipping Firestore upload.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldkey, // Assign _scaffoldkey here
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formkey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                            color: const Color.fromARGB(255, 239, 242, 247),
                            height: MediaQuery.of(context).size.width * 0.5,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: imageFileList != null
                                ? previewImages()
                                : const Center(
                                    child: Text(
                                      'You have not picked images yet',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.4,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      'Select Category       ',
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(255, 3, 3, 3),
                                        ),
                                      ),
                                    ),
                                    DropdownButton(
                                        iconSize: 25,
                                        iconEnabledColor: Colors.black,
                                        iconDisabledColor: const Color.fromARGB(
                                            255, 188, 186, 186),
                                        dropdownColor: const Color.fromARGB(
                                            255, 249, 249, 249),
                                        value: mainCatVal,
                                        items: maincateg
                                            .map<DropdownMenuItem<String>>(
                                                (value) {
                                          return DropdownMenuItem(
                                              value: value,
                                              child: Text(value,
                                                  style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromARGB(
                                                          255, 3, 3, 3),
                                                    ),
                                                  )));
                                        }).toList(),
                                        onChanged: (String? value) {
                                          selecledMaincateg(value);
                                          print(mainCatVal);
                                        }),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      'Select subCategory',
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(255, 3, 3, 3),
                                        ),
                                      ),
                                    ),
                                    DropdownButton(
                                        iconSize: 25,
                                        menuMaxHeight: 500,
                                        disabledHint: Text('select category',
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(
                                                    255, 3, 3, 3),
                                              ),
                                            )),
                                        value: subCatVal,
                                        items: subCategList
                                            .map<DropdownMenuItem<String>>(
                                                (value) {
                                          return DropdownMenuItem(
                                              value: value,
                                              child: Text(value,
                                                  style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromARGB(
                                                          255, 60, 60, 60),
                                                    ),
                                                  )));
                                        }).toList(),
                                        onChanged: (String? value) {
                                          print(value);
                                          setState(() {
                                            subCatVal = value!;
                                          });
                                        })
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                      child: Divider(
                        color: Color.fromARGB(255, 203, 203, 202),
                        thickness: 1.5,
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(children: [
                            Radio<String>(
                              value: "Sell",
                              groupValue: _selectedTask,
                              onChanged: (value) {
                                setState(() {
                                  _selectedTask= value!;
                                });
                              },
                            ),
                            Text(
                              "Sell",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 3, 3, 3)),
                              ),
                            ),
                          ]),
                          Row(children: [
                            Radio<String>(
                              value: "Donate",
                              groupValue:_selectedTask ,
                              onChanged: (value) {
                                setState(() {
                                _selectedTask = value!;
                                });
                              },
                            ),
                            Text(
                              "Donate",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 3, 3, 3)),
                              ),
                            ),
                          ]),
                        
                        ],
                      ),
                      if (_selectedTask == "Sell")


                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter price';
                            } else if (!value.isValidprice()) {
                              return 'Invalid price';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            price = double.parse(value!);
                          },
                          keyboardType: const TextInputType.numberWithOptions(),
                          decoration: textFormDecoration.copyWith(
                            labelText: 'Price',
                            hintText: 'Price (₹)',
                          ),
                        ),
                      ),
                    ),
                    if (_selectedTask == "Sell")
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Quantity';
                            } else if (!value.isValidQuantity()) {
                              return 'Invalid quantity';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            qty = int.parse(value!);
                          },
                          keyboardType: const TextInputType.numberWithOptions(),
                          decoration: textFormDecoration.copyWith(
                            labelText: 'Quantity',
                            hintText: 'Add Quantity',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter product name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            prodname = value!;
                          },
                          maxLength: 100,
                          maxLines: 3,
                          decoration: textFormDecoration.copyWith(
                            labelText: 'Product Name',
                            hintText: 'Enter product name',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter description';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            proddesc = value!;
                          },
                          maxLength: 800,
                          maxLines: 3,
                          decoration: textFormDecoration.copyWith(
                            labelText: 'Product Description',
                            hintText: 'Enter product description',
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: FloatingActionButton(
                onPressed: imageFileList.isEmpty
                    ? () {
                        pickImages();
                      }
                    : () {
                        setState(() {
                          imageFileList = [];
                        });
                      },
                backgroundColor: const Color.fromARGB(255, 3, 3, 3),
                child: imageFileList.isEmpty
                    ? const Icon(
                        Icons.photo_library,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
              ),
            ),
            FloatingActionButton(
              onPressed:(_selectedTask=="Sell")?uploadProduct:donateProduct,
              backgroundColor: const Color.fromARGB(255, 3, 3, 3),
              child: const Icon(
                Icons.upload,
                color: Colors.white,
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  labelText: 'Price',
  hintStyle: GoogleFonts.poppins(
    color: const Color.fromARGB(255, 31, 31, 31),
  ),
  hintText: 'Price (₹)',
  labelStyle: GoogleFonts.poppins(
    color: const Color.fromARGB(255, 23, 22, 22),
  ),
  border: const OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 111, 111, 111)),
      borderRadius: BorderRadius.zero),
  enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 3, 3, 3)),
      borderRadius: BorderRadius.zero),
  focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 3, 3, 3)),
      borderRadius: BorderRadius.zero),
);

extension QuantityValidator on String {
  bool isValidQuantity() {
    final quantity = int.tryParse(this);
    return quantity != null && quantity >= 1 && quantity <= 500;
  }
}

extension PriceValidator on String {
  bool isValidprice() {
    // Allows prices in the range 10 to 75000, optionally with commas and up to two decimal places
    final price = double.tryParse(this.replaceAll(',', ''));
    return price != null && price >= 10 && price <= 75000;
    // RegExp(r'^[1-9]\d{0,2}(\,\d{2})*(\.\d{1,2})?$').hasMatch(this);
  }
}
