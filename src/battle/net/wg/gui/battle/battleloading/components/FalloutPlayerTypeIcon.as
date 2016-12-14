package net.wg.gui.battle.battleloading.components {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.gui.battle.battleloading.renderers.MultiTeamRenderer;
import net.wg.gui.battle.battleloading.vo.MultiTeamIconInfoVO;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.core.UIComponent;

public class FalloutPlayerTypeIcon extends UIComponent {

    public static const SQUAD_TYPE_FRAME_LBL:String = "squad";

    public static const SOLO_TYPE_FRAME_LBL:String = "solo";

    private static const OTHER_ICON_FRAME_LBL:String = "other";

    private static const FRAME_IDX_SCHEME_NAME:String = "falloutLoadingIcon";

    private static const COLOR_GOLD_SCHEME_NAME:String = "falloutSelfGold";

    public var icon:MovieClip;

    public var separator:MovieClip;

    public var pointsTF:TextField;

    private var _data:MultiTeamIconInfoVO;

    public function FalloutPlayerTypeIcon() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        stop();
        this.icon.stop();
    }

    override protected function draw():void {
        var _loc1_:String = null;
        var _loc2_:String = null;
        super.draw();
        if (isInvalid(InvalidationType.DATA) && this._data != null) {
            _loc1_ = !!this._data.isSquad ? SQUAD_TYPE_FRAME_LBL : SOLO_TYPE_FRAME_LBL;
            gotoAndStop(_loc1_);
            if (this._data.isSelf) {
                _loc2_ = App.colorSchemeMgr.getAliasColor(FRAME_IDX_SCHEME_NAME);
            }
            else {
                _loc2_ = OTHER_ICON_FRAME_LBL;
            }
            this.icon.gotoAndStop(_loc2_);
            if (this._data.isSquad) {
                this.icon.tf.text = this._data.label;
            }
            this.pointsTF.text = this._data.points.toString();
            this.pointsTF.textColor = App.colorSchemeMgr.getScheme(COLOR_GOLD_SCHEME_NAME).rgb;
            this.icon.y = MultiTeamRenderer.DEFAULT_RENDERER_HEIGHT * this._data.countItems >> 1;
            this.pointsTF.y = MultiTeamRenderer.DEFAULT_RENDERER_HEIGHT * this._data.countItems - this.pointsTF.height >> 1;
            this.separator.visible = this._data.isWithSeparator;
        }
    }

    override protected function onDispose():void {
        this._data = null;
        this.icon = null;
        this.separator = null;
        this.pointsTF = null;
        super.onDispose();
    }

    public function get data():MultiTeamIconInfoVO {
        return this._data;
    }

    public function set data(param1:MultiTeamIconInfoVO):void {
        this._data = param1;
        invalidateData();
    }
}
}
