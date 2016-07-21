package net.wg.gui.battle.views.ribbonsPanel {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.gui.battle.views.ribbonsPanel.containers.Title;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class RibbonTitleAnimation extends MovieClip implements IDisposable {

    private static const NORMAL_LBL:String = "normal";

    private static const CHANGE_COUNT_LBL:String = "changeCount";

    private static const CHANGE_COUNT_END_FRAME:int = 18;

    public var titleItem:Title = null;

    public var titleItem2:Title = null;

    public var titleTF:TextField = null;

    public var title2TF:TextField = null;

    public var title:String;

    public var count:int = 0;

    private var _multiSeparator:String = "";

    public function RibbonTitleAnimation() {
        super();
        this.titleTF = this.titleItem.tf;
        this.title2TF = this.titleItem2.tf;
        addFrameScript(CHANGE_COUNT_END_FRAME, this.changeCount);
        this._multiSeparator = App.utils.locale.makeString(INGAME_GUI.COUNTRIBBONS_MULTISEPARATOR);
    }

    public function setData(param1:String, param2:int):void {
        this.title = param1;
        this.count = param2;
        this.titleTF.text = this.getCurTitle();
        gotoAndPlay(NORMAL_LBL);
    }

    public function reset():void {
        gotoAndStop(NORMAL_LBL);
    }

    public function incCount(param1:int):void {
        this.count = this.count + param1;
        this.startIncAnimation();
    }

    private function getCurTitle():String {
        if (this.count == 1) {
            return this.title;
        }
        return this.title + this._multiSeparator + this.count;
    }

    private function changeCount():void {
        this.titleTF.text = this.title2TF.text;
        gotoAndPlay(NORMAL_LBL);
    }

    private function startIncAnimation():void {
        this.title2TF.text = this.getCurTitle();
        gotoAndPlay(CHANGE_COUNT_LBL);
    }

    public function dispose():void {
        this.titleItem.dispose();
        this.titleItem = null;
        this.titleItem2.dispose();
        this.titleItem2 = null;
        this.titleTF = null;
        this.title2TF = null;
    }
}
}
