class NotificationModel {
  final String id;
  final String? titulo;
  final String? descripcion;
  final String? fecha;

  NotificationModel({
    required this.id,
    this.titulo,
    this.descripcion,
    this.fecha,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      titulo: json['titulo'] ?? 'Notificación',
      descripcion: json['descripcion'] ?? '',
      fecha: json['fecha'] ?? '',
    );
  }
}
