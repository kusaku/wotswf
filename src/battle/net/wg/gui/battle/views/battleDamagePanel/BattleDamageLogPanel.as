package net.wg.gui.battle.views.battleDamagePanel {
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.generated.BATTLEDAMAGELOG_IMAGES;
import net.wg.gui.battle.views.battleDamagePanel.components.DamageLogDetailsController;
import net.wg.gui.battle.views.battleDamagePanel.components.DamageLogDetailsImages;
import net.wg.gui.battle.views.battleDamagePanel.components.DamageLogDetailsText;
import net.wg.gui.battle.views.battleDamagePanel.components.DefaultSummaryImages;
import net.wg.gui.battle.views.battleDamagePanel.components.SummaryAnimation;
import net.wg.gui.battle.views.battleDamagePanel.models.MessageRenderModel;
import net.wg.infrastructure.base.meta.IBattleDamageLogPanelMeta;
import net.wg.infrastructure.base.meta.impl.BattleDamageLogPanelMeta;

public class BattleDamageLogPanel extends BattleDamageLogPanelMeta implements IBattleDamageLogPanelMeta {

    private static const Y_POSITION_STEP_TF:int = 22;

    private static const ANIMATION_PADDING:Number = 10;

    public var summaryDamageBlock:DefaultSummaryImages = null;

    public var summaryDefenceBlock:DefaultSummaryImages = null;

    public var summarySupportBlock:DefaultSummaryImages = null;

    public var damageValTF:TextField = null;

    public var defenceValTF:TextField = null;

    public var supportValTF:TextField = null;

    public var damageAnimation:SummaryAnimation = null;

    public var defenceAnimation:SummaryAnimation = null;

    public var supportAnimation:SummaryAnimation = null;

    public var damageLogDetailsImages:DamageLogDetailsImages = null;

    public var damageLogDetailsText:DamageLogDetailsText = null;

    private var _damageLogDetailsController:DamageLogDetailsController = null;

    private var _additionalRowsCount:int = 3;

    private var _detailActionRowsCount:int = 0;

    private var _currentPositionTF:int = 0;

    private var _isInited:Boolean = false;

    public function BattleDamageLogPanel() {
        super();
        this._damageLogDetailsController = new DamageLogDetailsController(this.damageLogDetailsImages, this.damageLogDetailsText);
        this.damageLogDetailsImages.addEventListener(MouseEvent.MOUSE_WHEEL, this.onDmgLogDetailsImagesMouseWheelHandler);
        this.damageLogDetailsText.mouseEnabled = false;
        this.damageLogDetailsText.mouseChildren = false;
        this.summaryDamageBlock.visible = this.summaryDefenceBlock.visible = this.summarySupportBlock.visible = false;
    }

    override protected function onDispose():void {
        this._damageLogDetailsController.dispose();
        this._damageLogDetailsController = null;
        this.summaryDamageBlock.dispose();
        this.summaryDamageBlock = null;
        this.summaryDefenceBlock.dispose();
        this.summaryDefenceBlock = null;
        this.summarySupportBlock.dispose();
        this.summarySupportBlock = null;
        this.damageValTF = null;
        this.defenceValTF = null;
        this.supportValTF = null;
        this.damageAnimation.dispose();
        this.damageAnimation = null;
        this.defenceAnimation.dispose();
        this.defenceAnimation = null;
        this.supportAnimation.dispose();
        this.supportAnimation = null;
        this.damageLogDetailsText = null;
        this.damageLogDetailsImages.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onDmgLogDetailsImagesMouseWheelHandler);
        this.damageLogDetailsImages = null;
        super.onDispose();
    }

    public function as_addDetailMessage(param1:uint, param2:String, param3:String, param4:String, param5:String):void {
        this._damageLogDetailsController.addDetailsMessage(new MessageRenderModel({
            "valueColor": param1,
            "value": param2,
            "actionTypeImg": param3,
            "vehicleTypeImg": param4,
            "vehicleName": param5
        }));
    }

    override protected function detailStats(param1:Boolean, param2:Vector.<MessageRenderModel>):void {
        this._damageLogDetailsController.detailsStats(param1, param2);
    }

    public function as_isDownAltButton(param1:Boolean):void {
        this._damageLogDetailsController.isDownAltButton(param1);
    }

    public function as_isDownCtrlButton(param1:Boolean):void {
        this._damageLogDetailsController.isDownCtrlButton(param1);
    }

    public function as_showDamageLogComponent(param1:Boolean):void {
        this.visible = param1;
    }

    public function as_summaryStats(param1:String, param2:String, param3:String):void {
        if (!this._isInited) {
            this.summaryDamageBlock.loadImages(BATTLEDAMAGELOG_IMAGES.DAMAGELOG_DAMAGE_DETAIL, BATTLEDAMAGELOG_IMAGES.DAMAGELOG_DAMAGE_16X16);
            this.summaryDefenceBlock.loadImages(BATTLEDAMAGELOG_IMAGES.DAMAGELOG_DAMAGE_DETAIL, BATTLEDAMAGELOG_IMAGES.DAMAGELOG_REFLECT_16X16);
            this.summarySupportBlock.loadImages(BATTLEDAMAGELOG_IMAGES.DAMAGELOG_DAMAGE_DETAIL, BATTLEDAMAGELOG_IMAGES.DAMAGELOG_ASSIST_16X16);
            this._isInited = true;
        }
        this._currentPositionTF = 0;
        this._additionalRowsCount = 0;
        this.initializeSummaryElements(param1, this.damageValTF, this.summaryDamageBlock, this.damageAnimation);
        this.initializeSummaryElements(param2, this.defenceValTF, this.summaryDefenceBlock, this.defenceAnimation);
        this.initializeSummaryElements(param3, this.supportValTF, this.summarySupportBlock, this.supportAnimation);
        this._damageLogDetailsController.addAdditionalRows(this._additionalRowsCount);
        this._damageLogDetailsController.setDetailsCount(this._detailActionRowsCount, this._additionalRowsCount);
    }

    public function as_updateSummaryAssistValue(param1:String):void {
        this.updateSummaryCounter(this.supportAnimation, this.supportValTF, param1);
    }

    public function as_updateSummaryBlockedValue(param1:String):void {
        this.updateSummaryCounter(this.defenceAnimation, this.defenceValTF, param1);
    }

    public function as_updateSummaryDamageValue(param1:String):void {
        this.updateSummaryCounter(this.damageAnimation, this.damageValTF, param1);
    }

    public function setDetailActionCount(param1:int):void {
        this._detailActionRowsCount = param1;
        this._damageLogDetailsController.setDetailsCount(this._detailActionRowsCount, this._additionalRowsCount);
    }

    private function initializeSummaryElements(param1:String, param2:TextField, param3:DefaultSummaryImages, param4:SummaryAnimation):void {
        var _loc5_:* = false;
        _loc5_ = param1 != null;
        param2.visible = _loc5_;
        param3.visible = _loc5_;
        param4.visible = _loc5_;
        if (!_loc5_) {
            this._additionalRowsCount++;
            return;
        }
        param2.text = param1;
        param2.y = this._currentPositionTF;
        this._currentPositionTF = this._currentPositionTF + Y_POSITION_STEP_TF;
        param3.y = param2.y + (param2.height - param3.height >> 1);
        param4.x = param2.x + ANIMATION_PADDING;
        param4.y = param2.y + (param2.height >> 1);
    }

    private function updateSummaryCounter(param1:SummaryAnimation, param2:TextField, param3:String):void {
        if (param2.visible) {
            param1.playAnimation();
            param2.text = param3;
        }
    }

    private function onDmgLogDetailsImagesMouseWheelHandler(param1:MouseEvent):void {
        this._damageLogDetailsController.scroll(param1.delta);
    }
}
}
