import 'dart:io';
import 'package:client/src/nutrition/blocs/blocs.dart';
import 'package:client/src/nutrition/models/food_argument.dart';
import 'package:client/src/nutrition/models/food_model.dart';
import 'package:client/src/nutrition/widgets/food_home.dart';
import 'package:client/src/utilities/constants.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class NurseFoodForm extends StatefulWidget {
  static const String routeName = "/nurseFoodForm";
  final FoodArgument args;

  NurseFoodForm({required this.args});

  @override
  _NurseFoodFormState createState() => _NurseFoodFormState();
}

class _NurseFoodFormState extends State<NurseFoodForm> {
  final ImagePicker _picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> food = {};

  File? _image;

  final picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        this.food["image"] = pickedImage;
      });
    }
  }

  onSubmit() {
    print("object");
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      final FoodEvent event = widget.args.edit
          ? FoodUpdate(
              Food(
                id: widget.args.food?.id,
                name: this.food["name"],
                type: this.food["type"],
                display: this.food["display"],
                image: this.food["image"],
                description: this.food["description"],
              ),
            )
          : FoodCreate(
              Food(
                id: null,
                name: this.food["name"],
                type: this.food["type"],
                description: this.food["description"],
                display: this.food["display"],
                image: this.food["image"],
              ),
            );
      BlocProvider.of<FoodBloc>(context).add(event);
      Navigator.of(context).pushNamed(FoodHomeScreen.routeName);
    }
  }

  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    if (!widget.args.edit)
      setState(() => _currentStep < 4 ? _currentStep += 1 : onSubmit());
    else
      setState(() => _currentStep < 3 ? _currentStep += 1 : onSubmit());
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  @override
  void initState() {
    super.initState();
    if (widget.args.edit) {
      this.food["name"] = widget.args.food?.name;
      this.food["name"] = widget.args.food?.name;
      this.food["description"] = widget.args.food?.description;
      this.food["display"] = widget.args.food?.display;
      this.food["image"] = widget.args.food?.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        title: Text(
          '${widget.args.edit ? "Edit Food" : "Add New Food"}',
        ),
      ),
      body: Container(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: Theme(
                  data: ThemeData(
                    colorScheme: Theme.of(context)
                        .colorScheme
                        .copyWith(primary: Colors.pink[400]),
                  ),
                  child: Stepper(
                    type: stepperType,
                    physics: ScrollPhysics(),
                    currentStep: _currentStep,
                    onStepTapped: (step) => tapped(step),
                    onStepContinue: continued,
                    onStepCancel: cancel,
                    steps: [
                      Step(
                        title: Text("Food Name"),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                        content: TextFormField(
                            initialValue:
                                widget.args.edit ? widget.args.food?.name : "",
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Please enter food name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: 'Food Name'),
                            onChanged: (value) {
                              setState(() {
                                this.food["name"] = value;
                              });
                            }),
                      ),
                      Step(
                        title: Text("Food Type"),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 1
                            ? StepState.complete
                            : StepState.disabled,
                        content: TextFormField(
                            initialValue:
                                widget.args.edit ? widget.args.food?.type : "",
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Please enter food type';
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: 'Food type'),
                            onChanged: (value) {
                              setState(() {
                                this.food["type"] = value;
                              });
                            }),
                      ),
                      Step(
                        title: Text("Description"),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 2
                            ? StepState.complete
                            : StepState.disabled,
                        content: TextFormField(
                            initialValue: widget.args.edit
                                ? widget.args.food?.description
                                : "",
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Please enter food name';
                              }
                              return null;
                            },
                            decoration:
                                InputDecoration(labelText: 'Description'),
                            onChanged: (value) {
                              setState(() {
                                this.food["description"] = value;
                              });
                            }),
                      ),
                      Step(
                        title: Text("Days to be eaten"),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 3
                            ? StepState.complete
                            : StepState.disabled,
                        content: DropdownSearch<dynamic>(
                          validator: (dynamic item) {
                            if (item == null)
                              return "Required field";
                            else
                              return null;
                          },
                          dropdownSearchDecoration: InputDecoration(
                            filled: true,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFFFEBEE)),
                            ),
                          ),
                          showAsSuffixIcons: true,
                          clearButtonBuilder: (_) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const Icon(
                              Icons.clear,
                              size: 24,
                              color: Colors.black,
                            ),
                          ),
                          label: "Days",
                          selectedItem: widget.args.edit
                              ? widget.args.food?.display
                              : this.food["display"],
                          items: ["1 day", "2 days", "3 days", '4 days'],
                          onChanged: (value) {
                            this.food["display"] = value;
                            print(value);
                          },
                        ),
                      ),
                      if (!widget.args.edit)
                        Step(
                          title: Text("Upload food image"),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 4
                              ? StepState.complete
                              : StepState.disabled,
                          content: CircleAvatar(
                            radius: 71,
                            backgroundColor: Colors.purple[400],
                            child: GestureDetector(
                              child: _image != null
                                  ? CircleAvatar(
                                      radius: 70,
                                      backgroundColor: Colors.white,
                                      backgroundImage: Image.file(
                                        _image!,
                                        fit: BoxFit.cover,
                                      ).image,
                                    )
                                  : CircleAvatar(
                                      radius: 70,
                                      backgroundColor: Colors.white,
                                      backgroundImage: widget.args.edit
                                          ? Image.network(
                                                  "${Constants.imageBaseUrl}images/food/${widget.args.food?.image}")
                                              .image
                                          : Image.network(
                                                  "${Constants.imageBaseUrl}images/food/default.png")
                                              .image,
                                    ),
                              onTap: _openImagePicker,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
