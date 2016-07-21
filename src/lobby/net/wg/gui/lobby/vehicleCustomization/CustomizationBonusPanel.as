package net.wg.gui.lobby.vehicleCustomization {
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.gui.components.controls.ScrollingListEx;
import net.wg.gui.lobby.vehicleCustomization.data.panels.CustomizationBonusPanelVO;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;

public class CustomizationBonusPanel extends UIComponentEx {

    private static const LIST_OFFSET:int = 1;

    public var bonusList:ScrollingListEx = null;

    public var bonusTitle:TextField = null;

    private var _data:CustomizationBonusPanelVO = null;

    public function CustomizationBonusPanel() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.bonusTitle.mouseEnabled = false;
        this.bonusTitle.autoSize = TextFieldAutoSize.RIGHT;
        this.bonusList.useHandCursor = false;
    }

    override protected function draw():void {
        var _loc1_:Array = null;
        var _loc2_:Number = NaN;
        var _loc3_:Number = NaN;
        var _loc4_:Number = NaN;
        super.draw();
        if (this._data != null && isInvalid(InvalidationType.DATA)) {
            _loc1_ = this._data.bonusRenderersList;
            _loc2_ = _loc1_.length * this.bonusList.rowHeight + this.bonusList._gap * _loc1_.length;
            this.bonusTitle.htmlText = this._data.bonusTitle;
            this.bonusList.height = _loc2_;
            this.bonusList.dataProvider = new DataProvider(_loc1_);
        }
        if (isInvalid(InvalidationType.SIZE)) {
            _loc3_ = 0;
            _loc4_ = 0;
            _loc3_ = width;
            _loc4_ = this.bonusList.height + this.bonusTitle.height + LIST_OFFSET * 2;
            _originalWidth = _loc3_;
            _originalHeight = _loc4_;
            setActualSize(_loc3_, _loc4_);
            setActualScale(1, 1);
        }
    }

    override protected function onDispose():void {
        this.bonusTitle = null;
        this.bonusList.dispose();
        this.bonusList = null;
        this._data = null;
        super.onDispose();
    }

    public function setData(param1:CustomizationBonusPanelVO):void {
        this._data = param1;
        invalidateData();
        invalidateSize();
        validateNow();
    }
}
}
