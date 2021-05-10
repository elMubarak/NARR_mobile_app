import 'package:flutter/material.dart';
import 'package:narr/screens/admin_dash/admin_dash.dart';
import 'package:narr/screens/convert_to_pdf.dart';
import 'package:narr/screens/crowd_funding.dart';
import 'package:narr/screens/edit_profile.dart';
import 'package:narr/screens/email_client/email_list.dart';
import 'package:narr/screens/error_screen.dart';
import 'package:narr/screens/grants.dart';
import 'package:narr/screens/ictWorks.dart';
import 'package:narr/screens/investor_dash/investor_dasboard.dart';
import 'package:narr/screens/ocr_result.dart';
import 'package:narr/screens/register_organisations.dart';
import 'package:narr/screens/repository_list.dart';
import 'package:narr/screens/research_grants_proposal.dart';
import 'package:narr/screens/splash_screen.dart';
import 'package:narr/screens/sponsor_dash/sponsor_dashboard.dart';
import '../screens/about.dart';
import '../screens/bulk_file_upload.dart';
import '../screens/chat.dart';
import '../screens/forgotPassword.dart';
import '../screens/history.dart';
import '../screens/home.dart';
import '../screens/login.dart';
import '../screens/ocr.dart';
import '../screens/profile.dart';
import '../screens/register.dart';
import '../screens/single_file_upload.dart';
import '../screens/narr_users.dart';
import '../screens/verify_email.dart';
import '../screens/video_conf.dart';

Map<String, WidgetBuilder> myRoute = {
  HomeScreen.id: (context) => HomeScreen(),
  AdminDashBoard.id: (context) => AdminDashBoard(),
  SponsorDashboard.id: (context) => SponsorDashboard(),
  InvestorDashboard.id: (context) => InvestorDashboard(),
  SingleFileUpload.id: (context) => SingleFileUpload(),
  BulkFileUpload.id: (context) => BulkFileUpload(),
  ChatScreen.id: (context) => ChatScreen(),
  OCRScreen.id: (context) => OCRScreen(),
  AboutUs.id: (context) => AboutUs(),
  VideoConferenceScreen.id: (context) => VideoConferenceScreen(),
  Profile.id: (context) => Profile(),
  History.id: (context) => History(),
  Login.id: (context) => Login(),
  Register.id: (context) => Register(),
  RegisterOrg.id: (context) => RegisterOrg(),
  ForgotPassword.id: (context) => ForgotPassword(),
  NarrUsers.id: (context) => NarrUsers(),
  VerifyAccount.id: (context) => VerifyAccount(),
  OcrResult.id: (context) => OcrResult(),
  ConvertToPDF.id: (context) => ConvertToPDF(),
  CrowdFunding.id: (context) => CrowdFunding(),
  Grants.id: (context) => Grants(),
  ResearchGrantsProposal.id: (context) => ResearchGrantsProposal(),
  RepositoryList.id: (context) => RepositoryList(),
  EditProfile.id: (context) => EditProfile(),
  SplashScreen.id: (context) => SplashScreen(),
  IctWorks.id: (context) => IctWorks(),
  ErrorNavigation.id: (context) => ErrorNavigation(),
  EmailList.id: (context) => EmailList(),
};
