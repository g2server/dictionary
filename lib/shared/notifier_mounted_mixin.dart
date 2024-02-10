mixin NotifierMounted {
  bool _mounted = true;

  void setUnmounted() {
    _mounted = false;
  }

  bool get mounted {
    return _mounted;
  }
}
