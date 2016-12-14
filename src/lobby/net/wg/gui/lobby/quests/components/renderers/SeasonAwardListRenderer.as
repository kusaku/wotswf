package net.wg.gui.lobby.quests.components.renderers {
import flash.display.InteractiveObject;
import flash.text.TextField;

import net.wg.data.constants.Linkages;
import net.wg.gui.components.assets.data.SeparatorConstants;
import net.wg.gui.components.assets.interfaces.ISeparatorAsset;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.lobby.quests.components.IconTitleDescSeasonAward;
import net.wg.gui.lobby.quests.components.VehicleSeasonAward;
import net.wg.gui.lobby.quests.data.seasonAwards.SeasonAwardListRendererVO;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.core.UIComponent;
import scaleform.clik.data.ListData;

public class SeasonAwardListRenderer extends UIComponentEx implements ISeasonAwardListRenderer {

    public var titleTf:TextField;

    public var background:UILoaderAlt;

    public var basicAward:VehicleSeasonAward;

    public var extraAward:IconTitleDescSeasonAward;

    public var separator:ISeparatorAsset;

    private var _index:uint = 0;

    private var _data:SeasonAwardListRendererVO;

    public function SeasonAwardListRenderer() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.separator.setMode(SeparatorConstants.TILE_MODE);
        this.separator.setCenterAsset(Linkages.SEPARATOR_DOTTED_CENTER);
        this.separator.setSideAsset(Linkages.SEPARATOR_DOTTED_SMALL_SIDE);
    }

    override protected function onDispose():void {
        this.titleTf = null;
        this.background.dispose();
        this.background = null;
        this.basicAward.dispose();
        this.basicAward = null;
        this.extraAward.dispose();
        this.extraAward = null;
        this.separator.dispose();
        this.separator = null;
        this._data = null;
        super.onDispose();
    }

    public function getData():Object {
        return this._data;
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        return new <InteractiveObject>[this.basicAward.buttonAbout];
    }

    public function setData(param1:Object):void {
        this._data = SeasonAwardListRendererVO(param1);
        if (this._data != null) {
            this.titleTf.htmlText = this._data.title;
            App.utils.commons.updateTextFieldSize(this.titleTf, false, true);
            this.background.source = this._data.background;
            this.basicAward.setData(this._data.basicAward);
            this.extraAward.setData(this._data.extraAward);
        }
    }

    public function setListData(param1:ListData):void {
    }

    public function get index():uint {
        return this._index;
    }

    public function set index(param1:uint):void {
        this._index = param1;
    }

    public function get owner():UIComponent {
        return null;
    }

    public function set owner(param1:UIComponent):void {
    }

    public function get selectable():Boolean {
        return false;
    }

    public function set selectable(param1:Boolean):void {
    }

    public function get selected():Boolean {
        return false;
    }

    public function set selected(param1:Boolean):void {
    }
}
}
