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

enum IsActiveOption {
  all('All'),
  yes('Yes'),
  no('No');

  final String label;

  const IsActiveOption(this.label);
}
