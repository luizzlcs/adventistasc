import 'package:adventistasc/app/service/counter_service.dart';
import 'package:flutter/material.dart';

class CounterController with ChangeNotifier {
  CounterController(this.service);

  final CounterService service;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Map<ButtonType, Map<String, dynamic>> _counters = {};
  Map<ButtonType, Map<String, dynamic>> get counters => _counters;

  DateTime _pageAccessDate = DateTime.now();
  DateTime get pageAccessDate => _pageAccessDate;

  int _pageAccessCount = 0;

  int get pageAccessCount => _pageAccessCount;

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    _counters = await service.fetchAllCounters();
    final pageData = await service.fetchPageAccess();
    _pageAccessDate = pageData["date"];
    _pageAccessCount = pageData["count"];

    _isLoading = false;
    notifyListeners();
  }

  Future<void> incrementCounter(ButtonType type) async {
    _isLoading = true;
    notifyListeners();

    await service.incrementCounter(type);
    _counters = await service.fetchAllCounters();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> incrementPageAccess() async {
    _isLoading = true;
    notifyListeners();

    await service.incrementPageAccess();
    final pageData = await service.fetchPageAccess();
    _pageAccessDate = pageData["date"];
    _pageAccessCount = pageData["count"];

    _isLoading = false;
    notifyListeners();
  }
}
