package net.wg.gui.lobby.techtree.data {
import net.wg.gui.lobby.techtree.constants.NodeName;
import net.wg.gui.lobby.techtree.data.vo.ExtraInformation;
import net.wg.gui.lobby.techtree.data.vo.NodeData;
import net.wg.gui.lobby.techtree.data.vo.ResearchDisplayInfo;
import net.wg.gui.lobby.techtree.data.vo.ShopPrice;
import net.wg.gui.lobby.techtree.data.vo.UnlockProps;
import net.wg.gui.lobby.techtree.data.vo.VehGlobalStats;

public class ResearchXMLDataProvider extends ResearchVODataProvider {

    public function ResearchXMLDataProvider() {
        super();
    }

    override public function parse(param1:Object):void {
        var _loc5_:Number = NaN;
        var _loc6_:XML = null;
        var _loc7_:NodeData = null;
        var _loc8_:ResearchDisplayInfo = null;
        cleanUp();
        NodeData.setDisplayInfoClass(ResearchDisplayInfo);
        var _loc2_:String = String(param1);
        var _loc3_:XML = new XML(_loc2_);
        _loc3_.ignoreWhite = true;
        var _loc4_:XML = _loc3_.children()[0];
        for each(_loc6_ in _loc4_.children()) {
            _loc7_ = this.getNodeData(_loc6_);
            _loc5_ = topData.length;
            if (!isNaN(_loc7_.id)) {
                topLevelIdxCache[_loc7_.id] = _loc5_;
                topData.push(_loc7_);
            }
        }
        _loc4_ = _loc3_.children()[1];
        for each(_loc6_ in _loc4_.children()) {
            _loc7_ = this.getNodeData(_loc6_);
            _loc5_ = nodeData.length;
            if (!isNaN(_loc7_.id)) {
                nodeIdxCache[_loc7_.id] = _loc5_;
                nodeData.push(_loc7_);
                _loc8_ = _loc7_.displayInfo as ResearchDisplayInfo;
                depthOfPaths.push(_loc8_ != null ? _loc8_.getDepthOfPath() : 0);
            }
        }
        _loc4_ = _loc3_.children()[2];
        global = new VehGlobalStats(Number(_loc4_.child(NodeName.ENABLE_INSTALL_ITEMS).text()) == 1, _loc4_.child(NodeName.STATUS_STRING).text(), new ExtraInformation(_loc4_.child(NodeName.EXTRA_INFO).child(NodeName.TYPE).text(), _loc4_.child(NodeName.EXTRA_INFO).child(NodeName.TITLE).text(), _loc4_.child(NodeName.EXTRA_INFO).child(NodeName.BENEFITS_HEAD).text(), _loc4_.child(NodeName.EXTRA_INFO).child(NodeName.BENEFITS_LIST).text()), _loc4_.child(NodeName.FREE_XP).text(), Number(_loc4_.child(NodeName.HAS_NATION_TREE).text()) == 1);
    }

    private function getNodeDisplayInfo(param1:XML):ResearchDisplayInfo {
        var _loc3_:XML = null;
        var _loc2_:Array = [];
        for each(_loc3_ in param1.child(NodeName.PATH).children()) {
            _loc2_.push(_loc3_.text());
        }
        return new ResearchDisplayInfo(_loc2_, param1.child(NodeName.RENDERER).text(), param1.child(NodeName.LEVEL).text());
    }

    private function getNodeData(param1:XML):NodeData {
        var _loc2_:NodeData = null;
        var _loc4_:XML = null;
        _loc2_ = new NodeData();
        var _loc3_:Array = [];
        for each(_loc4_ in param1.child(NodeName.UNLOCK_PROPS).child(NodeName.REQUIRED).children()) {
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
        _loc2_.shopPrice = new ShopPrice(param1.child(NodeName.SHOP_PRICE).child(NodeName.CREDITS).text(), param1.child(NodeName.SHOP_PRICE).child(NodeName.GOLD).text(), param1.child(NodeName.SHOP_PRICE).child(NodeName.ACTION_PRICE_DATA).text());
        _loc2_.displayInfo = this.getNodeDisplayInfo(param1.child(NodeName.DISPLAY)[0]);
        return _loc2_;
    }
}
}
