class RegisterModel {
  final String email;
  final String password;
  final String firstname;
  final String lastname;
  final String tipoDocumento;
  final String dni;
  final String telefono;
  final String username;

  // Constructor
  RegisterModel({
    required this.email,
    required this.password,
    required this.firstname,
    required this.lastname,
    required this.tipoDocumento,
    required this.dni,
    required this.telefono,
    required this.username,
  });

  // Convierte un objeto RegisterModel a un mapa JSON para enviarlo al backend
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'firstname': firstname,
      'lastname': lastname,
      'tipoDocumento': tipoDocumento,
      'dni': dni,
      'telefono': telefono,
      'username': username,
    };
  }

  // Convierte un mapa JSON a un objeto RegisterModel
  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      email: json['email'],
      password: json['password'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      tipoDocumento: json['tipoDocumento'],
      dni: json['dni'],
      telefono: json['telefono'],
      username: json['username'],
    );
  }
}
