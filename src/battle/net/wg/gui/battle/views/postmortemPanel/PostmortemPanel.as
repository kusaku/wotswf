package net.wg.gui.battle.views.postmortemPanel {
import flash.text.TextField;

import net.wg.data.constants.BattleAtlasItem;
import net.wg.gui.battle.components.BattleAtlasSprite;
import net.wg.infrastructure.base.meta.IPostmortemPanelMeta;
import net.wg.infrastructure.base.meta.impl.PostmortemPanelMeta;

import scaleform.gfx.TextFieldEx;

public class PostmortemPanel extends PostmortemPanelMeta implements IPostmortemPanelMeta {

    private static const EMPTY_STR:String = "";

    private static const INVALID_PLAYER_INFO:uint = 1 << 7;

    private static const INVALID_VEHICLE_PANEL:uint = 1 << 8;

    private static const INVALID_PLAYER_INFO_POSITION:uint = 1 << 9;

    private static const INVALID_DEAD_REASON_VISIBILITY:uint = 1 << 10;

    private static const PLAYER_INFO_DELTA_Y:int = 250;

    public var bg:BattleAtlasSprite = null;

    public var observerModeTitleTF:TextField = null;

    public var observerModeDescTF:TextField = null;

    public var exitToHangarTitleTF:TextField = null;

    public var exitToHangarDescTF:TextField = null;

    public var playerInfoTF:TextField = null;

    public var deadReasonTF:TextField = null;

    public var vehiclePanel:VehiclePanel = null;

    private var _deadReason:String = "";

    private var _playerInfo:String = "";

    private var _showVehiclePanel:Boolean = true;

    private var _vehicleLevel:String = "";

    private var _vehicleImg:String = "";

    private var _vehicleType:String = "";

    private var _vehicleName:String = "";

    public function PostmortemPanel() {
        super();
        mouseChildren = false;
        mouseEnabled = false;
    }

    override protected function configUI():void {
        super.configUI();
        this.bg.imageName = BattleAtlasItem.POSTMORTEM_TIPS_BG;
        this.observerModeTitleTF.text = INGAME_GUI.POSTMORTEM_TIPS_OBSERVERMODE_LABEL;
        this.observerModeDescTF.text = INGAME_GUI.POSTMORTEM_TIPS_OBSERVERMODE_TEXT;
        this.exitToHangarTitleTF.text = INGAME_GUI.POSTMORTEM_TIPS_EXITHANGAR_LABEL;
        this.exitToHangarDescTF.text = INGAME_GUI.POSTMORTEM_TIPS_EXITHANGAR_TEXT;
        TextFieldEx.setVerticalAutoSize(this.deadReasonTF, TextFieldEx.VALIGN_BOTTOM);
        this.updatePlayerInfoPosition();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALID_DEAD_REASON_VISIBILITY)) {
            this.playerInfoTF.visible = false;
            this.deadReasonTF.visible = true;
            this.vehiclePanel.visible = this._showVehiclePanel;
        }
        if (isInvalid(INVALID_PLAYER_INFO)) {
            this.playerInfoTF.visible = true;
            this.deadReasonTF.visible = false;
            this.vehiclePanel.visible = false;
            if (this._playerInfo != this.playerInfoTF.htmlText) {
                this.playerInfoTF.htmlText = this._playerInfo;
            }
        }
        if (isInvalid(INVALID_VEHICLE_PANEL)) {
            this.playerInfoTF.visible = false;
            this.deadReasonTF.visible = true;
            if (this._deadReason != this.deadReasonTF.htmlText) {
                this.deadReasonTF.htmlText = this._deadReason;
            }
            this.vehiclePanel.visible = this._showVehiclePanel;
            if (this._showVehiclePanel) {
                this.vehiclePanel.setVehicleData(this._vehicleLevel, this._vehicleImg, this._vehicleType, this._vehicleName);
            }
        }
        if (isInvalid(INVALID_PLAYER_INFO_POSITION)) {
            this.updatePlayerInfoPosition();
        }
    }

    override protected function onDispose():void {
        this.bg = null;
        this.observerModeTitleTF = null;
        this.observerModeDescTF = null;
        this.exitToHangarTitleTF = null;
        this.exitToHangarDescTF = null;
        this.playerInfoTF = null;
        this.deadReasonTF = null;
        this.vehiclePanel.dispose();
        this.vehiclePanel = null;
        super.onDispose();
    }

    public function as_setDeadReasonInfo(param1:String, param2:Boolean, param3:String, param4:String, param5:String, param6:String):void {
        this._deadReason = param1;
        this._showVehiclePanel = param2;
        this._vehicleLevel = param3;
        this._vehicleImg = param4;
        this._vehicleName = param6;
        this._vehicleType = param5;
        invalidate(INVALID_VEHICLE_PANEL);
    }

    public function as_setPlayerInfo(param1:String):void {
        this._playerInfo = param1;
        invalidate(INVALID_PLAYER_INFO);
    }

    public function as_showDeadReason():void {
        invalidate(INVALID_DEAD_REASON_VISIBILITY);
    }

    public function updateElementsPosition():void {
        invalidate(INVALID_PLAYER_INFO_POSITION);
    }

    private function updatePlayerInfoPosition():void {
        this.playerInfoTF.y = -PLAYER_INFO_DELTA_Y * App.appScale - (App.appHeight >> 1);
    }
}
}
