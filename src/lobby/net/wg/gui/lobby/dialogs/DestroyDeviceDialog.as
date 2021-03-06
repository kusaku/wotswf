package net.wg.gui.lobby.dialogs {
public class DestroyDeviceDialog extends IconDialog {

    public static const ALLOWED_AREA_HEIGHT:uint = 80;

    public function DestroyDeviceDialog() {
        super();
    }

    override protected function applyLayout():void {
        super.applyLayout();
        textField.y = (ALLOWED_AREA_HEIGHT - textField.height) / 2;
    }

    override protected function getTextAreaCurrentHeight():Number {
        return textField.textHeight + ADDITIONAL_MULTI_LINE_PADDING;
    }
}
}
