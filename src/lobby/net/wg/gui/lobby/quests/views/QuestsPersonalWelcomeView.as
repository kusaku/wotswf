package net.wg.gui.lobby.quests.views {
import flash.display.InteractiveObject;
import flash.text.TextField;

import net.wg.data.Aliases;
import net.wg.data.constants.Errors;
import net.wg.data.constants.Linkages;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.components.icons.BattleTypeIcon;
import net.wg.gui.components.miniclient.LinkedMiniClientComponent;
import net.wg.gui.lobby.quests.components.interfaces.IQuestsPersonalWelcomeView;
import net.wg.gui.lobby.quests.components.interfaces.ITextBlockWelcomeView;
import net.wg.gui.lobby.quests.data.seasonAwards.QuestsPersonalWelcomeViewVO;
import net.wg.infrastructure.base.meta.impl.QuestsPersonalWelcomeViewMeta;
import net.wg.infrastructure.events.FocusChainChangeEvent;
import net.wg.infrastructure.exceptions.AbstractException;
import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;
import scaleform.gfx.TextFieldEx;

public class QuestsPersonalWelcomeView extends QuestsPersonalWelcomeViewMeta implements IQuestsPersonalWelcomeView {

    private static const MINI_CLIENT_POS_X:int = 680;

    private static const MINI_CLIENT_POS_Y:int = 491;

    public var titleText:TextField = null;

    public var bgLoader:UILoaderAlt = null;

    public var textBlock1:ITextBlockWelcomeView = null;

    public var textBlock2:ITextBlockWelcomeView = null;

    public var textBlock3:ITextBlockWelcomeView = null;

    public var textBlocks:Vector.<ITextBlockWelcomeView> = null;

    public var successBtn:SoundButtonEx = null;

    public var announcementIcon:BattleTypeIcon;

    public var announcementText:TextField;

    private var _miniClientCmp:LinkedMiniClientComponent = null;

    public function QuestsPersonalWelcomeView() {
        super();
        this.textBlocks = new <ITextBlockWelcomeView>[this.textBlock1, this.textBlock2, this.textBlock3];
        this.bgLoader.autoSize = false;
        TextFieldEx.setVerticalAlign(this.titleText, TextFieldEx.VALIGN_CENTER);
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        this.titleText = null;
        this.bgLoader.dispose();
        this.bgLoader = null;
        this.successBtn.removeEventListener(ButtonEvent.CLICK, this.onSuccessBtnClickHandler);
        this.successBtn.dispose();
        this.successBtn = null;
        for each(_loc1_ in this.textBlocks) {
            _loc1_.dispose();
        }
        this.textBlocks.splice(0, this.textBlocks.length);
        this.textBlocks = null;
        this.textBlock1 = null;
        this.textBlock2 = null;
        this.textBlock3 = null;
        this.announcementIcon.dispose();
        this.announcementIcon = null;
        this.announcementText = null;
        this._miniClientCmp = null;
        super.onDispose();
    }

    override protected function setData(param1:QuestsPersonalWelcomeViewVO):void {
        var _loc4_:Boolean = false;
        var _loc5_:int = 0;
        var _loc2_:int = this.textBlocks.length;
        var _loc3_:int = param1.blockData.length;
        App.utils.asserter.assert(_loc2_ == _loc3_, "blocks data and  text blocks count doesn\'t correspond");
        this.titleText.htmlText = param1.titleText;
        this.successBtn.label = param1.buttonLbl;
        this.bgLoader.source = param1.background;
        if (_loc3_ > 0) {
            _loc5_ = 0;
            while (_loc5_ < _loc3_) {
                this.textBlocks[_loc5_].update(param1.blockData[_loc5_]);
                _loc5_++;
            }
        }
        _loc4_ = param1.showAnnouncement;
        this.announcementIcon.visible = _loc4_;
        this.announcementText.visible = _loc4_;
        if (_loc4_) {
            this.announcementIcon.type = param1.announcementIcon;
            this.announcementText.htmlText = param1.announcementText;
            TextFieldEx.setVerticalAlign(this.announcementText, TextFieldEx.VALIGN_CENTER);
        }
    }

    override protected function configUI():void {
        super.configUI();
        this.successBtn.addEventListener(ButtonEvent.CLICK, this.onSuccessBtnClickHandler);
        dispatchEvent(new FocusChainChangeEvent(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE));
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.STATE) && this._miniClientCmp) {
            this._miniClientCmp.x = MINI_CLIENT_POS_X;
            this._miniClientCmp.y = MINI_CLIENT_POS_Y;
        }
    }

    public function as_showMiniClientInfo(param1:String, param2:String):void {
        this.successBtn.visible = false;
        this._miniClientCmp = LinkedMiniClientComponent(App.utils.classFactory.getComponent(Linkages.LINKED_MINI_CLIENT_COMPONENT, LinkedMiniClientComponent));
        addChild(this._miniClientCmp);
        registerFlashComponentS(this._miniClientCmp, Aliases.MINI_CLIENT_LINKED);
        this._miniClientCmp.update(param1, param2);
        invalidateState();
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return this.successBtn;
    }

    public function update(param1:Object):void {
        var _loc2_:String = "update" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    private function onSuccessBtnClickHandler(param1:ButtonEvent):void {
        successS();
    }
}
}
