package net.wg.gui.lobby.fortifications.cmp.impl {
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.geom.Point;
import flash.text.TextField;

import net.wg.data.Aliases;
import net.wg.gui.lobby.fortifications.cmp.IFortWelcomeView;
import net.wg.gui.lobby.profile.components.SimpleLoader;
import net.wg.infrastructure.base.meta.impl.FortWelcomeViewMeta;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.infrastructure.events.IconLoaderEvent;

import scaleform.clik.constants.InvalidationType;

public class FortWelcomeView extends FortWelcomeViewMeta implements IFortWelcomeView {

    private static const RIGHT_ALIGN_FACTOR:Number = 2 / 3;

    private static const DEFAULT_TEXT_BLOCKS_GAP:int = 26;

    private static const PROMO_START_WIDTH:Number = 1920;

    private static const PROMO_START_HEIGHT:Number = 1080;

    private static const MIN_ASPECT_RATIO:Number = 0.64;

    private static const MIN_NORMAL_WIDTH:int = 1920;

    private static const BLACK_BG_OFFSET_WIDTH:int = 1;

    private static const BLACK_BG_OFFSET_HEIGHT:int = 1;

    public var titleTextField:TextField = null;

    public var promoMC:SimpleLoader = null;

    public var blackBg:MovieClip = null;

    public var info:FortWelcomeInfoView = null;

    public function FortWelcomeView() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.promoMC.setSource(RES_FORT.MAPS_FORT_WELCOMESCREEN);
        this.promoMC.visible = false;
        this.promoMC.addEventListener(IconLoaderEvent.ICON_LOADED, this.onPromoMCIconLoadedHandler);
        this.initTexts();
        dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS, this));
    }

    override protected function draw():void {
        super.draw();
        this.info.relativityHeight = App.appHeight >> 0;
        if (isInvalid(InvalidationType.SIZE)) {
            this.updateControlPositions();
        }
    }

    override protected function onDispose():void {
        this.promoMC.removeEventListener(IconLoaderEvent.ICON_LOADED, this.onPromoMCIconLoadedHandler);
        this.titleTextField = null;
        this.promoMC.dispose();
        this.promoMC = null;
        this.blackBg = null;
        this.info = null;
        super.onDispose();
    }

    public function canShowAutomatically():Boolean {
        return false;
    }

    public function getComponentForFocus():InteractiveObject {
        return this.info.getComponentForFocus();
    }

    public function update(param1:Object):void {
    }

    private function initTexts():void {
        this.titleTextField.text = FORTIFICATIONS.FORTWELCOMEVIEW_TITLE;
    }

    private function updateControlPositions():void {
        var _loc1_:Number = App.appWidth;
        var _loc2_:Number = Math.min(MIN_NORMAL_WIDTH, _loc1_) / MIN_NORMAL_WIDTH;
        _loc2_ = Math.max(MIN_ASPECT_RATIO, _loc2_);
        this.promoMC.width = PROMO_START_WIDTH * _loc2_;
        this.promoMC.height = PROMO_START_HEIGHT * _loc2_;
        this.promoMC.x = _loc1_ - this.promoMC.width >> 1;
        this.blackBg.width = this.titleTextField.width = _loc1_ + BLACK_BG_OFFSET_WIDTH;
        this.blackBg.height = App.appHeight - globalToLocal(new Point(x, y)).y + BLACK_BG_OFFSET_HEIGHT;
        var _loc3_:uint = Math.round(_loc1_ * RIGHT_ALIGN_FACTOR);
        this.info.x = _loc3_;
        this.info.y = 0;
    }

    private function show():void {
        onViewReadyS();
        visible = true;
        registerFlashComponentS(this.info, Aliases.FORT_WELCOME_INFO);
        this.info.setGapBetweenTextBlocks(DEFAULT_TEXT_BLOCKS_GAP);
    }

    private function onPromoMCIconLoadedHandler(param1:IconLoaderEvent):void {
        this.promoMC.removeEventListener(IconLoaderEvent.ICON_LOADED, this.onPromoMCIconLoadedHandler);
        this.promoMC.visible = true;
        this.show();
    }
}
}
