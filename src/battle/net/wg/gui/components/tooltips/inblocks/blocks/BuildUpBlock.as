package net.wg.gui.components.tooltips.inblocks.blocks {
import flash.display.DisplayObject;
import flash.display.Sprite;

import net.wg.data.VO.PaddingVO;
import net.wg.data.constants.Errors;
import net.wg.gui.components.tooltips.inblocks.TooltipInBlocksUtils;
import net.wg.gui.components.tooltips.inblocks.data.BlockDataItemVO;
import net.wg.gui.components.tooltips.inblocks.data.BuildUpBlockVO;
import net.wg.gui.components.tooltips.inblocks.events.ToolTipBlockEvent;
import net.wg.gui.components.tooltips.inblocks.interfaces.ITooltipBlock;
import net.wg.infrastructure.interfaces.pool.IPoolItem;

public class BuildUpBlock extends BaseTooltipBlock implements IPoolItem {

    public var background:Sprite;

    private var _blocks:Vector.<ITooltipBlock>;

    private var _blockWidth:int = 0;

    private var _gap:int = 0;

    private var _blockData:BuildUpBlockVO;

    private var _height:Number;

    public function BuildUpBlock() {
        super();
    }

    override public function cleanUp():void {
        this.clearBlocks();
        this.clearData();
    }

    override public function getBg():DisplayObject {
        return this.background;
    }

    override public function getStretchBg():Boolean {
        return this._blockData.stretchBg;
    }

    override public function getHeight():Number {
        return this._height;
    }

    override public function setBlockData(param1:Object):void {
        this.clearData();
        this._blockData = new BuildUpBlockVO(param1);
        if (this._blockData.blocksData == null) {
            App.utils.asserter.assert(false, "Blocks data" + Errors.CANT_EMPTY);
        }
        invalidateBlock();
    }

    override public function setBlockWidth(param1:int):void {
        this._blockWidth = param1;
    }

    override protected function onDispose():void {
        this.cleanUp();
        this.background = null;
        super.onDispose();
    }

    override protected function onValidateBlock():Boolean {
        if (!this.isBlocksBuilt()) {
            this.buildBlocks();
        }
        else if (this.isInvalidBlocks()) {
            this.tryValidateBlocks();
        }
        else {
            this.rearrangeBlocks();
            return false;
        }
        return true;
    }

    private function rearrangeBlocks():void {
        var _loc2_:ITooltipBlock = null;
        var _loc3_:DisplayObject = null;
        var _loc4_:PaddingVO = null;
        var _loc5_:* = false;
        var _loc7_:int = 0;
        var _loc1_:Number = 0;
        var _loc6_:Vector.<BlockDataItemVO> = this._blockData.blocksData;
        var _loc8_:int = this._blocks.length;
        _loc7_ = 0;
        while (_loc7_ < _loc8_) {
            _loc2_ = this._blocks[_loc7_];
            _loc4_ = _loc6_[_loc7_].padding;
            _loc5_ = _loc4_ != null;
            _loc1_ = _loc1_ + ((!!_loc5_ ? _loc4_.top : 0) + (_loc7_ > 0 ? this._gap : 0));
            _loc3_ = _loc2_.getDisplayObject();
            _loc3_.x = !!_loc5_ ? Number(_loc4_.left) : Number(0);
            _loc3_.y = _loc1_ | 0;
            _loc1_ = _loc1_ + (_loc2_.getHeight() + (!!_loc5_ ? _loc4_.bottom : 0));
            _loc7_++;
        }
        this._height = _loc1_;
    }

    private function isBlocksBuilt():Boolean {
        return this._blocks != null && this._blocks.length > 0;
    }

    private function tryValidateBlocks():void {
        var _loc1_:ITooltipBlock = null;
        for each(_loc1_ in this._blocks) {
            if (_loc1_.isBlockInvalid()) {
                _loc1_.tryValidateBlock();
            }
        }
    }

    private function isInvalidBlocks():Boolean {
        var _loc1_:ITooltipBlock = null;
        for each(_loc1_ in this._blocks) {
            if (_loc1_.isBlockInvalid()) {
                return true;
            }
        }
        return false;
    }

    private function clearData():void {
        if (this._blockData != null) {
            this._blockData.dispose();
            this._blockData = null;
        }
    }

    private function buildBlocks():void {
        var _loc1_:ITooltipBlock = null;
        var _loc2_:DisplayObject = null;
        var _loc3_:BlockDataItemVO = null;
        var _loc8_:PaddingVO = null;
        this._gap = this._blockData.gap;
        this.clearBlocks();
        var _loc4_:Vector.<BlockDataItemVO> = this._blockData.blocksData;
        var _loc5_:int = _loc4_.length;
        var _loc6_:int = 0;
        var _loc7_:TooltipInBlocksUtils = TooltipInBlocksUtils.instance;
        this._blocks = new Vector.<ITooltipBlock>(_loc5_, true);
        while (_loc6_ < _loc5_) {
            _loc3_ = _loc4_[_loc6_];
            _loc8_ = _loc3_.padding;
            _loc1_ = _loc7_.createBlock(_loc3_.linkage);
            _loc1_.addEventListener(ToolTipBlockEvent.SIZE_CHANGE, this.onBlockSizeChangeHandler);
            this._blocks[_loc6_] = _loc1_;
            if (this._blockWidth > 0) {
                _loc1_.setBlockWidth(this._blockWidth - (_loc8_ != null ? _loc8_.left + _loc8_.right : 0));
            }
            _loc1_.setBlockData(_loc3_.data);
            _loc2_ = _loc1_.getDisplayObject();
            addChild(_loc2_);
            _loc6_++;
        }
    }

    private function clearBlocks():void {
        var _loc1_:ITooltipBlock = null;
        if (this._blocks != null) {
            for each(_loc1_ in this._blocks) {
                _loc1_.removeEventListener(ToolTipBlockEvent.SIZE_CHANGE, this.onBlockSizeChangeHandler);
                removeChild(_loc1_.getDisplayObject());
                _loc1_.dispose();
            }
            this._blocks.fixed = false;
            this._blocks.splice(0, this._blocks.length);
            this._blocks = null;
        }
    }

    private function onBlockSizeChangeHandler(param1:ToolTipBlockEvent):void {
        invalidateBlock();
        dispatchEvent(new ToolTipBlockEvent(ToolTipBlockEvent.SIZE_CHANGE, this));
    }
}
}
