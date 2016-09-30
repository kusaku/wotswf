package net.wg.gui.lobby.vehicleBuyWindow {
import flash.text.TextField;

import net.wg.gui.components.controls.IconText;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.infrastructure.base.UIComponentEx;

public class FooterMc extends UIComponentEx {

    private static const WARNING_FRAME_LBL:String = "warning";

    public var submitBtn:SoundButtonEx = null;

    public var cancelBtn:SoundButtonEx = null;

    public var expandBtn:ExpandButton = null;

    public var totalCreditsPrice:IconText = null;

    public var totalGoldPrice:IconText = null;

    public var warningMsg:TextField = null;

    public function FooterMc() {
        super();
        stop();
    }

    override protected function configUI():void {
        super.configUI();
        this.expandBtn.buttonMode = true;
    }

    override protected function onDispose():void {
        this.submitBtn.dispose();
        this.cancelBtn.dispose();
        this.expandBtn.dispose();
        this.totalCreditsPrice.dispose();
        this.totalGoldPrice.dispose();
        this.submitBtn = null;
        this.cancelBtn = null;
        this.expandBtn = null;
        this.totalCreditsPrice = null;
        this.totalGoldPrice = null;
        this.warningMsg = null;
        super.onDispose();
    }

    public function showWarning(param1:String):void {
        gotoAndStop(WARNING_FRAME_LBL);
        this.warningMsg.text = param1;
        _originalHeight = _originalHeight + VehicleBuyWindow.WARNING_HEIGHT;
        setActualSize(width, height + VehicleBuyWindow.WARNING_HEIGHT);
        setActualScale(1, 1);
    }
}
}
