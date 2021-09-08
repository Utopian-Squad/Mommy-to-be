import 'dart:io';

import 'package:client/src/exercise/blocs/blocs.dart';
import 'package:client/src/exercise/models/exercise_argument.dart';
import 'package:client/src/exercise/models/exercise_model.dart';
import 'package:client/src/exercise/widgets/exercise_home.dart';
import 'package:client/src/utilities/constants.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class NurseExerciseForm extends StatefulWidget {
  static const String routeName = "/nurseExerciseForm";
  final ExerciseArgument args;

  NurseExerciseForm({required this.args});

  @override
  _NurseExerciseFormState createState() => _NurseExerciseFormState();
}

class _NurseExerciseFormState extends State<NurseExerciseForm> {
  final ImagePicker _picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _exercise = {};

  File? _image;

  final picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        this._exercise["image"] = pickedImage;
      });
    }
  }

  onSubmit() {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      final ExerciseEvent event = widget.args.edit
          ? ExerciseUpdate(
              Exercise(
                id: widget.args.exercise?.id,
                name: this._exercise["name"],
                type: this._exercise["type"],
                duration: this._exercise["duration"],
                image: this._exercise["image"],
                description: this._exercise["description"],
              ),
            )
          : ExerciseCreate(
              Exercise(
                id: null,
                name: this._exercise["name"],
                type: this._exercise["type"],
                description: this._exercise["description"],
                duration: this._exercise["duration"],
                image: this._exercise["image"],
              ),
            );
      BlocProvider.of<ExerciseBloc>(context).add(event);
      Navigator.of(context).pushNamedAndRemoveUntil(
          ExerciseHomeScreen.routeName, (route) => true);
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
      this._exercise["name"] = widget.args.exercise?.name;
      this._exercise["type"] = widget.args.exercise?.type;
      this._exercise["description"] = widget.args.exercise?.description;
      this._exercise["duration"] = widget.args.exercise?.duration;
      this._exercise["image"] = widget.args.exercise?.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        title:
            Text('${widget.args.edit ? "Edit Exercise" : "Add New Exercise"}'),
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
                        title: Text("Exercise Name"),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                        content: TextFormField(
                            initialValue: widget.args.edit
                                ? widget.args.exercise?.name
                                : "",
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Please enter exercise name';
                              }
                              return null;
                            },
                            decoration:
                                InputDecoration(labelText: 'Exercise Name'),
                            onChanged: (value) {
                              setState(() {
                                this._exercise["name"] = value;
                              });
                            }),
                      ),
                      Step(
                        title: Text("Exercise Type"),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 1
                            ? StepState.complete
                            : StepState.disabled,
                        content: TextFormField(
                            initialValue: widget.args.edit
                                ? widget.args.exercise?.type
                                : "",
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Please enter exercise Type';
                              }
                              return null;
                            },
                            decoration:
                                InputDecoration(labelText: 'Exercise Type'),
                            onChanged: (value) {
                              setState(() {
                                this._exercise["type"] = value;
                              });
                            }),
                      ),
                      Step(
                        title: Text("Exercise description"),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 2
                            ? StepState.complete
                            : StepState.disabled,
                        content: TextFormField(
                            initialValue: widget.args.edit
                                ? widget.args.exercise?.description
                                : "",
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Please enter exercise description';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'Exercise description'),
                            onChanged: (value) {
                              setState(() {
                                this._exercise["description"] = value;
                              });
                            }),
                      ),
                      Step(
                        title: Text("Duration"),
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
                          showAsSuffixIcons: true,
                          clearButtonBuilder: (_) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const Icon(
                              Icons.clear,
                              size: 24,
                              color: Colors.black,
                            ),
                          ),
                          label: "Duration",
                          selectedItem: widget.args.edit
                              ? widget.args.exercise?.duration
                              : this._exercise["duration"],
                          items: ["1 Week", "2 Weeks", "3 Weeks", '4 Weeks'],
                          onChanged: (value) {
                            this._exercise["duration"] = value;
                          },
                        ),
                      ),
                      if (!widget.args.edit)
                        Step(
                          title: Text("Image"),
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
                                      backgroundImage: Image.network(
                                              "${Constants.imageBaseUrl}images/exercise/${widget.args.exercise?.image}")
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
