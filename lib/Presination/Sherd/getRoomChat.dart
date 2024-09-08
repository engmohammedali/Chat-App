getRoomCgat({required String user1,required String user2}) {
  if (user1.compareTo(user2) > 0) {
    return "$user2\_$user1";
  }else{
    return  "$user1\_$user2";
  }
}
