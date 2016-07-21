package net.wg.gui.lobby.profile.pages.technique {
import flash.display.MovieClip;
import flash.geom.Rectangle;
import flash.text.TextField;

import net.wg.data.constants.Linkages;
import net.wg.gui.components.advanced.ButtonBarEx;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.lobby.components.ResizableViewStack;
import net.wg.gui.lobby.profile.components.ResizableContent;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.utils.IScheduler;

import scaleform.clik.controls.Button;
import scaleform.clik.data.DataProvider;

public class TechniqueStackComponent extends UIComponentEx {

    public var vNameTF:TextField = null;

    public var typeIcon:UILoaderAlt = null;

    public var tabsBg:MovieClip = null;

    public var buttonBar:ButtonBarEx = null;

    public var viewStack:ResizableViewStack = null;

    private var _resizeTask:Function = null;

    private var _scheduler:IScheduler = null;

    public function TechniqueStackComponent() {
        super();
        this._scheduler = App.utils.scheduler;
    }

    override protected function initialize():void {
        super.initialize();
        this.buttonBar.dataProvider = new DataProvider([{
            "label": PROFILE.SECTION_TECHNIQUE_TABBTN_STATISTIC,
            "linkage": Linkages.TECHNIQUE_STATISTIC_TAB,
            "tooltip": PROFILE.SECTION_TECHNIQUE_TABBTN_STATISTIC_TOOLTIP
        }, {
            "label": PROFILE.SECTION_TECHNIQUE_TABBTN_ACHIEVEMENTS,
            "linkage": Linkages.TECHNIQUE_ACHIEVEMENT_TAB,
            "tooltip": PROFILE.SECTION_TECHNIQUE_TABBTN_AWARDS_TOOLTIP
        }]);
    }

    override protected function configUI():void {
        super.configUI();
        this.viewStack.cache = true;
        this.buttonBar.selectedIndex = 0;
        this.buttonBar.validateNow();
    }

    override protected function onDispose():void {
        if (this._resizeTask != null) {
            this._scheduler.cancelTask(this._resizeTask);
            this._resizeTask = null;
        }
        this.buttonBar.dispose();
        this.buttonBar = null;
        this.viewStack.dispose();
        this.viewStack = null;
        this.typeIcon.dispose();
        this.typeIcon = null;
        this.tabsBg = null;
        this.vNameTF = null;
        this._scheduler = null;
        super.onDispose();
    }

    public function enableAwardsButton(param1:Boolean):void {
        if (!param1) {
            this.buttonBar.selectedIndex = 0;
        }
        var _loc2_:Button = this.buttonBar.getButtonAt(1);
        if (_loc2_) {
            _loc2_.enabled = param1;
        }
    }

    public function setViewSize(param1:Number, param2:Number):void {
        this.tabsBg.scrollRect = new Rectangle(0, 0, this.tabsBg.width, param2);
        this.viewStack.setAvailableSize(param1 - this.viewStack.x, param2 - this.viewStack.y);
    }

    public function updateLabel(param1:String, param2:String):void {
        this.vNameTF.htmlText = param1;
        if (param2 != null) {
            this.typeIcon.source = param2;
        }
        else {
            this.typeIcon.unload();
        }
    }

    public function updateTankData(param1:Object):void {
        this.viewStack.updateData(param1);
        if (this._resizeTask != null) {
            this._scheduler.cancelTask(this._resizeTask);
        }
        this._resizeTask = ResizableContent(this.viewStack.currentView).applyResizing;
        this._scheduler.scheduleOnNextFrame(this._resizeTask);
    }
}
}
