package net.wg.gui.lobby.referralSystem {
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.Values;
import net.wg.gui.components.controls.Image;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.TableRenderer;
import net.wg.gui.components.controls.UserNameField;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;

public class ReferralsTableRenderer extends TableRenderer {

    public var referralNumberTF:TextField = null;

    public var referralName:UserNameField = null;

    public var expTF:TextField = null;

    public var multiplierTF:TextField = null;

    public var createSquadBtn:SoundButtonEx = null;

    public var statusIndicator:Image = null;

    private var _referralID:Number = 0;

    private var _model:ReferralsTableRendererVO = null;

    public function ReferralsTableRenderer() {
        super();
        isPassive = true;
    }

    private static function onMultiplierRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    override public function setData(param1:Object):void {
        this._model = ReferralsTableRendererVO(param1);
        invalidateData();
    }

    override protected function configUI():void {
        super.configUI();
        this.createSquadBtn.mouseEnabledOnDisabled = true;
        this.multiplierTF.autoSize = TextFieldAutoSize.CENTER;
    }

    override protected function onDispose():void {
        this.removeListeners();
        this._model = null;
        this.referralNumberTF = null;
        this.expTF = null;
        this.multiplierTF = null;
        this.referralName.dispose();
        this.referralName = null;
        this.createSquadBtn.dispose();
        this.createSquadBtn = null;
        this.statusIndicator.dispose();
        this.statusIndicator = null;
        this._model = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        mouseEnabled = mouseChildren = true;
        if (isInvalid(InvalidationType.DATA)) {
            if (this._model) {
                this.referralNumberTF.htmlText = this._model.referralNo;
                this.createSquadBtn.tooltip = this._model.btnTooltip;
                this.hideElements(this._model.isEmpty);
                if (!this._model.isEmpty) {
                    this._referralID = this._model.referralVO.accID;
                    this.referralName.userVO = this._model.referralVO;
                    this.expTF.htmlText = this._model.exp;
                    this.multiplierTF.htmlText = this._model.multiplier;
                    this.createSquadBtn.label = MENU.REFERRALMANAGEMENTWINDOW_REFERRALSTABLE_CREATESQUADBTN_LABEL;
                    this.createSquadBtn.enabled = this._model.btnEnabled;
                    if (this._model.btnEnabled) {
                        this.createSquadBtn.addEventListener(ButtonEvent.CLICK, this.onCreateSquadBtnClickHandler);
                    }
                    else {
                        this.createSquadBtn.removeEventListener(ButtonEvent.CLICK, this.onCreateSquadBtnClickHandler);
                    }
                    this.statusIndicator.source = this._model.contactDataVO.resource;
                    if (this._model.multiplierTooltip != Values.EMPTY_STR) {
                        this.multiplierTF.addEventListener(MouseEvent.ROLL_OVER, this.onMultiplierRollOverHandler);
                        this.multiplierTF.addEventListener(MouseEvent.ROLL_OUT, onMultiplierRollOutHandler);
                    }
                    else {
                        this.multiplierTF.removeEventListener(MouseEvent.ROLL_OVER, this.onMultiplierRollOverHandler);
                        this.multiplierTF.removeEventListener(MouseEvent.ROLL_OUT, onMultiplierRollOutHandler);
                    }
                }
                else {
                    this.removeListeners();
                    this.expTF.htmlText = Values.EMPTY_STR;
                    this.multiplierTF.htmlText = Values.EMPTY_STR;
                }
            }
            else {
                this.removeListeners();
                this.expTF.htmlText = Values.EMPTY_STR;
                this.multiplierTF.htmlText = Values.EMPTY_STR;
                this.hideElements(true);
            }
        }
    }

    private function removeListeners():void {
        this.multiplierTF.removeEventListener(MouseEvent.ROLL_OVER, this.onMultiplierRollOverHandler);
        this.multiplierTF.removeEventListener(MouseEvent.ROLL_OUT, onMultiplierRollOutHandler);
        this.createSquadBtn.removeEventListener(ButtonEvent.CLICK, this.onCreateSquadBtnClickHandler);
    }

    private function hideElements(param1:Boolean):void {
        this.referralName.visible = !param1;
        this.statusIndicator.visible = !param1;
        this.expTF.visible = !param1;
        this.multiplierTF.visible = !param1;
        this.createSquadBtn.visible = !param1;
    }

    private function onCreateSquadBtnClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new ReferralManagementEvent(ReferralManagementEvent.CREATE_SQUAD_BTN_CLICK, this._referralID));
    }

    private function onMultiplierRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showComplex(this._model.multiplierTooltip);
    }
}
}
