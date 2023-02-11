class EventModel {
  String? who_play;
  String? event_create_user;
  String? genre;
  String? when_is_it;
  String? when_door_open;
  String? phone;
  String? how_much_ticket;
  String? available_ticket;
  String? event_caption;
  String? instagram_link;
  String? spotfy_link;
  String? banner_pic;
  String? concert_pic;
  String? event_publish;
  String? event_title;
  String? street_address;
  String? state_address;
  String? city_address;
  String? zip_code;
  String? link_to_buy_ticket;
  String? longitude;
  String? latitude;
  String? uid;
  String? will_be_there;
  String? ticket_sold;
  Map<String, dynamic>? participants;

  EventModel(
      {
        this.event_title,
        this.event_create_user,
        this.will_be_there,
        this.ticket_sold,
        this.uid,
        this.longitude,
        this.latitude,
        this.link_to_buy_ticket,
        this.zip_code,
        this.city_address,
        this.state_address,
        this.street_address,
        this.who_play,
        this.genre,
        this.when_door_open,
        this.when_is_it,
        this.phone,
        this.how_much_ticket,
        this.available_ticket,
        this.event_caption,
        this.instagram_link,
        this.spotfy_link,
        this.banner_pic,
        this.concert_pic,
        this.event_publish,
        this.participants,
      });

  factory EventModel.fromMap(map) {
    return EventModel(
      participants : map['participants'],
      when_door_open: map["when_door_open"],
      event_create_user: map["event_create_user"],
      will_be_there: map["will_be_there"],
      ticket_sold: map["ticket_sold"],
      uid: map["uid"],
      longitude: map["longitude"],
      latitude: map["latitude"],
      link_to_buy_ticket: map["link_to_buy_ticket"],
      zip_code: map["zip_code"],
      city_address: map["city_address"],
      state_address: map["state_address"],
      street_address: map["street_address"],
      event_title: map["event_title"],
      who_play: map["who_play"],
      genre: map["genre"],
      when_is_it: map["when_is_it"],
      phone: map["phone"],
      how_much_ticket: map["how_much_ticket"],
      available_ticket: map["available_ticket"],
      event_caption: map["event_caption"],
      instagram_link: map["instagram_link"],
      spotfy_link: map["spotfy_link"],
      banner_pic: map["banner_pic"],
      concert_pic: map["concert_pic"],
      event_publish: map["event_publish"],

    );
  }

  Map<String, dynamic> toMap() {
    return {
      "participants": participants,
      "event_title": event_title,
      "event_create_user": event_create_user,
      "ticket_sold": ticket_sold,
      "uid": uid,
      "will_be_there": will_be_there,
      "latitude": latitude,
      "longitude": longitude,
      "link_to_buy_ticket": link_to_buy_ticket,
      "zip_code": zip_code,
      "city_address": city_address,
      "state_address": state_address,
      "street_address": street_address,
      "when_door_open": when_door_open,
      "who_play": who_play,
      "genre": genre,
      "when_is_it": when_is_it,
      "phone": phone,
      "how_much_ticket": how_much_ticket,
      "available_ticket": available_ticket,
      "event_caption": event_caption,
      "instagram_link": instagram_link,
      "spotfy_link": spotfy_link,
      "banner_pic": banner_pic,
      "concert_pic": concert_pic,
      "event_publish": event_publish,

    };
  }
}
