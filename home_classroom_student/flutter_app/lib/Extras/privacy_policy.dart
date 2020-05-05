import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Color/colors.dart';

class privacy_policy extends StatelessWidget {

  List<String> headings = [
    "PRIVACY POLICY",
    "ACCEPTANCE OF THESE TERMS",
    "MODIFICATION OF TERMS OF USE",
  "INFORMATION COLLECTED ON STUDIE",
  "USE OF INFORMATION",
  "DATA INTEGRITY",
  "DATA PROTECTION",
  "DELETION OF INFORMATION OR DATA",
  "CONTACT"];
  List<String> details = [
    "Nemeton takes your privacy seriously. As electronic commerce over the Internet increases and the volume of data transmission over networks steadily rises, maintaining the trust of users necessitates vigilant and responsible privacy protections. Please read the following to learn more about how we collect, use and safeguard the information provided by you via this site. This policy does not apply to the practices of other entities or websites that Nemeton does not own or control, or to people and entities that Nemeton does not employ or manage."
        "This Privacy Statement is incorporated into and subject to the thestudieapp.com terms of Use. If you do not agree to the terms of this Privacy Statement, please do not provide us with any information and do not use this site",
    "This Privacy Policy is incorporated into and subject to STUDIE Terms of Use. If users do not agree to the terms of this Privacy Policy Statement, please do not provide Nemeton with any information and do not use this site. By using STUDIE and voluntarily providing personally identifiable information and on STUDIE, users consent to the collection and use of such personally identifiable and information as set forth in this Privacy Policy.",
    "Nemeton reserves the right to modify any provision hereof from time to time, and such modification shall be effective immediately upon its posting on Nemeton STUDIE. You agree to be bound to any changes to this “terms of use” if you continue to use this Nemeton STUDIE after any such modification is posted. Users of Nemeton STUDIE have an affirmative duty, to keep themselves informed of changes.",
    "If registration is requested, Users agree to provide accurate and complete registration information. At the time of registration Users may be required to provide on STUDIE certain information which includes your name, address, phone number, and email address collectively referred as “User profile content “   User upon registration on STUDIE, Users are assigned one or more login IDs and passwords that will enable Users to access STUDIE. Users shall take reasonable precautions to protect against theft, loss or fraudulent use of such IDs and passwords, and Users are solely responsible for any losses arising from another party's use of such IDs and passwords, either with or without User’s knowledge. The Children’s Online Privacy and Protection Act (“COPPA”) requires that online service providers obtain parental consent or provide notice before they knowingly collect personally identifiable information online from children who are under 13. Nemeton do not knowingly collect or solicit personally identifiable information from a child under 13, except in the following circumstances:"
        "\nNemeton may collect a child’s name (first name and last initial), date of birth, email address or telephone number, and the child’s parent’s email address in order to provide notice to parents that Nemeton may contact their child for the purpose of providing the Services through STUDIE for which their teacher has signed up for. Nemeton may collect personal information through the Services from a child under 13 where that student’s school, district, and/or teacher has agreed to obtain parental consent for that child to use the Services and disclose personal information to Nemeton, for the use and benefit of providing services through STUDIE."
        "If you are a teacher, you represent and warrant that you have permission and authorization from your school and/or district to use the Services, and for purposes of COPPA compliance, you represent and warrant that you are entering into these Terms on behalf of your school and/or district.\n"
        "You may be required to provide valid school credentials and a valid school email address to verify your identity in order to access and use certain features of the Services.\n"
        "If Nemeton comes to know if any learn personal information have been collected from a student under 13 other than pursuant to the above, or if Nemeton learns that a student under 13 has provided personal information beyond what Nemeton requests from he or she, Nemeton will delete that information as quickly as possible. If you believe that a student under 13 may have provided Nemeton personal information in violation of this paragraph, please contact Nemeton at thestudieapp.com\n"
        "If Nemeton comes to know if any learn personal information have been collected from a student under 13 other than pursuant to the above, or if Nemeton learns that a student under 13 has provided personal information beyond what Nemeton requests from he or she, Nemeton will delete that information as quickly as possible. If you believe that a student under 13 may have provided Nemeton personal information in violation of this paragraph, please contact Nemeton at thestudieapp.com\n",
    "User profile content shall be retained by Nemeton only as custodian of such information and data. That such information and data shall only be used by specific Users and not by Nemeton."
        "\nIn order to facilitate interaction among Users of STUDIE, other Users may share information with Users, or Users may be allowed to access certain information about other Users of STUDIE. By entering into this Agreement, Users agree to treat information about other Users of STUDIE strictly in accordance with the Agreement"
        "\nNemeton may send push notifications to users who are students when their teacher has posted something new within the class to which they belong. If you no longer wish to receive such communications, you may turn them off at the device level. If you are a parent of a child who is under 13, you always have the choice to no longer allow your child to receive such communications by contacting us at thestudieapp.com."
        "\nAny user may email Nemeton at thestudieapp.com, if such user no longer wishes to receive communications from the Services.",
    "We do not share, sell or rent users personally identifiable information to third parties. Nemeton will not share or distribute any user information with third parties except as provided below\n"
  "When required to do so by law or regulation, or in response to a request from a law enforcement or governmental agency or authority or to establish or exercise our legal rights or defend against legal claims."
        "\nIn order to investigate, prevent, or take action regarding illegal activities, suspected fraud, situations involving potential threats to the physical safety of any person, violations of Nemeton terms of use, or as otherwise required by law."
        "\nIf Nemeton is acquired by or merged with another company. In this event, Nemeton will notify user about such merger and users being subjected to any different privacy policy"
        "\nNot withstanding the above, Nemeton employ other companies and people to perform tasks on our behalf and may need to share your information with them (and for them to use that information) in order to provide aspects of our Services to you. Some examples of services for which we may use agents include sending email or SMS or calls, analyzing data, and providing user services. These agents may use Personal Information we share with them, for example, to assist us, to provide their services to you and/or us, and to measure and improve the performance of their services."
        "\nNemeton may, work with third party websites to enhance your online experience, to send messages or letting you add \"apps\" to your account. We have no control over the policies and practices of third party websites or services as to privacy or anything else, so if you choose to allow the automatic transmissions discussed above, please review all third party websites' or services' policies before disclosing any Personal Information or other content on the Website or on any third party website or service",
    "Nemeton has adopted reasonable industry standard practices to ensure that there are adequate safeguards and techniques to protect the data of the user against any unauthorized or unlawful disclosure. Nemeton will not store, copy, disclose or use the data of the user except as necessary for the performance by Nemeton of its obligations under this Agreement."
        "\nNemeton employs physical, electronic and procedural safeguards to protect the information we receive from users from unauthorized disclosure. Nemeton limits access to personal information about user to employees of Nemeton who we believe reasonably need to come into contact with that information to provide services to users or in order to do their jobs. Users should not share their password with anyone. In addition, if user suspect unauthorized access to its information, it is user’s responsibility to contact Nemeton immediately. Nemeton will never ask user to divulge its password in written or electronic communications. Please be aware that Internet data transmission is not always secure and Nemeton cannot warrant that information user transmit utilizing this site is secure, however, Nemeton will always make reasonable efforts to ensure the security of the data provided on STUDIE. However, we cannot guarantee the security of user account information. Unauthorized entry or use, hardware or software failure, and other factors may compromise the security of user information at any time."
        ,"Nemeton employs physical, electronic and procedural safeguards to protect the information we receive from users from unauthorized disclosure. Nemeton limits access to personal information about user to employees of Nemeton who we believe reasonably need to come into contact with that information to provide services to users or in order to do their jobs. Users should not share their password with anyone. In addition, if user suspect unauthorized access to its information, it is user’s responsibility to contact Nemeton immediately. Nemeton will never ask user to divulge its password in written or electronic communications. Please be aware that Internet data transmission is not always secure and Nemeton cannot warrant that information user transmit utilizing this site is secure, however, Nemeton will always make reasonable efforts to ensure the security of the data provided on STUDIE. However, we cannot guarantee the security of user account information. Unauthorized entry or use, hardware or software failure, and other factors may compromise the security of user information at any time."
        "\nPlease note that certain information may remain in Nemeton records, server logs and archives after deletion of your account. Nemeton retains this information for purposes such as diagnosing problems with the service and for auditing legal investigations, but reserves the right to delete this information in accordance with its standard business practices in effect from time to time. Further, information and other content you have provided may remain visible elsewhere to the extent such content was copied or stored by other users."
        "\nFor under age users with an account that is inactive for twelve months or more (meaning the account has not received a message through the Services in that time), Nemeton policy is to disable access to Personal Information associated with that account."
        "\nIf yours or your child’s personal information changes, or if you no longer desire our Service, wish to refuse further contact by Nemeton with your child, you may review, correct, update, delete inaccuracies, request deletion of your child’s information, or amend it by contacting us at thestudieapp.com or by logging into your account. We will respond to your request as quickly as possible."
        "\nWe will retain yours or your child’s information for as long as your account is active or as needed to provide Services. If you wish to cancel yours or your child’s account or request that we no longer use the information to provide Services, contact us at thestudieapp.com. Note we will retain and use information, for example, to comply with our audit and legal obligations, to resolve disputes, and to enforce our agreements."
        ,"To the best of Nemeton's knowledge, all material published by Nemeton on STUDIE is done with the full agreement of the copyright owners (be that Nemeton or another party). If you come across a situation where you suspect that this may not be the case, in accordance with the Digital Millennium Copyright Act (DMCA), or if you have any questions or concerns regarding privacy we ask that you contact:"
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Privacy Policy', style: TextStyle(color: Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body: ListView(
        children: <Widget>[ListView.builder(
          shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: headings.length,
            itemBuilder: (context, ind) {
          return Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(headings[ind], style: TextStyle(fontSize: 20),),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(details[ind],textAlign: TextAlign.center, style: TextStyle(fontSize: 15),),
                ),
              ],
            ),
          );
        }),
          Container(
            margin: EdgeInsets.all(10),
            child: Text("DETAILS FOR CONTACTING NEMATON", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Text("Phone -: +91 9903259151\n Email: thestudieapp.com", style: TextStyle(fontSize: 20),),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              "Copyright © 2020, Nemeton technology and services Pvt Ltd. and/or its subsidiaries. All rights reserved.",
              textAlign: TextAlign.center,
            ),
          )
      ]),

    );
  }

}