enum EnUserMenuAction {
  showDetails('Show Details'),
  add('Add New User'),
  edit('Edit User'),
  delete('Delete User'),
  changePassword('Change Password'),
  sendEmail('Send Email'),
  phoneCall('Phone Call');

  final String label;
  
  const EnUserMenuAction(this.label);
}
