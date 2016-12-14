package net.wg.gui.lobby.techtree.helpers {
import flash.display.DisplayObject;
import flash.geom.Point;

import net.wg.gui.components.controls.SoundListItemRenderer;
import net.wg.gui.lobby.techtree.TechTreeEvent;
import net.wg.gui.lobby.techtree.constants.ColorIndex;
import net.wg.gui.lobby.techtree.data.state.NodeStateCollection;
import net.wg.gui.lobby.techtree.interfaces.IRenderer;
import net.wg.gui.lobby.techtree.interfaces.IResearchContainer;

public class ModulesGraphics extends LinesGraphics {

    private static const OUTGOING_LINES_LITERAL:String = "lines";

    private static const TOP_LINES_LITERAL:String = "topLines";

    public var xRatio:Number = 0;

    public var rootRenderer:SoundListItemRenderer;

    public function ModulesGraphics() {
        super();
    }

    override public function clearUp():void {
        super.clearUp();
        var _loc1_:int = 0;
        if (this.rootRenderer != null) {
            _loc1_++;
        }
        this.removeExtraRenderers(_loc1_);
    }

    override public function clearUpRenderer(param1:IRenderer):void {
        param1.removeEventListener(TechTreeEvent.STATE_CHANGED, this.onTopLevelRendererStateChangedHandler);
        param1.removeEventListener(TechTreeEvent.STATE_CHANGED, this.onRendererStateChangedHandler);
    }

    override protected function onDispose():void {
        this.clearUp();
        this.rootRenderer = null;
        _container = null;
        super.onDispose();
    }

    public function drawOutgoingLines(param1:IRenderer, param2:Vector.<IRenderer>, param3:Boolean, param4:Boolean):void {
        var _loc12_:Point = null;
        var _loc13_:IRenderer = null;
        var _loc5_:Number = param2.length;
        if (_loc5_ == 0) {
            return;
        }
        clearLinesAndArrows(param1, OUTGOING_LINES_LITERAL);
        var _loc6_:Point = new Point(param1.getOutX(), param1.getY());
        var _loc7_:Point = new Point(_loc6_.x + this.xRatio, _loc6_.y);
        var _loc8_:Array = [];
        var _loc9_:Array = [];
        var _loc10_:Object = null;
        var _loc11_:ResearchLineInfo = null;
        var _loc14_:Number = 0;
        while (_loc14_ < _loc5_) {
            _loc13_ = param2[_loc14_];
            if (_loc13_ != null) {
                _loc12_ = new Point(_loc13_.getInX() - lineRatio, _loc13_.getY());
                _loc11_ = new ResearchLineInfo(param1, _loc13_, _loc12_, !_loc13_.isFake());
                if (_loc6_.y > _loc12_.y) {
                    _loc8_.push(_loc11_);
                }
                else if (_loc6_.y < _loc12_.y) {
                    _loc9_.push(_loc11_);
                }
                else if (_loc6_.y == _loc12_.y) {
                    _loc10_ = _loc11_;
                }
            }
            _loc14_++;
        }
        var _loc15_:Number = ColorIndex.DEFAULT;
        var _loc16_:Number = this.drawUpLines(_loc8_, _loc7_, param3, param4, false);
        var _loc17_:Number = this.drawDownLines(_loc9_, _loc7_, param3, param4, false);
        if (_loc10_ != null) {
            _loc13_ = _loc10_.child;
            if (param4) {
                _loc15_ = _loc13_.getColorIdxEx(param1);
            }
            if (_loc5_ == 1) {
                drawLine(param1, colorIdxs[_loc15_], _loc6_, _loc10_.point, OUTGOING_LINES_LITERAL);
                if (_loc10_.drawArrow) {
                    drawArrowEx(param1, colorIdxs[_loc15_], _loc6_, _loc10_.point, OUTGOING_LINES_LITERAL);
                }
            }
            else {
                drawLine(param1, colorIdxs[_loc15_], new Point(_loc7_.x + lineRatio, _loc6_.y), _loc10_.point, OUTGOING_LINES_LITERAL);
                if (_loc10_.drawArrow) {
                    drawArrowEx(param1, colorIdxs[_loc15_], _loc7_, _loc10_.point, OUTGOING_LINES_LITERAL);
                }
                _loc16_ = Math.min(_loc15_, _loc16_);
            }
            if (!param3) {
                this.addNodeStateChangedListener(_loc13_);
            }
        }
        if (_loc5_ > 1 || _loc10_ == null) {
            drawLine(param1, colorIdxs[Math.min(_loc16_, _loc17_)], _loc6_, _loc7_, OUTGOING_LINES_LITERAL);
        }
    }

    public function drawTopLevelLines(param1:IRenderer, param2:Vector.<IRenderer>, param3:Boolean):void {
        var _loc5_:Point = null;
        var _loc8_:IRenderer = null;
        var _loc16_:Number = NaN;
        var _loc4_:Number = param2.length;
        if (_loc4_ == 0 || param1 == null) {
            return;
        }
        clearLinesAndArrows(param1, TOP_LINES_LITERAL);
        if (!param3) {
            this.addTopStateChangedListener(param1);
        }
        var _loc6_:Point = new Point(param1.getInX(), param1.getY());
        var _loc7_:Point = new Point(_loc6_.x - this.xRatio, _loc6_.y);
        var _loc9_:Array = [];
        var _loc10_:Array = [];
        var _loc11_:Object = null;
        var _loc12_:ResearchLineInfo = null;
        var _loc13_:Number = 0;
        while (_loc13_ < _loc4_) {
            _loc8_ = param2[_loc13_];
            if (_loc8_ != null) {
                clearLinesAndArrows(_loc8_);
                _loc5_ = new Point(_loc8_.getOutX(), _loc8_.getY());
                _loc12_ = new ResearchLineInfo(_loc8_, param1, _loc5_, false);
                if (_loc5_.y < _loc6_.y) {
                    _loc9_.push(_loc12_);
                }
                else if (_loc5_.y > _loc6_.y) {
                    _loc10_.push(_loc12_);
                }
                else if (_loc5_.y == _loc6_.y) {
                    _loc12_.drawArrow = true;
                    _loc11_ = _loc12_;
                }
            }
            _loc13_++;
        }
        var _loc14_:Number = this.drawUpLines(_loc9_, _loc7_, param3, true, true);
        var _loc15_:Number = this.drawDownLines(_loc10_, _loc7_, param3, true, true);
        if (_loc11_ != null) {
            _loc8_ = _loc11_.parent;
            _loc16_ = param1.getColorIdx(_loc11_.parent.getID());
            if (_loc4_ == 1) {
                drawLine(_loc8_, colorIdxs[_loc16_], _loc11_.point, _loc6_, OUTGOING_LINES_LITERAL);
                drawArrowEx(_loc8_, colorIdxs[_loc16_], _loc11_.point, _loc6_, OUTGOING_LINES_LITERAL);
            }
            else {
                drawLine(_loc8_, colorIdxs[_loc16_], _loc11_.point, _loc7_, OUTGOING_LINES_LITERAL);
                _loc14_ = Math.min(_loc16_, _loc14_);
            }
            if (!param3) {
                this.addTopStateChangedListener(_loc8_);
            }
        }
        if (_loc4_ > 1 || _loc11_ == null) {
            _loc16_ = Math.min(_loc14_, _loc15_);
            drawLine(param1, colorIdxs[_loc16_], _loc7_, _loc6_, TOP_LINES_LITERAL);
            drawArrowEx(param1, colorIdxs[_loc16_], _loc7_, _loc6_, TOP_LINES_LITERAL);
            if (!param3) {
                this.addTopStateChangedListener(param1);
            }
        }
    }

    protected function removeExtraRenderers(param1:int):void {
        var _loc2_:DisplayObject = null;
        var _loc3_:Number = 0;
        while (numChildren > param1) {
            _loc2_ = getChildAt(_loc3_);
            if (_loc2_ != this.rootRenderer) {
                if (_loc2_ is IRenderer) {
                    this.clearUpRenderer(IRenderer(_loc2_));
                }
                removeChildAt(_loc3_);
            }
            else {
                _loc3_++;
            }
        }
    }

    private function drawUpLines(param1:Array, param2:Point, param3:Boolean, param4:Boolean, param5:Boolean):Number {
        var _loc7_:IRenderer = null;
        var _loc8_:IRenderer = null;
        var _loc11_:Point = null;
        var _loc12_:Point = null;
        var _loc13_:ResearchLineInfo = null;
        var _loc6_:Number = param1.length;
        var _loc9_:Number = ColorIndex.DEFAULT;
        var _loc10_:Number = ColorIndex.DEFAULT;
        param1.sortOn("y", Array.NUMERIC);
        var _loc14_:Number = 0;
        while (_loc14_ < _loc6_) {
            _loc13_ = param1[_loc14_];
            _loc8_ = _loc13_.child;
            _loc7_ = _loc13_.parent;
            if (param4) {
                _loc10_ = _loc8_.getColorIdxEx(_loc7_);
                _loc9_ = Math.min(_loc9_, _loc10_);
            }
            _loc11_ = new Point(param2.x, _loc13_.point.y);
            _loc12_ = new Point(param2.x, (_loc14_ == _loc6_ - 1 ? param2.y : param1[_loc14_ + 1].point.y) - lineThickness);
            drawLine(_loc7_, colorIdxs[_loc10_], _loc11_, _loc13_.point, OUTGOING_LINES_LITERAL);
            if (_loc13_.drawArrow) {
                drawArrowEx(_loc7_, colorIdxs[_loc10_], _loc11_, _loc13_.point, OUTGOING_LINES_LITERAL);
            }
            drawLine(_loc7_, colorIdxs[_loc9_], _loc11_, _loc12_, OUTGOING_LINES_LITERAL);
            if (!param3) {
                if (param5) {
                    this.addTopStateChangedListener(_loc7_);
                }
                else {
                    this.addNodeStateChangedListener(_loc8_);
                }
            }
            _loc14_++;
        }
        return _loc9_;
    }

    private function drawDownLines(param1:Array, param2:Point, param3:Boolean, param4:Boolean, param5:Boolean):Number {
        var _loc7_:IRenderer = null;
        var _loc8_:IRenderer = null;
        var _loc11_:Point = null;
        var _loc12_:Point = null;
        var _loc13_:ResearchLineInfo = null;
        var _loc6_:Number = param1.length;
        var _loc9_:Number = ColorIndex.DEFAULT;
        var _loc10_:Number = ColorIndex.DEFAULT;
        param1.sortOn("y", Array.NUMERIC | Array.DESCENDING);
        var _loc14_:Number = 0;
        while (_loc14_ < _loc6_) {
            _loc13_ = param1[_loc14_];
            _loc8_ = _loc13_.child;
            _loc7_ = _loc13_.parent;
            if (param4) {
                _loc10_ = _loc8_.getColorIdxEx(_loc7_);
                _loc9_ = Math.min(_loc9_, _loc10_);
            }
            _loc11_ = new Point(param2.x, _loc13_.point.y);
            _loc12_ = new Point(param2.x, (_loc14_ == _loc6_ - 1 ? param2.y : param1[_loc14_ + 1].point.y) + lineThickness);
            drawLine(_loc7_, colorIdxs[_loc9_], _loc11_, _loc12_, OUTGOING_LINES_LITERAL);
            drawLine(_loc7_, colorIdxs[_loc10_], _loc11_, _loc13_.point, OUTGOING_LINES_LITERAL);
            if (_loc13_.drawArrow) {
                drawArrowEx(_loc7_, colorIdxs[_loc10_], _loc11_, _loc13_.point, OUTGOING_LINES_LITERAL);
            }
            if (!param3) {
                if (param5) {
                    this.addTopStateChangedListener(_loc7_);
                }
                else {
                    this.addNodeStateChangedListener(_loc8_);
                }
            }
            _loc14_++;
        }
        return _loc9_;
    }

    private function addNodeStateChangedListener(param1:IRenderer):void {
        param1.addEventListener(TechTreeEvent.STATE_CHANGED, this.onRendererStateChangedHandler, false, 0, true);
    }

    private function addTopStateChangedListener(param1:IRenderer):void {
        param1.addEventListener(TechTreeEvent.STATE_CHANGED, this.onTopLevelRendererStateChangedHandler, false, 0, true);
    }

    public function get containerEx():IResearchContainer {
        return IResearchContainer(_container);
    }

    private function onTopLevelRendererStateChangedHandler(param1:TechTreeEvent):void {
        if (NodeStateCollection.isRedrawResearchLines(param1.primary)) {
            this.drawTopLevelLines(IRenderer(this.rootRenderer), this.containerEx.getTopLevel(), true);
        }
    }

    private function onRendererStateChangedHandler(param1:TechTreeEvent):void {
        var _loc2_:IRenderer = null;
        var _loc3_:Boolean = false;
        var _loc4_:Vector.<IRenderer> = null;
        var _loc5_:IRenderer = null;
        var _loc6_:uint = 0;
        var _loc7_:Number = NaN;
        if (NodeStateCollection.isRedrawResearchLines(param1.primary)) {
            _loc2_ = param1.target as IRenderer;
            _loc3_ = this.containerEx.isRootUnlocked();
            if (_loc2_ != null) {
                _loc4_ = this.containerEx.getParents(_loc2_);
                _loc6_ = _loc4_.length;
                _loc7_ = 0;
                while (_loc7_ < _loc6_) {
                    _loc5_ = _loc4_[_loc7_];
                    this.drawOutgoingLines(_loc5_, this.containerEx.getChildren(_loc5_), true, _loc3_);
                    _loc7_++;
                }
                this.drawOutgoingLines(_loc2_, this.containerEx.getChildren(_loc2_), true, _loc3_);
            }
        }
    }
}
}

import flash.geom.Point;

import net.wg.gui.lobby.techtree.interfaces.IRenderer;

class ResearchLineInfo {

    public var point:Point;

    public var parent:IRenderer;

    public var child:IRenderer;

    public var drawArrow:Boolean;

    function ResearchLineInfo(param1:IRenderer, param2:IRenderer, param3:Point, param4:Boolean) {
        super();
        this.parent = param1;
        this.child = param2;
        this.point = param3;
        this.drawArrow = param4;
    }

    public function get y():Number {
        return this.point.y;
    }
}
