package net.wg.gui.lobby.techtree.controls {
import flash.text.TextField;

import net.wg.data.constants.generated.NODE_STATE_FLAGS;
import net.wg.gui.components.controls.WalletResourcesStatus;
import net.wg.gui.lobby.techtree.TechTreeEvent;
import net.wg.gui.lobby.techtree.constants.TTInvalidationType;
import net.wg.gui.lobby.techtree.constants.XpTypeStrings;
import net.wg.gui.lobby.techtree.interfaces.IRenderer;
import net.wg.utils.ILocale;

public class ExperienceInformation extends NodeComponent {

    public var vehXPLabel:TextField;

    public var vehXPIcon:XPIcon;

    public var vehXPField:TextField;

    public var freeXPLabel:TextField;

    public var freeXPField:TextField;

    public var totalXPLabel:TextField;

    public var vehXPInTotalIcon:XPIcon;

    public var totalXPField:TextField;

    public var haveNotFreeXp:WalletResourcesStatus;

    private var _freeXP:Number = 0;

    private var _locale:ILocale;

    public function ExperienceInformation() {
        this._locale = App.utils.locale;
        super();
    }

    override public function setOwner(param1:IRenderer, param2:Boolean = false):void {
        if (_owner != null) {
            _owner.removeEventListener(TechTreeEvent.STATE_CHANGED, this.onOwnerStateChangedHandler);
        }
        super.setOwner(param1);
        if (_owner != null) {
            _owner.addEventListener(TechTreeEvent.STATE_CHANGED, this.onOwnerStateChangedHandler, false, 0, true);
        }
        invalidate(TTInvalidationType.ELITE, TTInvalidationType.VEH_XP);
    }

    override protected function onDispose():void {
        this.vehXPIcon.dispose();
        this.vehXPIcon = null;
        this.vehXPInTotalIcon.dispose();
        this.vehXPInTotalIcon = null;
        this.haveNotFreeXp.dispose();
        this.haveNotFreeXp = null;
        this.totalXPField = null;
        this.vehXPLabel = null;
        this.vehXPField = null;
        this.freeXPLabel = null;
        this.freeXPField = null;
        this.totalXPLabel = null;
        this._locale = null;
        super.onDispose();
    }

    override protected function configUI():void {
        if (this.vehXPLabel != null) {
            this.vehXPLabel.text = MENU.RESEARCH_LABELS_VEHXP;
        }
        if (this.freeXPLabel != null) {
            this.freeXPLabel.text = MENU.RESEARCH_LABELS_FREEXP;
        }
        if (this.totalXPLabel != null) {
            this.totalXPLabel.text = MENU.RESEARCH_LABELS_TOTALXP;
        }
        super.configUI();
    }

    override protected function draw():void {
        super.draw();
        if (_owner == null) {
            return;
        }
        if (isInvalid(TTInvalidationType.ELITE)) {
            this.changeStars();
        }
        var _loc1_:Boolean = isInvalid(TTInvalidationType.VEH_XP, TTInvalidationType.FREE_XP);
        if (_loc1_) {
            this.makeVehXPString();
            this.makeFreeXPString();
            this.makeTotalXPString();
        }
    }

    public function setFreeXP(param1:Number):void {
        if (this._freeXP == param1) {
            return;
        }
        this._freeXP = param1;
        invalidate(TTInvalidationType.FREE_XP);
    }

    public function setWalletStatus():void {
        this.freeXPField.visible = !this.haveNotFreeXp.updateStatus(App.utils.voMgr.walletStatusVO.freeXpStatus);
    }

    private function changeStars():void {
        var _loc1_:String = !!_owner.isElite() ? XpTypeStrings.ELITE_XP_TYPE : XpTypeStrings.EARNED_XP_TYPE;
        this.vehXPIcon.type = _loc1_;
        this.vehXPInTotalIcon.type = _loc1_;
    }

    private function makeVehXPString():void {
        this.vehXPField.text = this._locale.integer(_owner.getEarnedXP());
    }

    private function makeFreeXPString():void {
        this.freeXPField.text = this._locale.integer(this._freeXP);
    }

    private function makeTotalXPString():void {
        this.totalXPField.text = this._locale.integer(_owner.getEarnedXP() + Math.max(0, this._freeXP));
    }

    private function onOwnerStateChangedHandler(param1:TechTreeEvent):void {
        if (param1.primary == NODE_STATE_FLAGS.ELITE) {
            invalidate(TTInvalidationType.ELITE);
        }
        else if (param1.primary == 0) {
            invalidate(TTInvalidationType.VEH_XP);
        }
    }
}
}
