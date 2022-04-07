class AbilityModel {
  String action;
  String subject;

  AbilityModel(this.action, this.subject);

  Map<String, String> toJson() => {
        'action': action,
        'subject': subject,
      };

  factory AbilityModel.fromJson(Map<String, dynamic> json) {
    final String action = json['action'];
    final String subject = json['subject'];
    return AbilityModel(action, subject);
  }
}
