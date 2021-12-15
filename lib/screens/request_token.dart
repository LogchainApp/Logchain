import 'package:flutter/material.dart';
import 'package:logchain/widgets/MenuButton.dart';

import '../utils/text_formatted/upper_case_text_formatter.dart';

class RequestToken extends StatelessWidget {
  const RequestToken({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 48,
            color: Theme.of(context).shadowColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                height: 800,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 128),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Request Token",
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(fontSize: 48),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Ask developers to add your custom token.",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 32),
                          Material(
                            borderRadius: BorderRadius.circular(16),
                            color: Theme.of(context).primaryColorLight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: TextFormField(
                                textCapitalization:
                                    TextCapitalization.sentences,
                                keyboardType: TextInputType.text,
                                autofocus: false,
                                style: Theme.of(context).textTheme.headline6,
                                onChanged: (String value) {},
                                cursorColor: Theme.of(context).primaryColor,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 24),
                                  focusColor: Theme.of(context).primaryColor,
                                  border: InputBorder.none,
                                  hintText: "Name",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 32),
                          Material(
                            borderRadius: BorderRadius.circular(16),
                            color: Theme.of(context).primaryColorLight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: TextFormField(
                                textCapitalization:
                                    TextCapitalization.sentences,
                                keyboardType: TextInputType.text,
                                autofocus: false,
                                inputFormatters: [UpperCaseTextFormatter()],
                                style: Theme.of(context).textTheme.headline6,
                                onChanged: (String value) {},
                                cursorColor: Theme.of(context).primaryColor,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 24),
                                  focusColor: Theme.of(context).primaryColor,
                                  border: InputBorder.none,
                                  hintText: "Symbol",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 32),
                          Material(
                            borderRadius: BorderRadius.circular(16),
                            color: Theme.of(context).primaryColorLight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: TextFormField(
                                keyboardType: TextInputType.url,
                                autofocus: false,
                                style: Theme.of(context).textTheme.headline6,
                                onChanged: (String value) {},
                                cursorColor: Theme.of(context).primaryColor,
                                decoration: InputDecoration(
                                  prefixIcon: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "https://",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                      ),
                                    ],
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 24),
                                  focusColor: Theme.of(context).primaryColor,
                                  border: InputBorder.none,
                                  hintText: "Website",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),
                    MenuButton(icon: Icons.send, title: "Request"),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
