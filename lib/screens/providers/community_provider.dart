import 'package:flutter/material.dart';
import 'package:vibe_app/screens/api_services/base.dart';
import 'package:vibe_app/screens/api_services/groups_comunity.dart';
import 'package:vibe_app/screens/models/community.dart';
import 'package:vibe_app/screens/providers/status.dart';

class CommunitProvider extends ChangeNotifier {
  GroupCommunityServices communityServices = GroupCommunityServices();

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

  List<CommunityModel> _communities = [];
  List<CommunityModel> get comminities => _communities;
  setCommunities(List<CommunityModel> communities) {
    _communities.addAll(communities);
    notifyListeners();
  }

  fetchNextCommunities() async {
    if (next != null) {
      fetchCommunities(url: next);
    }
  }

  fetchPreviousCommunities() async {
    if (previous != null) {
      fetchCommunities(url: previous);
    }
  }

  fetchCommunities({String? url}) async {
    await Future.delayed(const Duration(seconds: 0));
    setState(EnumProviderState.loading);

    try {
      List<CommunityModel> communities;
      ApiClientListResult<CommunityModel> communityResults =
          await communityServices.getCommunities(
        url: url,
      );
      communities = communityResults.result;
      await Future.delayed(const Duration(seconds: 0));
      setCommunities(communities);
      count = communityResults.count;
      next = communityResults.next;
      previous = communityResults.previous;
      _failure = null;
    } on NetworkFailure catch (e) {
      setFailure(e);
      setState(EnumProviderState.loaded);
    }
    setState(EnumProviderState.loaded);
  }

  clearAndFetchNewCommunities() async {
    _communities = [];
    await fetchCommunities();
  }

  fetchNewCommunities() async {
    _communities = [];
    await fetchCommunities();
  }

  fetchData() async {
    await fetchCommunities();
  }
}
