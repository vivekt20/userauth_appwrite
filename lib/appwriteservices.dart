

import 'package:appwrite/appwrite.dart';

class Appwriteservices {
  late Client client;
  late Account account;

  static const endpoint="https://cloud.appwrite.io/v1";
  static const projectId='673e9af80010064ebf3b';

  Appwriteservices(){
    client=Client();
    client.setEndpoint(endpoint).setProject(projectId);
    account=Account(client);
  }
  Future <void>registerUser(String email,String password,String name)async{
    try{
      final response=await account.create(
        userId: ID.unique(),
         email: email,
          password: password,
          name: name,
          );
          print("User registered :${response.$id}");
    }catch(e){
      print("error:${e}");
    }
  }
  Future <void>loginUser(String email,String password)async{
    try{
      final session=await account.createEmailPasswordSession(
        email: email,
         password: password
         );
         print("User logged in:${session.userId}");
    }on AppwriteException catch(e){
      if(e.code==401){
        print("Error:Incorrect email or password");
        throw Exception("Incorrect email or password");
      }else{
        print('Error:${e.message}');
        throw Exception(e.message);
      }
    }catch(e){
      print('Unexpected error:$e');
      throw Exception('An unexpected error occured');
    }
  }
  Future<void>logoutUser()async{
    try{
      await account.deleteSession(sessionId: 'current');
      print('User logged out');
    }catch(e){
      print('Error:${e}');
    }
  }
}