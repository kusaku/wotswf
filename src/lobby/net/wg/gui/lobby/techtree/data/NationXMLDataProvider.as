package net.wg.gui.lobby.techtree.data {
import flash.geom.Point;

import net.wg.gui.lobby.techtree.constants.NodeName;
import net.wg.gui.lobby.techtree.data.vo.NTDisplayInfo;
import net.wg.gui.lobby.techtree.data.vo.NationDisplaySettings;
import net.wg.gui.lobby.techtree.data.vo.NodeData;
import net.wg.gui.lobby.techtree.data.vo.ShopPrice;
import net.wg.gui.lobby.techtree.data.vo.UnlockProps;

public class NationXMLDataProvider extends NationVODataProvider {

    public function NationXMLDataProvider() {
        super();
    }

    override public function parse(param1:Object):void {
        var _loc5_:Number = NaN;
        var _loc6_:XML = null;
        var _loc8_:NodeData = null;
        clearUp();
        var _loc2_:String = String(param1);
        var _loc3_:XML = new XML(_loc2_);
        _loc3_.ignoreWhite = true;
        var _loc4_:XML = _loc3_.children()[0];
        for each(_loc6_ in _loc4_.children()) {
            _loc8_ = this.getNodeData(_loc6_);
            _loc5_ = nodeData.length;
            if (!isNaN(_loc8_.id)) {
                nodeIdxCache[_loc8_.id] = _loc5_;
                nodeData.push(_loc8_);
            }
        }
        _loc5_ = _loc3_.children()[1].text();
        if (_loc5_ > -1) {
            _scrollIndex = _loc5_;
        }
        var _loc7_:XML = _loc3_.children()[2];
        _displaySettings = new NationDisplaySettings(_loc7_.child(NodeName.NODE_RENDERER_NAME).text(), _loc7_.child(NodeName.IS_LEVEL_DISPLAYED).text());
    }

    private function getNodeDisplayInfo(param1:XML):NTDisplayInfo {
        var _loc3_:Object = null;
        var _loc4_:Object = null;
        var _loc5_:XML = null;
        var _loc6_:XML = null;
        var _loc7_:XML = null;
        var _loc2_:Array = [];
        for each(_loc5_ in param1.child(NodeName.LINES).children()) {
            _loc4_ = {
                "outLiteral": _loc5_.child(NodeName.OUT_LITERAL).text(),
                "outPin": [_loc5_.child(NodeName.OUT_PIN).child(NodeName.X).text(), _loc5_.child(NodeName.OUT_PIN).child(NodeName.Y).text()],
                "inPins": []
            };
            for each(_loc6_ in _loc5_.child(NodeName.IN_PINS).children()) {
                _loc3_ = {
                    "childID": _loc6_.child(NodeName.CHILD_ID).text(),
                    "inPin": [_loc6_.child(NodeName.IN_PIN).child(NodeName.X).text(), _loc6_.child(NodeName.IN_PIN).child(NodeName.Y).text()],
                    "viaPins": []
                };
                for each(_loc7_ in _loc6_.child(NodeName.VIA_PINS).children()) {
                    _loc3_.viaPins.push([_loc7_.child(NodeName.X).text(), _loc7_.child(NodeName.Y).text()]);
                }
                _loc4_.inPins.push(_loc3_);
            }
            _loc2_.push(_loc4_);
        }
        return new NTDisplayInfo(param1.child(NodeName.ROW).text(), param1.child(NodeName.COLUMN).text(), new Point(param1.child(NodeName.POSITION).child(NodeName.X).text(), param1.child(NodeName.POSITION).child(NodeName.Y).text()), _loc2_);
    }

    private function getNodeData(param1:XML):NodeData {
        var _loc4_:XML = null;
        var _loc2_:NodeData = new NodeData();
        var _loc3_:Array = [];
        for each(_loc4_ in param1.child(NodeName.UNLOCK_PROPS).child(NodeName.TOP_IDS).children()) {
            _loc3_.push(Number(_loc4_.toString()));
        }
        _loc2_.id = param1.child(NodeName.ID).text();
        _loc2_.nameString = param1.child(NodeName.NAME_STRING).text();
        _loc2_.primaryClassName = param1.child(NodeName.CLASS).child(NodeName.NAME).text();
        _loc2_.level = int(param1.child(NodeName.LEVEL).text());
        _loc2_.earnedXP = param1.child(NodeName.EARNED_XP).text();
        _loc2_.state = param1.child(NodeName.STATE).text();
        _loc2_.unlockProps = new UnlockProps(param1.child(NodeName.UNLOCK_PROPS).child(NodeName.PARENT_ID).text(), param1.child(NodeName.UNLOCK_PROPS).child(NodeName.UNLOCK_IDX).text(), param1.child(NodeName.UNLOCK_PROPS).child(NodeName.XP_COST).text(), _loc3_);
        _loc2_.iconPath = param1.child(NodeName.ICON_PATH).text();
        _loc2_.smallIconPath = param1.child(NodeName.SMALL_ICON_PATH).text();
        _loc2_.longName = param1.child(NodeName.LONG_NAME).text();
        _loc2_.shopPrice = new ShopPrice(param1.child(NodeName.SHOP_PRICE).child(NodeName.CREDITS).text(), param1.child(NodeName.SHOP_PRICE).child(NodeName.GOLD).text());
        _loc2_.displayInfo = this.getNodeDisplayInfo(param1.child(NodeName.DISPLAY)[0]);
        return _loc2_;
    }
}
}
