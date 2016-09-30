package net.wg.gui.lobby.settings.feedback {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.gfx.TextFieldEx;

public class SettingsDamageLogContainer extends MovieClip implements IDisposable {

    private static const DETAIL_BLOCK_MAX_HEIGHT:int = 162;

    public var summaryDamageLogDamage:SettingsSummaryDamageLog = null;

    public var summaryDamageLogAssist:SettingsSummaryDamageLog = null;

    public var summaryDamageLogBlocked:SettingsSummaryDamageLog = null;

    public var detailsDamageLog:SettingsDetailsDamageLog = null;

    public var infoTextTF:TextField = null;

    private var _summariesBlocks:Vector.<SettingsSummaryDamageLog> = null;

    private var _yStep:int = 23;

    public function SettingsDamageLogContainer() {
        super();
        TextFieldEx.setVerticalAlign(this.infoTextTF, TextFieldEx.VALIGN_CENTER);
        this.infoTextTF.text = SETTINGS.FEEDBACK_TAB_DETAILSINFOBLOCK;
        this.infoTextTF.visible = false;
        this._summariesBlocks = new <SettingsSummaryDamageLog>[this.summaryDamageLogDamage, this.summaryDamageLogBlocked, this.summaryDamageLogAssist];
        this.summaryDamageLogDamage.gotoAndStop(1);
        this.summaryDamageLogAssist.gotoAndStop(2);
        this.summaryDamageLogBlocked.gotoAndStop(3);
        this.detailsDamageLog.gotoAndStop(1);
    }

    public function dispose():void {
        this.summaryDamageLogDamage = null;
        this.summaryDamageLogAssist = null;
        this.summaryDamageLogBlocked = null;
        this.detailsDamageLog = null;
        this.infoTextTF = null;
        this._summariesBlocks = null;
    }

    public function update(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean):void {
        var _loc9_:Boolean = false;
        var _loc10_:SettingsSummaryDamageLog = null;
        var _loc11_:int = 0;
        var _loc5_:Array = [param1, param2, param3];
        var _loc6_:int = 0;
        var _loc7_:int = 0;
        var _loc8_:int = 1;
        for each(_loc9_ in _loc5_) {
            _loc10_ = this._summariesBlocks[_loc6_];
            if (_loc9_) {
                _loc10_.visible = true;
                _loc10_.y = _loc7_;
                _loc7_ = _loc7_ + this._yStep;
            }
            else {
                _loc10_.visible = false;
                _loc10_.y = 0;
                _loc8_++;
            }
            _loc6_++;
        }
        if (param4) {
            this.detailsDamageLog.visible = true;
            this.infoTextTF.visible = true;
            this.detailsDamageLog.gotoAndStop(_loc8_);
            _loc11_ = this.detailsDamageLog.y + (DETAIL_BLOCK_MAX_HEIGHT - this.detailsDamageLog.height);
            this.infoTextTF.y = _loc11_ + (this.detailsDamageLog.height - this.infoTextTF.height >> 1);
        }
        else {
            this.infoTextTF.visible = false;
            this.detailsDamageLog.visible = false;
        }
    }
}
}
