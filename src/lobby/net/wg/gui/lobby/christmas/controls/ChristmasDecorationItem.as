package net.wg.gui.lobby.christmas.controls {
import net.wg.gui.components.controls.Image;
import net.wg.gui.lobby.christmas.data.BaseDecorationVO;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.entity.IUpdatable;

import scaleform.clik.constants.InvalidationType;

public class ChristmasDecorationItem extends UIComponentEx implements IUpdatable {

    public var rankIcon:Image;

    public var icon:Image;

    private var _data:BaseDecorationVO;

    public function ChristmasDecorationItem() {
        super();
        this.rankIcon.mouseEnabled = false;
        this.icon.mouseEnabled = false;
        this.rankIcon.mouseChildren = false;
        this.icon.mouseChildren = false;
    }

    override protected function onDispose():void {
        this.rankIcon.dispose();
        this.rankIcon = null;
        this.icon.dispose();
        this.icon = null;
        this._data = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:* = false;
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            _loc1_ = this._data != null;
            this.rankIcon.visible = this.icon.visible = _loc1_;
            if (_loc1_) {
                this.updateIcons(this._data);
            }
        }
    }

    public function update(param1:Object):void {
        if (this._data != param1) {
            this._data = BaseDecorationVO(param1);
            invalidateData();
        }
    }

    protected function updateIcons(param1:BaseDecorationVO):void {
        this.rankIcon.source = param1.rankIcon;
        this.icon.source = param1.icon;
    }
}
}
