package net.wg.gui.lobby.quests.components.renderers {
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.gui.components.controls.TableRenderer;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestChainVO;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestTaskListRendererVO;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestTaskVO;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestTileStatisticsVO;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;

public class QuestTaskListItemRenderer extends TableRenderer {

    public var mainLabel:TextField;

    public var taskChainProgress:TextField;

    public var taskStatus:TextField;

    public var taskStatusIcon:UILoaderAlt;

    public var arrow:UILoaderAlt;

    private var _rendererVO:QuestTaskListRendererVO;

    public function QuestTaskListItemRenderer() {
        super();
    }

    override public function setData(param1:Object):void {
        super.setData(param1);
        this._rendererVO = param1 as QuestTaskListRendererVO;
        if (param1 != null) {
            App.utils.asserter.assertNotNull(this._rendererVO, "data must be QuestTaskListRendererVO");
        }
        invalidateData();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            this.clearView();
            this.setView();
            updateDisable(!enabled && this.isNotChain());
        }
        if (isInvalid(InvalidationType.STATE)) {
            this.arrow.visible = selected && this.isNotChain();
        }
    }

    private function isNotChain():Boolean {
        return this._rendererVO != null && this._rendererVO.type != QuestTaskListRendererVO.CHAIN;
    }

    override protected function onDispose():void {
        this.arrow.dispose();
        this.taskStatusIcon.dispose();
        if (this._rendererVO != null) {
            this._rendererVO.dispose();
        }
        this.mainLabel = null;
        this.taskChainProgress = null;
        this.taskStatus = null;
        this.arrow = null;
        this.taskStatusIcon = null;
        this._rendererVO = null;
        super.onDispose();
    }

    private function setView():void {
        var _loc1_:Boolean = false;
        var _loc2_:QuestTileStatisticsVO = null;
        var _loc3_:QuestChainVO = null;
        var _loc4_:QuestTaskVO = null;
        if (this._rendererVO != null) {
            switch (this._rendererVO.type) {
                case QuestTaskListRendererVO.STATISTICS:
                    _loc2_ = this._rendererVO.statData;
                    if (_loc2_ != null) {
                        this.mainLabel.htmlText = _loc2_.label;
                        this.arrow.source = _loc2_.arrowIconPath;
                        this.mainLabel.visible = true;
                        this.arrow.visible = true;
                    }
                    break;
                case QuestTaskListRendererVO.CHAIN:
                    _loc3_ = this._rendererVO.chainData;
                    if (_loc3_ != null) {
                        this.mainLabel.htmlText = _loc3_.name;
                        this.taskChainProgress.htmlText = _loc3_.progressText;
                        this.mainLabel.visible = true;
                        this.taskChainProgress.visible = true;
                    }
                    break;
                case QuestTaskListRendererVO.TASK:
                    _loc4_ = this._rendererVO.taskData;
                    if (_loc4_ != null) {
                        this.mainLabel.htmlText = _loc4_.name;
                        this.taskStatus.htmlText = _loc4_.stateName;
                        this.taskStatusIcon.source = _loc4_.stateIconPath;
                        this.arrow.source = _loc4_.arrowIconPath;
                        this.mainLabel.visible = true;
                        this.arrow.visible = true;
                        this.taskStatusIcon.visible = StringUtils.isNotEmpty(_loc4_.stateIconPath);
                        this.taskStatus.visible = true;
                    }
            }
            _loc1_ = this.isNotChain();
            enabled = this._rendererVO.enabled;
            this.updateMouseEnabled();
            this.arrow.visible = _loc1_;
            if (rendererBg != null) {
                rendererBg.visible = _loc1_;
            }
        }
    }

    private function updateMouseEnabled():void {
        mouseEnabled = this.isNotChain() && enabled;
    }

    private function clearView():void {
        this.taskChainProgress.visible = false;
        this.taskStatus.visible = false;
        rendererBg.visible = false;
        this.mainLabel.visible = false;
        this.arrow.visible = false;
        this.taskStatusIcon.visible = false;
    }

    override public function set selected(param1:Boolean):void {
        if (param1 && !selected) {
            App.toolTipMgr.hide();
        }
        super.selected = param1;
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
        super.handleMouseRollOver(param1);
        if (!selected && this._rendererVO != null && this._rendererVO.tooltip != null) {
            App.toolTipMgr.show(this._rendererVO.tooltip);
        }
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
        super.handleMouseRollOut(param1);
        App.toolTipMgr.hide();
    }
}
}
