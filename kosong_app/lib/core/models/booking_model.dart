class Booking {
  final String id;
  final String customerId;
  final String placeId;
  final String placeName;
  final String ownerId;
  final String title;
  final String date;
  final String startTime;
  final String endTime;
  final int participantCount;
  String status; // 'upcoming', 'completed', 'cancelled'
  ChangeRequest? changeRequest;
  final DateTime createdAt;
  DateTime updatedAt;
  final String image;

  Booking({
    required this.id,
    required this.customerId,
    required this.placeId,
    required this.placeName,
    required this.ownerId,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.participantCount,
    required this.status,
    this.changeRequest,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
  });
}

class ChangeRequest {
  final String id;
  final String bookingId;
  final String oldDate;
  final String oldStartTime;
  final String oldEndTime;
  final String newDate;
  final String newStartTime;
  final String newEndTime;
  final String? reason;
  String status; // 'pending', 'approved', 'rejected'
  String? ownerResponse;
  final DateTime createdAt;
  DateTime? respondedAt;

  ChangeRequest({
    required this.id,
    required this.bookingId,
    required this.oldDate,
    required this.oldStartTime,
    required this.oldEndTime,
    required this.newDate,
    required this.newStartTime,
    required this.newEndTime,
    this.reason,
    required this.status,
    this.ownerResponse,
    required this.createdAt,
    this.respondedAt,
  });
}
