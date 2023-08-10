class ThingsProperty {
  final String createdAt;
  final String href;
  final String id;
  final Object lastValue;
  final bool linkedToTrigger;
  final String name;
  final String permission;
  final bool persist;
  final int tag;
  final String thingId;
  final String thingName;
  final String type;
  final int updateParameter;
  final String updateStrategy;
  final String updatedAt;
  //final String valueUpdatedAt;
  final String variableName;

  ThingsProperty({
    required this.createdAt,
    required this.href,
    required this.id,
    required this.lastValue,
    required this.linkedToTrigger,
    required this.name,
    required this.permission,
    required this.persist,
    required this.tag,
    required this.thingId,
    required this.thingName,
    required this.type,
    required this.updateParameter,
    required this.updateStrategy,
    required this.updatedAt,
    //required this.valueUpdatedAt,
    required this.variableName,
  });

  factory ThingsProperty.fromJson(Map<String, dynamic> json) {
    return ThingsProperty(
      createdAt: json['created_at'],
      href: json['href'],
      id: json['id'],
      lastValue: json['last_value'],
      linkedToTrigger: json['linked_to_trigger'],
      name: json['name'],
      permission: json['permission'],
      persist: json['persist'],
      tag: json['tag'],
      thingId: json['thing_id'],
      thingName: json['thing_name'],
      type: json['type'],
      updateParameter: json['update_parameter'],
      updateStrategy: json['update_strategy'],
      updatedAt: json['updated_at'],
      //valueUpdatedAt: json['value_updated_at'],
      variableName: json['variable_name'],
    );
  }
}