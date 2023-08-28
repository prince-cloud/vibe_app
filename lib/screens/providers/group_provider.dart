import 'package:flutter/material.dart';
import 'package:vibe_app/screens/api_services/base.dart';
import 'package:vibe_app/screens/api_services/groups_comunity.dart';
import 'package:vibe_app/screens/models/groups.dart';
import 'package:vibe_app/screens/providers/status.dart';

class GroupProvider extends ChangeNotifier {
  GroupCommunityServices groupServices = GroupCommunityServices();

  EnumProviderState _state = EnumProviderState.initial;
  EnumProviderState get state => _state;
  setState(EnumProviderState state) {
    _state = state;
    notifyListeners();
  }

  int? count;
  String? previous, next;

  NetworkFailure? _failure;
  NetworkFailure? get failure => _failure;
  setFailure(NetworkFailure failure) {
    _failure = failure;
    notifyListeners();
  }

  List<GroupModel> _groups = [];
  List<GroupModel> get groups => _groups;
  setGroups(List<GroupModel> groups) {
    _groups.addAll(groups);
    notifyListeners();
  }

  fetchNextGroups() async {
    if (next != null) {
      fetchGroups(url: next);
    }
  }

  fetchPreviousGroups() async {
    if (previous != null) {
      fetchGroups(url: previous);
    }
  }

  fetchGroups({String? url}) async {
    await Future.delayed(const Duration(seconds: 0));
    setState(EnumProviderState.loading);

    try {
      List<GroupModel> groups;
      ApiClientListResult<GroupModel> groupResutls =
          await groupServices.getGroups(
        url: url,
      );
      groups = groupResutls.result;
      await Future.delayed(const Duration(seconds: 0));
      setGroups(groups);
      count = groupResutls.count;
      next = groupResutls.next;
      previous = groupResutls.previous;
      _failure = null;
    } on NetworkFailure catch (e) {
      setFailure(e);
      setState(EnumProviderState.loaded);
    }
    setState(EnumProviderState.loaded);
  }

  clearAndFetchNewGroup() async {
    _groups = [];
    await fetchGroups();
  }

  fetchNewGroups() async {
    _groups = [];
    await fetchGroups();
  }

  fetchData() async {
    await fetchGroups();
  }
}
