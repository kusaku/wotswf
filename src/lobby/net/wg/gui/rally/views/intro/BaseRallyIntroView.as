package net.wg.gui.rally.views.intro {
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.infrastructure.base.meta.IBaseRallyIntroViewMeta;
import net.wg.infrastructure.base.meta.impl.BaseRallyIntroViewMeta;

import scaleform.clik.events.ButtonEvent;

public class BaseRallyIntroView extends BaseRallyIntroViewMeta implements IBaseRallyIntroViewMeta {

    public var listRoomBtn:SoundButtonEx;

    public var listRoomTitleLbl:TextField;

    public var listRoomDescrLbl:TextField;

    public function BaseRallyIntroView() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.listRoomBtn.addEventListener(ButtonEvent.CLICK, this.onListRoomBtnClick);
        this.listRoomBtn.addEventListener(MouseEvent.ROLL_OVER, onControlRollOver);
        this.listRoomBtn.addEventListener(MouseEvent.ROLL_OUT, onControlRollOut);
    }

    override protected function onDispose():void {
        if (this.listRoomBtn) {
            this.listRoomBtn.removeEventListener(ButtonEvent.CLICK, this.onListRoomBtnClick);
            this.listRoomBtn.removeEventListener(MouseEvent.ROLL_OVER, onControlRollOver);
            this.listRoomBtn.removeEventListener(MouseEvent.ROLL_OUT, onControlRollOut);
            this.listRoomBtn.dispose();
            this.listRoomBtn = null;
        }
        this.listRoomTitleLbl = null;
        this.listRoomDescrLbl = null;
        super.onDispose();
    }

    private function onListRoomBtnClick(param1:ButtonEvent):void {
        this.showListRoom(param1);
    }

    protected function showListRoom(param1:ButtonEvent):void {
    }
}
}