package net.wg.gui.battle.views.minimap.constants {
import flash.geom.Point;
import flash.geom.Rectangle;

public class MinimapSizeConst {

    public static const MIN_SIZE_INDEX:int = 0;

    public static const MAP_SIZE:Vector.<Rectangle> = new <Rectangle>[new Rectangle(418, 418, 210, 210), new Rectangle(368, 368, 260, 260), new Rectangle(318, 318, 310, 310), new Rectangle(238, 238, 390, 390), new Rectangle(138, 138, 490, 490), new Rectangle(18, 18, 610, 610)];

    public static const ENTRY_CONTAINER_POINT:Vector.<Point> = new <Point>[new Point(523, 523), new Point(498, 498), new Point(473, 473), new Point(433, 433), new Point(383, 383), new Point(323, 323)];

    public static const ENTRY_SCALES:Vector.<Number> = new <Number>[1, 0.903846153846154, 0.838709677419355, 0.769230769230769, 0.714285714285714, 0.672131147540984];

    public static const ENTRY_INTERNAL_CONTENT_CONTR_SCALES:Vector.<Number> = new <Number>[1, 0.893617021276596, 0.807692307692308, 0.7, 0.6, 0.512195121951219];

    public function MinimapSizeConst() {
        super();
    }
}
}
