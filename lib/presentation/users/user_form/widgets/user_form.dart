import 'package:auth_userlist_chat/application/users/user_form/user_form_cubit.dart';
import 'package:auth_userlist_chat/presentation/users/user_form/widgets/user_form_template.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class UserForm extends StatelessWidget {
  final String? documentId;

  const UserForm({Key? key, this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (documentId != null) {
      context.read<UserFormCubit>().setUserId(documentId!);
    }

    return BlocListener<UserFormCubit, UserFormState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Saving Failure'),
              ),
            );
        }

        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: FutureBuilder<DocumentSnapshot>(
        future: context.read<UserFormCubit>().getUser(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const UserFormTemplate(
              body: Text(
                "Something went wrong",
                style: TextStyle(color: Colors.red, fontSize: 22),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const UserFormTemplate(body: Center(child: CircularProgressIndicator()));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic>? data = snapshot.data?.data() as Map<String, dynamic>?;
            if (data != null) {
              context.read<UserFormCubit>().usernameChanged(data['username']);
              context.read<UserFormCubit>().firstnameChanged(data['firstname']);
              context.read<UserFormCubit>().lastnameChanged(data['lastname']);
              context.read<UserFormCubit>().phoneChanged(data['phone']);
            }
          }

          return UserFormTemplate(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    _UsernameInput(),
                    const SizedBox(height: 8),
                    _FirstnameInput(),
                    const SizedBox(height: 8),
                    _LastnameInput(),
                    const SizedBox(height: 8),
                    _PhoneInput(),
                  ],
                ),
              ),
            ),
            persistentFooterButtons: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _SaveButton(),
                  _CancelButton(),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserFormCubit, UserFormState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextFormField(
          onChanged: (username) => context.read<UserFormCubit>().usernameChanged(username),
          keyboardType: TextInputType.text,
          initialValue: state.username.value,
          decoration: InputDecoration(
            labelText: 'User name',
            errorText: state.username.invalid ? 'invalid username' : null,
          ),
        );
      },
    );
  }
}

class _FirstnameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserFormCubit, UserFormState>(
      buildWhen: (previous, current) => previous.firstname != current.firstname,
      builder: (context, state) {
        return TextFormField(
          onChanged: (firstname) => context.read<UserFormCubit>().firstnameChanged(firstname),
          keyboardType: TextInputType.text,
          initialValue: state.firstname.value,
          decoration: InputDecoration(
            labelText: 'First name',
            errorText: state.firstname.invalid ? 'invalid firstname' : null,
          ),
        );
      },
    );
  }
}

class _LastnameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserFormCubit, UserFormState>(
      buildWhen: (previous, current) => previous.lastname != current.lastname,
      builder: (context, state) {
        return TextFormField(
          onChanged: (lastname) => context.read<UserFormCubit>().lastnameChanged(lastname),
          keyboardType: TextInputType.text,
          initialValue: state.lastname.value,
          decoration: InputDecoration(
            labelText: 'Last name',
            errorText: state.lastname.invalid ? 'invalid lastname' : null,
          ),
        );
      },
    );
  }
}

class _PhoneInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserFormCubit, UserFormState>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        return TextFormField(
          onChanged: (phone) => context.read<UserFormCubit>().phoneChanged(phone),
          keyboardType: TextInputType.phone,
          initialValue: state.phone.value,
          decoration: InputDecoration(
            labelText: 'Phone',
            errorText: state.phone.invalid ? 'invalid phone' : null,
          ),
        );
      },
    );
  }
}

class _SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserFormCubit, UserFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: state.status.isValidated
                    ? () => context.read<UserFormCubit>().saveUser()
                    : null,
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
      },
    );
  }
}

class _CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color?>(Colors.redAccent),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text(
        'Cancel',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
