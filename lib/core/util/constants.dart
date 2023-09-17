import 'package:final_project/features/category/models/category.dart';
import 'package:final_project/features/status/models/status.dart';

const String imageUrl = "https://palmail.gsgtt.tech/storage/";
List<Category> defaultCategories = [
  Category(
    id: 1,
    name: 'Other',
    createdAt: '2023-08-24T12:10:41.000000Z',
  ),
  Category(
    id: 2,
    name: 'Official Organizations',
    createdAt: '2023-08-24T12:10:41.000000Z',
  ),
  Category(
    id: 3,
    name: 'NGOs',
    createdAt: '2023-08-24T12:10:41.000000Z',
  ),
  Category(
    id: 4,
    name: 'Foreign',
    createdAt: '2023-08-24T12:10:41.000000Z',
  ),
];

List<Status> defaultStatues = [
  Status(
    id: 1,
    color: "0xfffa3a57",
    name: "Inbox",
  ),
  Status(
    id: 2,
    color: "0xffffe120",
    name: "Pending",
  ),
  Status(
    id: 3,
    color: "0xff6589ff",
    name: "In Progress",
  ),
  Status(
    id: 4,
    color: "0xff77d16f",
    name: "Completed",
  ),
];
