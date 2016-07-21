package net.wg.gui.lobby.header.headerButtonBar {
import flash.display.MovieClip;
import flash.geom.Rectangle;

import net.wg.data.constants.IconsTypes;
import net.wg.data.constants.Linkages;
import net.wg.gui.components.controls.IconText;
import net.wg.gui.components.controls.WalletResourcesStatus;
import net.wg.gui.lobby.header.LobbyHeader;
import net.wg.gui.lobby.header.vo.HBC_FinanceVo;
import net.wg.infrastructure.interfaces.ITweenAnimatorHandler;

public class HBC_Finance extends HBC_ActionItem implements ITweenAnimatorHandler {

    public var moneyIconText:IconText = null;

    public var wallet:WalletResourcesStatus = null;

    public var discountAnimation:MovieClip = null;

    private var _financeVo:HBC_FinanceVo = null;

    public function HBC_Finance() {
        super();
        minScreenPadding.left = 8;
        minScreenPadding.right = 10;
        additionalScreenPadding.left = 10;
        additionalScreenPadding.right = 17;
        maxFontSize = 14;
    }

    override public function updateButtonBounds(param1:Rectangle):void {
        if (this.discountAnimation != null) {
            this.discountAnimation.x = param1.x + (param1.width >> 1);
            this.discountAnimation.y = param1.height;
        }
        super.updateButtonBounds(param1);
    }

    override protected function updateSize():void {
        if (this.moneyIconText.visible) {
            bounds.width = Math.max(this.moneyIconText.textField.x + this.moneyIconText.textField.textWidth + TEXT_FIELD_MARGIN, doItTextField.x + doItTextField.width);
        }
        else {
            bounds.width = Math.max(doItTextField.x + doItTextField.width, this.wallet.x + this.wallet.width);
        }
        super.updateSize();
    }

    override protected function updateData():void {
        if (data) {
            this.moneyIconText.icon = this._financeVo.iconId;
            this.moneyIconText.text = this._financeVo.money;
            this.moneyIconText.textSize = useFontSize;
            this.moneyIconText.textFieldYOffset = screen == LobbyHeader.MAX_SCREEN ? Number(-1) : Number(0);
            this.moneyIconText.validateNow();
            this.wallet.icoType = this._financeVo.iconId;
            if (this._financeVo.iconId == IconsTypes.FREE_XP) {
                this.moneyIconText.visible = !this.wallet.updateStatus(App.utils.voMgr.walletStatusVO.freeXpStatus);
            }
            else if (this._financeVo.iconId == IconsTypes.GOLD) {
                this.moneyIconText.visible = !this.wallet.updateStatus(App.utils.voMgr.walletStatusVO.goldStatus);
            }
            else {
                this.wallet.visible = false;
            }
            doItTextField.text = this._financeVo.btnDoText;
        }
        super.updateData();
        this.updateDiscountAnimationState();
        data.playDiscountAnimation = false;
    }

    override protected function isDiscountEnabled():Boolean {
        return this._financeVo.isDiscountEnabled || this._financeVo.isHasAction;
    }

    override protected function onDispose():void {
        this._financeVo = null;
        this.moneyIconText.dispose();
        this.moneyIconText = null;
        this.wallet.dispose();
        this.wallet = null;
        if (this.discountAnimation != null && contains(this.discountAnimation)) {
            removeChild(this.discountAnimation);
        }
        this.discountAnimation = null;
        super.onDispose();
    }

    override protected function isNeedUpdateFont():Boolean {
        return super.isNeedUpdateFont() || useFontSize != doItTextField.getTextFormat().size;
    }

    public function onComplete():void {
        if (this.discountAnimation != null) {
            if (contains(this.discountAnimation)) {
                removeChild(this.discountAnimation);
            }
            this.discountAnimation = null;
        }
    }

    private function updateDiscountAnimationState():void {
        if (this._financeVo.playDiscountAnimation) {
            if (this.discountAnimation == null) {
                this.discountAnimation = App.utils.classFactory.getComponent(Linkages.GOLD_FISH_BUTTON_ANIMATION, MovieClip);
            }
            if (this.discountAnimation != null) {
                if (!contains(this.discountAnimation)) {
                    addChildAt(this.discountAnimation, 0);
                }
                this.discountAnimation.visible = false;
                this.discountAnimation.gotoAndStop(1);
                this.discountAnimation.addFrameScript(this.discountAnimation.totalFrames - 1, this.onDiscountAnimationFinished);
            }
        }
        else {
            if (this.discountAnimation != null && contains(this.discountAnimation)) {
                removeChild(this.discountAnimation);
            }
            this.discountAnimation = null;
        }
        if (this.discountAnimation != null) {
            if (this._financeVo.isDiscountEnabled && this._financeVo.playDiscountAnimation) {
                this.discountAnimation.gotoAndPlay(1);
                if (buttonActionContent != null) {
                    buttonActionContent.setEnabled(false);
                }
            }
            else {
                this.discountAnimation.stop();
            }
            this.discountAnimation.visible = this._financeVo.isDiscountEnabled && this._financeVo.playDiscountAnimation;
        }
    }

    private function onDiscountAnimationFinished():void {
        if (this.discountAnimation != null) {
            this.discountAnimation.stop();
            if (contains(this.discountAnimation)) {
                removeChild(this.discountAnimation);
            }
            this.discountAnimation = null;
        }
        if (buttonActionContent != null) {
            buttonActionContent.setEnabled(true);
        }
    }

    override public function set data(param1:Object):void {
        this._financeVo = HBC_FinanceVo(param1);
        super.data = param1;
    }

    override protected function get leftPadding():Number {
        var _loc1_:Number = 0;
        switch (screen) {
            case LobbyHeader.WIDE_SCREEN:
                _loc1_ = wideScreenPrc;
                break;
            case LobbyHeader.MAX_SCREEN:
                _loc1_ = maxScreenPrc;
        }
        return minScreenPadding.left + additionalScreenPadding.left * _loc1_ ^ 0;
    }

    override protected function get rightPadding():Number {
        var _loc1_:Number = 0;
        switch (screen) {
            case LobbyHeader.WIDE_SCREEN:
                _loc1_ = wideScreenPrc;
                break;
            case LobbyHeader.MAX_SCREEN:
                _loc1_ = maxScreenPrc;
        }
        return minScreenPadding.right + additionalScreenPadding.right * _loc1_ ^ 0;
    }
}
}
