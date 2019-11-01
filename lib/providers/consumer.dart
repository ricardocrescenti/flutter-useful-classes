import 'package:flutter/material.dart';

/// Generic class to provide values for consumers
abstract class Consumer<T extends ChangeNotifier, V> extends StatefulWidget {
  /// Value provider reference
  final T provider;

  /// Funtion to build the user interface represented by this consumer.
  final Widget Function(BuildContext context, V value) builder;
  
  Consumer({Key key, @required this.provider, @required this.builder}) : super(key: key);

  /// Get provider reference
  T getProvider(BuildContext context, ConsumerState consumer) {
    return provider;
  }

  /// Get value from value provider
  V getValue(BuildContext context, ConsumerState consumer);

  @override
  ConsumerState createState() => ConsumerState<T, V>();
}

/// Class to maintain `Consumer` state
class ConsumerState<T extends ChangeNotifier, V> extends State<Consumer<T, V>> {
  T _provider;
  T get provider => _provider;

  V _value;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_provider == null) {
      _initConsumer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _value);
  }

  @override
  void dispose() {
    widget.provider.removeListener(_listener);
    super.dispose();
  }

  _initConsumer() {
    _provider = widget.getProvider(context, this);
    _value = widget.getValue(context, this);
    _provider.addListener(_listener);
  }

  _listener() {
    setState(() {
      _value = widget.getValue(context, this);
    });
  }
}