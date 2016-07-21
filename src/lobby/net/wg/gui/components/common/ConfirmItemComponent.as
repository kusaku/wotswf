package net.wg.gui.components.common {
import flash.display.DisplayObject;
import flash.text.TextField;

import net.wg.gui.components.controls.ActionPrice;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.IconText;
import net.wg.gui.components.controls.NumericStepper;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class ConfirmItemComponent extends UIComponentEx {

    private static const ITEM_ICON_LEFT:int = 12;

    private static const ITEM_ICON_TOP:int = 13;

    public var submitBtn:SoundButtonEx = null;

    public var cancelBtn:SoundButtonEx = null;

    public var leftResultIT:IconText = null;

    public var rightResultIT:IconText = null;

    public var countLabel:TextField = null;

    public var leftLabel:TextField = null;

    public var resultLabel:TextField = null;

    public var rightLabel:TextField = null;

    public var leftIT:IconText = null;

    public var rightIT:IconText = null;

    public var actionPrice:ActionPrice = null;

    public var nsCount:NumericStepper = null;

    public var description:TextField = null;

    public var moduleName:TextField = null;

    public var itemIcon:IDisposable = null;

    public var dropdownMenu:DropdownMenu = null;

    public function ConfirmItemComponent() {
        super();
    }

    public function setIcon(param1:DisplayObject):void {
        this.tryClearItemIcon();
        param1.x = ITEM_ICON_LEFT;
        param1.y = ITEM_ICON_TOP;
        this.itemIcon = IDisposable(param1);
        addChild(param1);
    }

    private function tryClearItemIcon():void {
        if (this.itemIcon != null) {
            this.itemIcon.dispose();
            this.itemIcon = null;
        }
    }

    override protected function onDispose():void {
        if (this.submitBtn != null) {
            this.submitBtn.dispose();
            this.submitBtn = null;
        }
        if (this.cancelBtn != null) {
            this.cancelBtn.dispose();
            this.cancelBtn = null;
        }
        if (this.leftResultIT != null) {
            this.leftResultIT.dispose();
            this.leftResultIT = null;
        }
        if (this.rightResultIT != null) {
            this.rightResultIT.dispose();
            this.rightResultIT = null;
        }
        if (this.actionPrice != null) {
            this.actionPrice.dispose();
            this.actionPrice = null;
        }
        if (this.nsCount != null) {
            this.nsCount.dispose();
            this.nsCount = null;
        }
        if (this.rightIT != null) {
            this.rightIT.dispose();
            this.rightIT = null;
        }
        if (this.leftIT != null) {
            this.leftIT.dispose();
            this.leftIT = null;
        }
        if (this.dropdownMenu != null) {
            this.dropdownMenu.dispose();
            this.dropdownMenu = null;
        }
        this.tryClearItemIcon();
        this.countLabel = null;
        this.leftLabel = null;
        this.resultLabel = null;
        this.rightLabel = null;
        this.description = null;
        this.moduleName = null;
        super.onDispose();
    }
}
}
