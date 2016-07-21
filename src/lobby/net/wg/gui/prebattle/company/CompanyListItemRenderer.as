package net.wg.gui.prebattle.company {
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.gui.components.controls.SoundListItemRenderer;
import net.wg.gui.prebattle.company.events.CompanyEvent;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.infrastructure.interfaces.entity.IFocusContainer;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;

public class CompanyListItemRenderer extends SoundListItemRenderer implements IFocusContainer {

    public var descriptionField:TextField;

    public var pCountField:TextField;

    public var divisionField:TextField;

    public var dd:GroupPlayersDropDownMenu;

    public var bg:MovieClip;

    public var mainTextField:TextField;

    public var emtyFocusIndicator:MovieClip;

    private var _showPlayers:Boolean = false;

    private var _listRefreshData:Function;

    private var _pressEvent:MouseEvent;

    public function CompanyListItemRenderer() {
        super();
        tabEnabled = true;
        focusable = true;
    }

    override public function setData(param1:Object):void {
        if (param1 == null) {
            visible = false;
            return;
        }
        if (!visible) {
            visible = true;
        }
        super.setData(param1);
        this.dd.prbID = param1.prbID;
        if (this.isPlayersData()) {
            while (param1.players.length < 15) {
                param1.players.push({
                    "label": "",
                    "color": null
                });
            }
            this.dd.dataProvider = new DataProvider(param1.players);
        }
        var _loc2_:Boolean = this.dd.isOpen();
        if (this._showPlayers && this.isPlayersData() && selected && !_loc2_) {
            this.dd.open();
        }
        else if (_loc2_) {
            this.dd.close();
        }
        this.afterSetData();
        invalidate(InvalidationType.DATA);
    }

    override protected function onDispose():void {
        this.removeEventListener(ButtonEvent.CLICK, this.onClickHandler);
        if (this.dd) {
            this.dd.dispose();
        }
        if (this._listRefreshData != null) {
            this._listRefreshData = null;
        }
        super.onDispose();
    }

    override protected function configUI():void {
        focusIndicator = this.emtyFocusIndicator;
        toggle = true;
        allowDeselect = true;
        super.configUI();
        this.divisionField.autoSize = TextFieldAutoSize.RIGHT;
        this.addEventListener(ButtonEvent.CLICK, this.onClickHandler);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA) && data) {
            this.afterSetData();
        }
    }

    public function getComponentForFocus():InteractiveObject {
        return this;
    }

    public function refreshPopulateData(param1:Function):void {
        this._listRefreshData = param1;
    }

    public function showPlayersList(param1:Boolean):void {
        this._showPlayers = param1;
    }

    private function afterSetData():void {
        this.pCountField.text = data.playersCount;
        this.divisionField.text = data.division;
        CompanyHelper.instance.cutText(this.descriptionField, data.comment);
        App.utils.commons.formatPlayerName(this.mainTextField, App.utils.commons.getUserProps(data.creatorName, data.creatorClan, data.creatorRegion, data.creatorIgrType));
        this.updateTextFieldWidth();
    }

    private function dispatchIsSelectedItem(param1:Boolean):void {
        var _loc2_:CompanyEvent = new CompanyEvent(CompanyEvent.SELECTED_ITEM, true);
        _loc2_.isSelected = param1;
        _loc2_.prbID = data.prbID;
        dispatchEvent(_loc2_);
    }

    private function isPlayersData():Boolean {
        return data.hasOwnProperty("players") && data.players != null;
    }

    private function updateTextFieldWidth():void {
        var _loc1_:Number = 40;
        this.divisionField.x = Math.round(this.pCountField.x - this.divisionField.width - _loc1_);
    }

    override public function set selected(param1:Boolean):void {
        if (!param1 && this.dd.isOpen()) {
            this.dd.close();
        }
        super.selected = param1;
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
        super.handleMouseRollOver(param1);
        App.toolTipMgr.show(App.utils.commons.getFullPlayerName(App.utils.commons.getUserProps(data.creatorName, data.creatorClan, data.creatorRegion, data.creatorIgrType)));
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
        super.handleMouseRollOut(param1);
        App.toolTipMgr.hide();
    }

    override protected function handleMousePress(param1:MouseEvent):void {
        this._pressEvent = param1;
        callLogEvent(param1);
    }

    override protected function handleMouseRelease(param1:MouseEvent):void {
        if (this._pressEvent) {
            super.handleMousePress(this._pressEvent);
        }
        super.handleMouseRelease(param1);
    }

    private function onClickHandler(param1:ButtonEvent):void {
        if (param1.isKeyboard) {
            return;
        }
        dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS, this));
        this.dispatchIsSelectedItem(selected);
        if (this._showPlayers) {
            if (this.dd.isOpen()) {
                this.dd.close();
            }
            else if (selected) {
                this.dd.open();
            }
        }
    }
}
}
