package net.wg.gui.lobby.christmas.controls {
import flash.display.MovieClip;
import flash.display.Sprite;

import net.wg.data.constants.Linkages;
import net.wg.gui.lobby.christmas.ChristmasChestsView;
import net.wg.gui.lobby.christmas.event.ChristmasAwardRendererEvent;
import net.wg.gui.lobby.christmas.interfaces.IChestAwardRibbon;
import net.wg.gui.lobby.christmas.interfaces.IChristmasAwardAnimRenderer;
import net.wg.gui.lobby.quests.data.AwardCarouselItemRendererVO;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;

public class ChestAwardRibbon extends UIComponentEx implements IChestAwardRibbon {

    private static const AWARDS_Y:int = 58;

    private static const AWARDS_GAP:int = -25;

    private static const AWARDS_DEFAULT_WIDTH:int = 180;

    private static const SHOW_LABEL:String = "show";

    private static const HIDE_LABEL:String = "hide";

    private static const SHOW_ANIM_LAST_FRAME:int = 28;

    private static const AWARD_SOUND:String = "award";

    private static const FLARE_SOUND:String = "flare";

    public var headerText:ChestAwardHeader = null;

    public var flare:MovieClip = null;

    private var _awardVOs:Vector.<AwardCarouselItemRendererVO> = null;

    private var _awards:Vector.<ChristmasAwardAnimRenderer> = null;

    private var _awardToShow:int = 0;

    private var _owner:ChristmasChestsView = null;

    public function ChestAwardRibbon() {
        super();
        visible = false;
        this.flare.stop();
        addFrameScript(SHOW_ANIM_LAST_FRAME, this.onShowAnimFinished);
    }

    override protected function onDispose():void {
        stop();
        this.tryDisposeAwards();
        this.headerText.dispose();
        this.headerText = null;
        this._awardVOs = null;
        this.flare = null;
        this._owner = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.flare.mouseEnabled = this.flare.mouseChildren = false;
    }

    override protected function draw():void {
        var _loc1_:int = 0;
        var _loc2_:ChristmasAwardAnimRenderer = null;
        var _loc3_:Class = null;
        var _loc4_:int = 0;
        super.draw();
        if (isInvalid(InvalidationType.DATA) && this._awardVOs != null) {
            this.tryDisposeAwards();
            this.headerText.headerTF.htmlText = CHRISTMAS.CHESTVIEW_GETAWARD;
            _loc1_ = this._awardVOs.length;
            _loc2_ = null;
            _loc3_ = App.utils.classFactory.getClass(Linkages.CHRISTMAS_AWARD_ANIM_RENDERER_UI);
            this._awards = new Vector.<ChristmasAwardAnimRenderer>();
            _loc4_ = 0;
            while (_loc4_ < _loc1_) {
                _loc2_ = new _loc3_();
                _loc2_.setData(this._awardVOs[_loc4_]);
                addChild(_loc2_);
                this._awards[_loc4_] = _loc2_;
                _loc4_++;
            }
            _loc2_.renderer.addEventListener(ChristmasAwardRendererEvent.RENDERER_READY, this.onAwardsRendererReadyHandler);
            setChildIndex(this.flare, numChildren - 1);
            this.flare.gotoAndStop(1);
        }
    }

    public function hide():void {
        var _loc1_:IChristmasAwardAnimRenderer = null;
        for each(_loc1_ in this._awards) {
            _loc1_.hide();
        }
        gotoAndPlay(HIDE_LABEL);
    }

    public function setAwards(param1:Vector.<AwardCarouselItemRendererVO>):void {
        this._awardVOs = param1;
        invalidateData();
    }

    public function setOwner(param1:ChristmasChestsView):void {
        this._owner = param1;
    }

    public function show():void {
        visible = true;
        gotoAndPlay(SHOW_LABEL);
    }

    private function onShowAnimFinished():void {
        var _loc1_:ChristmasAwardAnimRenderer = null;
        stop();
        this._awardToShow = 0;
        for each(_loc1_ in this._awards) {
            _loc1_.addEventListener(ChristmasAwardRendererEvent.SHOW_ANIM_FINISHED, this.onAwardShowAnimFinishedHandler);
        }
        this._awards[this._awardToShow].show();
        this._owner.onPlaySoundS(AWARD_SOUND);
    }

    private function tryDisposeAwards():void {
        var _loc1_:ChristmasAwardAnimRenderer = null;
        if (this._awards != null) {
            this._awards[this._awards.length - 1].renderer.removeEventListener(ChristmasAwardRendererEvent.RENDERER_READY, this.onAwardsRendererReadyHandler);
            for each(_loc1_ in this._awards) {
                _loc1_.removeEventListener(ChristmasAwardRendererEvent.SHOW_ANIM_FINISHED, this.onAwardShowAnimFinishedHandler);
                removeChild(_loc1_);
                _loc1_.dispose();
            }
            this._awards.splice(0, this._awards.length);
            this._awards = null;
        }
    }

    private function layoutAwards():void {
        var _loc4_:Sprite = null;
        var _loc1_:int = this._awards.length;
        var _loc2_:int = _loc1_ * AWARDS_DEFAULT_WIDTH + AWARDS_GAP * (_loc1_ - 1);
        var _loc3_:* = width - _loc2_ >> 1;
        for each(_loc4_ in this._awards) {
            _loc4_.x = _loc3_;
            _loc4_.y = AWARDS_Y;
            _loc3_ = int(_loc3_ + (AWARDS_DEFAULT_WIDTH + AWARDS_GAP));
        }
    }

    private function onAwardShowAnimFinishedHandler(param1:ChristmasAwardRendererEvent):void {
        param1.target.removeEventListener(ChristmasAwardRendererEvent.SHOW_ANIM_FINISHED, this.onAwardShowAnimFinishedHandler);
        this._awardToShow++;
        if (this._awardToShow < this._awards.length) {
            this._awards[this._awardToShow].show();
            this._owner.onPlaySoundS(AWARD_SOUND);
        }
        else {
            this.flare.gotoAndPlay(1);
            this._owner.onPlaySoundS(FLARE_SOUND);
        }
    }

    private function onAwardsRendererReadyHandler(param1:ChristmasAwardRendererEvent):void {
        param1.target.removeEventListener(ChristmasAwardRendererEvent.RENDERER_READY, this.onAwardsRendererReadyHandler);
        this.layoutAwards();
    }
}
}
