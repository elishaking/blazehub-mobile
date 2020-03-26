import 'package:blazehub/models/profile.dart';
import 'package:blazehub/utils/errors.dart';
import 'package:blazehub/view_models/profile.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  final ProfileViewModel model;
  final Profile newProfile;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  EditProfile(this.model)
      : newProfile = model.profileState.profileInfo.copyWith();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: newProfile.name,
                  decoration: InputDecoration(
                    labelText: 'name',
                  ),
                  onSaved: (text) {
                    newProfile.name = text;
                  },
                  validator: (text) {
                    if (text.isEmpty) return requiredFieldError('name');
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                // TODO: add username validation
                // TextFormField(
                //   decoration: InputDecoration(
                //     labelText: 'username',
                //   ),
                //   onSaved: (text) {},
                //   validator: (text){
                //     if(text.isEmpty) return requiredFieldError('username');
                //   },
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                TextFormField(
                  initialValue: newProfile.bio,
                  minLines: 3,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'bio',
                  ),
                  onSaved: (text) {
                    newProfile.bio = text;
                  },
                  // validator: (text){
                  //   if(text.isEmpty) return requiredFieldError('bio');
                  // },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: newProfile.location,
                  decoration: InputDecoration(
                    labelText: 'location',
                  ),
                  onSaved: (text) {
                    newProfile.location = text;
                  },
                  // validator: (text){
                  //   if(text.isEmpty) return requiredFieldError('location');
                  // },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: newProfile.website,
                  decoration: InputDecoration(
                    labelText: 'website',
                  ),
                  onSaved: (text) {
                    newProfile.website = text;
                  },
                  // validator: (text){
                  //   if(text.isEmpty) return requiredFieldError('name');
                  // },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: newProfile.birth,
                  decoration: InputDecoration(
                    labelText: 'birth date',
                  ),
                  onSaved: (text) {
                    newProfile.birth = text;
                  },
                  // validator: (text){
                  //   if(text.isEmpty) return requiredFieldError('name');
                  // },
                ),
                SizedBox(
                  height: 20,
                ),
                SubmitForm(_formKey, model, newProfile)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubmitForm extends StatefulWidget {
  const SubmitForm(
    GlobalKey<FormState> formKey,
    this.model,
    this.newProfile,
  ) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final ProfileViewModel model;
  final Profile newProfile;

  @override
  _SubmitFormState createState() => _SubmitFormState();
}

class _SubmitFormState extends State<SubmitForm> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? CircularProgressIndicator()
        : RaisedButton(
            onPressed: () {
              if (widget._formKey.currentState.validate()) {
                widget._formKey.currentState.save();
                setState(() {
                  loading = true;
                });
                widget.model
                    .updateProfileInfo(
                  widget.model.authState.user.id,
                  widget.newProfile,
                )
                    .then((isSuccessful) {
                  setState(() {
                    loading = false;
                  });

                  if (isSuccessful) Navigator.of(context).pop();
                });
              }
            },
            child: Text('Save'),
          );
  }
}
