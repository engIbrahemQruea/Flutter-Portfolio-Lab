enum EnUsersFilterOption {
  none('None'),
  userID('User ID'),
  personID('Person ID'),
  userName('User Name'),
  password('Password'),
  isActive('Is Active');

  final String label;
  const EnUsersFilterOption(this.label);
}

enum EnIsActiveOption {
  all('All'),
  yes('Yes'),
  no('No');

  final String label;

  const EnIsActiveOption(this.label);
}
