import 'package:flutter/material.dart';
import 'package:vibe_app/screens/api_services/base.dart';
import 'package:vibe_app/screens/api_services/post_services.dart';
import 'package:vibe_app/screens/models/post.dart';
import 'package:vibe_app/screens/providers/status.dart';

class PostProvider extends ChangeNotifier {
  PostServices postServices = PostServices();

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

  List<PostModel> _posts = [];
  List<PostModel> get posts => _posts;
  setPosts(List<PostModel> posts) {
    _posts.addAll(posts);
    notifyListeners();
  }

  fetchNextPosts() async {
    if (next != null) {
      fetchPosts(url: next);
    }
  }

  fetchPreviousPosts() async {
    if (previous != null) {
      fetchPosts(url: previous);
    }
  }

  fetchPosts({String? url}) async {
    await Future.delayed(const Duration(seconds: 0));
    setState(EnumProviderState.loading);

    try {
      List<PostModel> posts;
      ApiClientListResult<PostModel> postResults = await postServices.getPosts(
        url: url,
      );
      posts = postResults.result;
      await Future.delayed(const Duration(seconds: 0));
      setPosts(posts);
      count = postResults.count;
      next = postResults.next;
      previous = postResults.previous;
      _failure = null;
    } on NetworkFailure catch (e) {
      setFailure(e);
      setState(EnumProviderState.loaded);
    }
    setState(EnumProviderState.loaded);
  }

  clearAndFetchNewPost() async {
    _posts = [];
    await fetchPosts();
  }

  fetchNewPosts() async {
    _posts = [];
    await fetchPosts();
  }

  fetchData() async {
    await fetchPosts();
  }
}
