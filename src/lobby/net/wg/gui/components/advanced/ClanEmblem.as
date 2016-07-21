package net.wg.gui.components.advanced {
import net.wg.gui.components.controls.UILoaderAlt;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.core.UIComponent;

public class ClanEmblem extends UIComponent {

    public var loader:UILoaderAlt = null;

    private var _iconWidth:int;

    private var _iconHeight:int;

    public function ClanEmblem() {
        super();
    }

    override protected function onDispose():void {
        if (this.loader) {
            this.loader.dispose();
            this.loader = null;
        }
        super.onDispose();
    }

    public function setImage(param1:String):void {
        var _loc2_:* = !StringUtils.isEmpty(param1);
        this.loader.visible = _loc2_;
        if (_loc2_) {
            this.loader.source = "img://" + param1;
        }
    }

    public function get iconWidth():int {
        return this._iconWidth;
    }

    public function set iconWidth(param1:int):void {
        this._iconWidth = param1;
        this.width = param1;
    }

    public function get iconHeight():int {
        return this._iconHeight;
    }

    public function set iconHeight(param1:int):void {
        this._iconHeight = param1;
        this.height = param1;
    }
}
}
