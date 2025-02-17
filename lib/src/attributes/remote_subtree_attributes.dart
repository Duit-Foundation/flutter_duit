import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class RemoteSubtreeAttributes
    implements DuitAttributes<RemoteSubtreeAttributes> {
  final Map<String, dynamic>? data;
  final String downloadPath;
  final Map<String, dynamic>? meta;
  final Iterable<ActionDependency> dependencies;

  RemoteSubtreeAttributes({
    required this.downloadPath,
    required this.dependencies,
    this.data,
    this.meta,
  });

  factory RemoteSubtreeAttributes.fromJson(JSONObject json) {
    Iterable<ActionDependency> deps;
    final hasProperty = json.containsKey("dependsOn");
    if (hasProperty &&
        json["dependsOn"] is List &&
        json["dependsOn"].isNotEmpty) {
      deps = (json["dependsOn"] as List).map(
        (el) => ActionDependency.fromJson(el),
      );
    } else {
      deps = const [];
    }

    return RemoteSubtreeAttributes(
      downloadPath: json["downloadPath"],
      data: json,
      meta: json["meta"],
      dependencies: deps,
    );
  }

  @override
  RemoteSubtreeAttributes copyWith(RemoteSubtreeAttributes other) {
    return RemoteSubtreeAttributes(
      data: other.data ?? data,
      downloadPath: downloadPath, //copying is prohibited
      meta: meta, //copying is prohibited
      dependencies: dependencies, //copying is prohibited
    );
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) {
    throw UnimplementedError("$methodName is not implemented");
  }
}
