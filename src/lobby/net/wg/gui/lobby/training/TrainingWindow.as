package net.wg.gui.lobby.training {
import flash.display.InteractiveObject;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.Aliases;
import net.wg.data.VO.TrainingWindowVO;
import net.wg.gui.components.advanced.TextAreaSimple;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.NumericStepper;
import net.wg.gui.components.controls.ScrollingListEx;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.lobby.components.MinimapLobby;
import net.wg.infrastructure.base.meta.ITrainingWindowMeta;
import net.wg.infrastructure.base.meta.impl.TrainingWindowMeta;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.constants.WrappingMode;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.ListEvent;

public class TrainingWindow extends TrainingWindowMeta implements ITrainingWindowMeta {

    private static const ACTIVE_MAP_ALPHA_VALUE:int = 1;

    private static const INACTIVE_MAP_ALPHA_VALUE:Number = 0.6;

    public var mapName:TextField;

    public var battleType:TextField;

    public var maxPlayers:TextField;

    public var maps:ScrollingListEx;

    public var battleTime:NumericStepper;

    public var isPrivate:CheckBox;

    public var description:TextAreaSimple;

    public var createButon:SoundButtonEx;

    public var closeButon:SoundButtonEx;

    public var minimap:MinimapLobby;

    private var _mapsData:Array;

    private var _paramsVO:TrainingWindowVO;

    private var _dataWasSetted:Boolean = false;

    public function TrainingWindow() {
        super();
    }

    private static function onPrivateCheckboxOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showComplex(TOOLTIPS.TRAINING_CREATE_INVITES_CHECKBOX);
    }

    private static function onPrivateCheckboxOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    override protected function configUI():void {
        super.configUI();
        this.createButon.addEventListener(ButtonEvent.CLICK, this.onCreateButtonClickHandler);
        this.closeButon.addEventListener(ButtonEvent.CLICK, this.onCloseButtonClickHandler);
        this.isPrivate.addEventListener(MouseEvent.ROLL_OVER, onPrivateCheckboxOverHandler);
        this.isPrivate.addEventListener(MouseEvent.ROLL_OUT, onPrivateCheckboxOutHandler);
        this.isPrivate.addEventListener(MouseEvent.CLICK, onPrivateCheckboxOutHandler);
        this.maps.addEventListener(ListEvent.INDEX_CHANGE, this.onMapIndexChangeHandler);
        this.maps.wrapping = WrappingMode.STICK;
        this.description.text = "";
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        setFocus(this.createButon);
    }

    override protected function onPopulate():void {
        super.onPopulate();
        window.useBottomBtns = true;
        registerFlashComponentS(this.minimap, Aliases.LOBBY_MINIMAP);
    }

    override protected function onDispose():void {
        this.createButon.removeEventListener(ButtonEvent.CLICK, this.onCreateButtonClickHandler);
        this.closeButon.removeEventListener(ButtonEvent.CLICK, this.onCloseButtonClickHandler);
        this.isPrivate.removeEventListener(MouseEvent.ROLL_OVER, onPrivateCheckboxOverHandler);
        this.isPrivate.removeEventListener(MouseEvent.ROLL_OUT, onPrivateCheckboxOutHandler);
        this.isPrivate.removeEventListener(MouseEvent.CLICK, onPrivateCheckboxOutHandler);
        this.maps.removeEventListener(ListEvent.INDEX_CHANGE, this.onMapIndexChangeHandler);
        this.mapName = null;
        this.battleType = null;
        this.maxPlayers = null;
        this.maps.dispose();
        this.maps = null;
        this.battleTime.dispose();
        this.battleTime = null;
        this.isPrivate.dispose();
        this.isPrivate = null;
        this.description.dispose();
        this.description = null;
        this.createButon.dispose();
        this.createButon = null;
        this.closeButon.dispose();
        this.closeButon = null;
        if (this._mapsData) {
            this._mapsData.splice(0, this._mapsData.length);
            this._mapsData = null;
        }
        this._paramsVO.dispose();
        this._paramsVO = null;
        this.minimap = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:uint = 0;
        var _loc2_:Number = NaN;
        super.draw();
        if (isInvalid(InvalidationType.DATA) && this._paramsVO != null && this._mapsData != null) {
            this.isPrivate.selected = this._paramsVO.privacy;
            this.isPrivate.enabled = this._paramsVO.canMakeOpenedClosed;
            this.description.text = this._paramsVO.description;
            this.description.validateNow();
            this.description.enabled = this._paramsVO.canChangeComment;
            this.battleTime.maximum = this._paramsVO.maxBattleTime;
            this.battleTime.enabled = this.maps.mouseEnabled = this.maps.mouseChildren = this._paramsVO.canChangeArena;
            this.maps.alpha = !!this._paramsVO.canChangeArena ? Number(ACTIVE_MAP_ALPHA_VALUE) : Number(INACTIVE_MAP_ALPHA_VALUE);
            this.maps.dataProvider = new DataProvider(this._mapsData);
            if (this._paramsVO.create) {
                window.title = MENU.TRAINING_CREATE_TITLE;
                this.maps.selectedIndex = Math.floor(Math.random() * this._mapsData.length);
                this.isPrivate.selected = false;
            }
            else {
                window.title = MENU.TRAINING_INFO_SETTINGS_TITLE;
                this.createButon.label = MENU.TRAINING_INFO_SETTINGS_OKBUTTON;
                _loc1_ = this._mapsData.length;
                _loc2_ = 0;
                while (_loc2_ < _loc1_) {
                    if (this._paramsVO.arena == this._mapsData[_loc2_].key) {
                        this.maps.selectedIndex = _loc2_;
                        this._dataWasSetted = true;
                        break;
                    }
                    _loc2_++;
                }
            }
        }
    }

    public function as_setData(param1:Object, param2:Array):void {
        this._paramsVO = new TrainingWindowVO(param1);
        this._mapsData = param2;
        invalidateData();
    }

    private function onCloseButtonClickHandler(param1:ButtonEvent):void {
        onWindowCloseS();
    }

    private function onCreateButtonClickHandler(param1:ButtonEvent):void {
        var _loc2_:Number = this._mapsData[this.maps.selectedIndex].key;
        var _loc3_:Number = this.battleTime.value;
        var _loc4_:int = !!this.isPrivate.selected ? 1 : 0;
        var _loc5_:String = !!this.description.text ? this.description.text : "";
        updateTrainingRoomS(_loc2_, _loc3_, _loc4_, _loc5_);
        this.onCloseButtonClickHandler(null);
    }

    private function onMapIndexChangeHandler(param1:ListEvent):void {
        if (param1.index < this._mapsData.length) {
            this.mapName.text = param1.itemData.name;
            this.battleType.text = param1.itemData.arenaType;
            this.maxPlayers.text = param1.itemData.size + "/" + param1.itemData.size;
            this.battleTime.value = param1.itemData.time;
            this.minimap.setMapS(param1.itemData.key);
        }
        if (this._dataWasSetted && this._paramsVO) {
            this.battleTime.value = this._paramsVO.timeout;
            this._dataWasSetted = false;
        }
    }
}
}
