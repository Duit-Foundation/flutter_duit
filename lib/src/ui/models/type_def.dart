import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/ui/models/element_models.dart";

//Type helpers for better type assertion

typedef ConstrainedBoxModel = ConstrainedBoxUIElement<ConstrainedBoxAttributes>;
typedef BackdropFilterModel = BackdropFilterUIElement<BackdropFilterAttributes>;
typedef AnimatedOpacityModel
    = AnimatedOpacityUIElement<AnimatedOpacityAttributes>;
typedef RemoteWidgetModel = RemoteUIElement<RemoteSubtreeAttributes>;
typedef GridViewModel = GridViewUIElement<GridViewAttributes>;
typedef CardModel = CardUIElement<CardAttributes>;
typedef AppBarModel = AppBarUiElement<AppBarAttributes>;
