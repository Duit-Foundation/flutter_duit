import "package:duit_kernel/duit_kernel.dart";

/// Builds a concrete component instance JSON by applying precomputed
/// write operations to the immutable base layout using JSON Patch.
final class ComponentBuilder {
  static Map<String, dynamic> build(
    ComponentDescription description,
    Map<String, dynamic> data, {
    bool ensureIntermediate = true,
  }) {
    final ops = <PatchOp>[];

    for (final t in description.writeOps) {
      final has = data.containsKey(t.sourceKey);
      final value = has ? data[t.sourceKey] : t.defaultValue;

      switch (t.semantics) {
        case PatchSemantics.replace:
          if (value != null) {
            ops.add(PatchOps.replace(path: t.path, value: value));
          } else {
            // Rm if null?
            // ops.add(PatchOps.remove(path: t.path));
          }
          break;
        case PatchSemantics.add:
          if (value != null) {
            ops.add(PatchOps.add(path: t.path, value: value));
          }
          break;
        case PatchSemantics.remove:
          ops.add(PatchOps.remove(path: t.path));
          break;
      }
    }

    return JsonPatchApplier.apply(
      description.data,
      ops,
      ensureIntermediate: ensureIntermediate,
    );
  }
}
