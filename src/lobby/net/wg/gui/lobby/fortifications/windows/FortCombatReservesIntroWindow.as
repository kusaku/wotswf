package net.wg.gui.lobby.fortifications.windows {
import flash.text.TextField;

import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.lobby.fortifications.cmp.combatReservesIntro.CombatReservesIntroItem;
import net.wg.gui.lobby.fortifications.data.CombatReservesIntroItemVO;
import net.wg.gui.lobby.fortifications.data.CombatReservesIntroVO;
import net.wg.infrastructure.base.meta.IFortCombatReservesIntroMeta;
import net.wg.infrastructure.base.meta.impl.FortCombatReservesIntroMeta;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;

public class FortCombatReservesIntroWindow extends FortCombatReservesIntroMeta implements IFortCombatReservesIntroMeta {

    public var title:TextField;

    public var description:TextField;

    public var info0:CombatReservesIntroItem;

    public var info1:CombatReservesIntroItem;

    public var closeBtn:SoundButtonEx;

    private var _items:Vector.<CombatReservesIntroItem>;

    private var _data:CombatReservesIntroVO;

    public function FortCombatReservesIntroWindow() {
        super();
        isModal = true;
        isCentered = true;
        canDrag = false;
        this._items = new <CombatReservesIntroItem>[this.info0, this.info1];
    }

    override protected function configUI():void {
        super.configUI();
        this.closeBtn.addEventListener(ButtonEvent.CLICK, this.onCloseBtnClickHandler);
    }

    override protected function onPopulate():void {
        super.onPopulate();
        window.useBottomBtns = true;
        setFocus(this.closeBtn);
    }

    override protected function onDispose():void {
        this.closeBtn.removeEventListener(ButtonEvent.CLICK, this.onCloseBtnClickHandler);
        this.closeBtn.dispose();
        this.closeBtn = null;
        this.info0.dispose();
        this.info0 = null;
        this.info1.dispose();
        this.info1 = null;
        this.title = null;
        this.description = null;
        this._items.splice(0, this._items.length);
        this._items = null;
        this._data = null;
        super.onDispose();
    }

    override protected function setData(param1:CombatReservesIntroVO):void {
        this._data = param1;
        invalidateData();
    }

    override protected function draw():void {
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        var _loc3_:CombatReservesIntroItemVO = null;
        var _loc4_:int = 0;
        super.draw();
        if (this._data && isInvalid(InvalidationType.DATA)) {
            window.title = this._data.windowTitle;
            this.title.text = this._data.title;
            this.description.text = this._data.description;
            this.closeBtn.label = this._data.buttonLabel;
            _loc1_ = this._items.length;
            _loc2_ = this._data.items.length;
            _loc4_ = 0;
            while (_loc4_ < _loc1_) {
                _loc3_ = _loc4_ < _loc2_ ? this._data.items[_loc4_] : null;
                this._items[_loc4_].update(_loc3_);
                _loc4_++;
            }
        }
    }

    private function onCloseBtnClickHandler(param1:ButtonEvent):void {
        onWindowCloseS();
    }
}
}
