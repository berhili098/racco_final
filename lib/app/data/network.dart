class Network {
  static headers({hasToken = false}) async {
    return {
      'Accept': 'application/json',

      // 'Content-Type': 'application/json',
    };
  }
}
