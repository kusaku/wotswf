package net.wg.gui.lobby.battleloading.components {
import net.wg.data.constants.Linkages;
import net.wg.gui.lobby.battleloading.MultiTeamRenderer;
import net.wg.gui.lobby.battleloading.vo.MultiTeamIconInfoVO;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.core.UIComponent;

public class MultiTeamIcons extends UIComponent {

    private var _rendererHeight:int;

    private var _items:Vector.<FalloutPlayerTypeIcon>;

    private var _data:Vector.<MultiTeamIconInfoVO>;

    public function MultiTeamIcons() {
        this._rendererHeight = MultiTeamRenderer.DEFAULT_RENDERER_HEIGHT;
        super();
        this._data = new Vector.<MultiTeamIconInfoVO>();
        this._items = new Vector.<FalloutPlayerTypeIcon>();
    }

    override protected function configUI():void {
        super.configUI();
    }

    override protected function onDispose():void {
        this.cleanRenderers();
        this._data = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        var _loc5_:FalloutPlayerTypeIcon = null;
        super.draw();
        var _loc1_:Boolean = isInvalid(InvalidationType.DATA);
        if (_loc1_ && this._data != null) {
            _loc2_ = this._data.length;
            _loc3_ = this._items.length;
            _loc4_ = 0;
            while (_loc4_ < _loc2_) {
                if (_loc4_ < _loc3_) {
                    _loc5_ = this._items[_loc4_];
                }
                else {
                    _loc5_ = App.utils.classFactory.getComponent(Linkages.FALLOUT_PLAYER_TYPE_ICON, FalloutPlayerTypeIcon);
                    this._items.push(_loc5_);
                    addChild(_loc5_);
                }
                _loc5_.data = this._data[_loc4_];
                _loc5_.validateNow();
                _loc4_++;
            }
        }
        if ((isInvalid(InvalidationType.SIZE) || _loc1_) && this._data != null) {
            this.sort();
        }
    }

    public function setData(param1:Vector.<MultiTeamIconInfoVO>):void {
        this._data = param1;
        invalidateData();
    }

    private function cleanRenderers():void {
        var _loc1_:int = this._items.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            this._items[_loc2_].dispose();
            _loc2_++;
        }
        this._items.splice(0, this._items.length);
        this._items = null;
    }

    private function sort():void {
        var _loc4_:FalloutPlayerTypeIcon = null;
        var _loc5_:MultiTeamIconInfoVO = null;
        var _loc1_:int = this._items.length;
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        while (_loc3_ < _loc1_) {
            _loc4_ = this._items[_loc3_];
            _loc4_.y = _loc2_;
            _loc5_ = _loc4_.data;
            if (_loc5_.isSquad) {
                _loc2_ = _loc2_ + this._rendererHeight * _loc5_.countItems;
            }
            else {
                _loc2_ = _loc2_ + this._rendererHeight;
            }
            _loc3_++;
        }
    }
}
}
