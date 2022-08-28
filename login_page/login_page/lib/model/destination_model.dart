import '../model/activity_model.dart';

class Destination {
  String imageUrl;
  String city;
  String country;
  String description;
  List<Activity> activities;
  String route;

  Destination({
    this.imageUrl,
    this.city,
    this.country,
    this.description,
    this.activities,
    this.route
  });
}

List<Activity> activities = [
  Activity(
    imageUrl: 'images/brokenPipe.png',
    name: 'St. Mark\'s Basilica',
    type: 'Sightseeing Tour',
    startTimes: ['9:00 am', '11:00 am'],
    rating: 5,
    price: 30,
  ),
  Activity(
    imageUrl: 'images/brokenPipe.png',
    name: 'Walking Tour and Gonadola Ride',
    type: 'Sightseeing Tour',
    startTimes: ['11:00 pm', '1:00 pm'],
    rating: 4,
    price: 210,
  ),
  Activity(
    imageUrl: 'images/brokenPipe.png',
    name: 'Murano and Burano Tour',
    type: 'Sightseeing Tour',
    startTimes: ['12:30 pm', '2:00 pm'],
    rating: 3,
    price: 125,
  ),
];

List<Destination> destinations = [
  Destination(
    imageUrl: 'images/ac.png',
    city: 'AC Maintenance',
    country: 'Italy',
    description: 'Request a worker for all your air conditioning problems.',
    activities: activities,
    route: '/acMap',
  ),
  Destination(
    imageUrl: 'images/plum.png',
    city: 'Plumber',
    country: 'Jordan',
    description: 'Request a worker for all your plumbing problems.',
    activities: activities,
    route: '/plumberMap',
  ),
  Destination(
    imageUrl: 'images/elec.png',
    city: 'Electric',
    country: 'England',
    description: 'Request a worker for all your electrical problems.',
    activities: activities,
    route: '/elecMap',
  ),
  Destination(
    imageUrl: 'images/maint.png',
    city: 'General Maintenance',
    country: 'USA',
    description: 'Request a worker for your general maintanence problems.',
    activities: activities,
    route: '/generalMap',
  ),
  Destination(
    imageUrl: 'images/tile.png',
    city: 'Tiler',
    country: 'USA',
    description: 'Request a worker for all your tile problems.',
    activities: activities,
    route: '/tilerMap',
  ),
  Destination(
    imageUrl: 'images/satelliteIcon.png',
    city: 'Satellite',
    country: 'USA',
    description: 'Request a worker for all your satellite problems.',
    activities: activities,
    route: '/tilerMap',
  ),
  Destination(
    imageUrl: 'images/carpenterIcon.png',
    city: 'Carpenter',
    country: 'USA',
    description: 'Request a worker for all your wood furnature needs.',
    activities: activities,
    route: '/tilerMap',
  ),

];
