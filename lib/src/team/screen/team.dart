import 'package:flutter/material.dart';
import 'package:team_management/customised/widgets/buttons.dart';
import 'package:team_management/src/auth/register/register.dart';
import 'package:team_management/src/dashboard/screen/dashboard.dart';
import 'package:team_management/src/team/screen/addmembers.dart';

import '../../../controllers/teamcontroller.dart';

class CreateTeam extends StatefulWidget {
  const CreateTeam({super.key});

  @override
  State<CreateTeam> createState() => CreateTeamState();
}

class CreateTeamState extends State<CreateTeam> {
  final teamNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Dashboard(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.arrow_back)),
                    Text(
                      'Team Managment',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.more_horiz)),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade300,
                child: IconButton(
                  iconSize: 50,
                  icon: const Icon(
                    Icons.home_work_sharp,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: getHeight(context) * 0.02,
              ),
              Text(
                'Create an Team',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Lets get You set Up!',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(
                height: getHeight(context) * 0.02,
              ),
              const Text('Hi Ahmed', style: TextStyle(fontSize: 20)),
              Text(
                'Looks Like you Want to create a team',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(
                height: getHeight(context) * 0.07,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onSubmitted: (value) async {
                          String teamId = await TeamController().createTeam(
                            teamNameController.text.trim(),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddMembers(
                                teamId: teamId,
                              ),
                            ),
                          );
                        },
                        controller: teamNameController,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          hintText: '  e.g, Imapact It Solutions',
                          hintStyle: Theme.of(context).textTheme.titleSmall,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          disabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getHeight(context) * 0.02,
              ),
              CustomButtons(
                buttonText: 'Create and Get Started',
                onPressed: () async {
                  String teamId = await TeamController().createTeam(
                    teamNameController.text.trim(),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddMembers(
                        teamId: teamId,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
