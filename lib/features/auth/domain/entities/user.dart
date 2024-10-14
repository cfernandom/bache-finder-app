class User {
  final int id;
  final String email;
  final String name;
  final List<String>? roles;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.roles,
  });
  bool isSuperAdmin () =>
    roles?.contains('super_admin') ?? false;
  
  bool isAdmin() =>
    roles?.contains('admin') ?? false;
  
  bool isInstitution() =>
    roles?.contains('institucion') ?? false;
  
  bool canDeletePothole() =>
    isAdmin() || isInstitution() || isSuperAdmin();
}
