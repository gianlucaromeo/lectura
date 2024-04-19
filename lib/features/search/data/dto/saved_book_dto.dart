class SavedBookDto {
  const SavedBookDto({
    required this.id,
    required this.status,
  });

  final String id;
  final String status;

  SavedBookDto.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        status = json["status"];
}
