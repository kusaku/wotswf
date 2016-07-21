package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractView;

public class HangarMeta extends AbstractView {

    public var onEscape:Function;

    public var showHelpLayout:Function;

    public var closeHelpLayout:Function;

    public var toggleGUIEditor:Function;

    public function HangarMeta() {
        super();
    }

    public function onEscapeS():void {
        App.utils.asserter.assertNotNull(this.onEscape, "onEscape" + Errors.CANT_NULL);
        this.onEscape();
    }

    public function showHelpLayoutS():void {
        App.utils.asserter.assertNotNull(this.showHelpLayout, "showHelpLayout" + Errors.CANT_NULL);
        this.showHelpLayout();
    }

    public function closeHelpLayoutS():void {
        App.utils.asserter.assertNotNull(this.closeHelpLayout, "closeHelpLayout" + Errors.CANT_NULL);
        this.closeHelpLayout();
    }

    public function toggleGUIEditorS():void {
        App.utils.asserter.assertNotNull(this.toggleGUIEditor, "toggleGUIEditor" + Errors.CANT_NULL);
        this.toggleGUIEditor();
    }
}
}
