abstract class ILoginRepository{
  Future<dynamic> login(String taxCode,String userName, String password);
}