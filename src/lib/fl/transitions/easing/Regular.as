// Copyright ? 2007. Adobe Systems Incorporated. All Rights Reserved.
package fl.transitions.easing {

/**
 *  The Regular class defines three easing functions to implement
 *  accelerated motion with ActionScript animations. The acceleration of motion
 *  for a Regular easing equation is the same as for a timeline tween at 100% easing
 *  and is less dramatic than for the Strong easing equation.
 *  The Regular class is identical to the fl.motion.easing.Quadratic class in functionality.
 *
 * @playerversion Flash 9.0
 * @playerversion AIR 1.0
 * @productversion Flash CS3
 * @langversion 3.0
 * @keyword Ease, Transition
 * @see fl.transitions.TransitionManager
 */
public class Regular {


    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    /**
     * The <code>easeIn()</code> method starts motion from a zero velocity
     * and then accelerates motion as it executes.
     *
     * @param t Specifies the current time, between 0 and duration inclusive.
     *
     * @param b Specifies the initial value of the animation property.
     *
     * @param c Specifies the total change in the animation property.
     *
     * @param d Specifies the duration of the motion.
     *
     * @return The value of the interpolated property at the specified time.
     *
     * @includeExample examples/Regular.easeIn.1.as -noswf
     *
     * @playerversion Flash 9.0
     * @playerversion AIR 1.0
     * @productversion Flash CS3
     * @langversion 3.0
     * @keyword Ease, Transition
     * @see fl.transitions.TransitionManager
     */
    public static function easeIn(t:Number, b:Number,
                                  c:Number, d:Number):Number {
        return c * (t /= d) * t + b;
    }

    /**
     * The <code>easeOut()</code> method starts motion fast
     * and then decelerates motion to a zero velocity as it executes.
     *
     * @param t Specifies the current time, between 0 and duration inclusive.
     *
     * @param b Specifies the initial value of the animation property.
     *
     * @param c Specifies the total change in the animation property.
     *
     * @param d Specifies the duration of the motion.
     *
     * @return The value of the interpolated property at the specified time.
     *
     * @includeExample examples/Regular.easeOut.1.as -noswf
     *
     * @playerversion Flash 9.0
     * @playerversion AIR 1.0
     * @productversion Flash CS3
     * @langversion 3.0
     * @keyword Ease, Transition
     * @see fl.transitions.TransitionManager
     */
    public static function easeOut(t:Number, b:Number,
                                   c:Number, d:Number):Number {
        return -c * (t /= d) * (t - 2) + b;
    }

    /**
     * The <code>easeInOut()</code> method combines the motion
     * of the <code>easeIn()</code> and <code>easeOut()</code> methods
     * to start the motion from a zero velocity,
     * accelerate motion, then decelerate to a zero velocity.
     *
     * @param t Specifies the current time, between 0 and duration inclusive.
     *
     * @param b Specifies the initial value of the animation property.
     *
     * @param c Specifies the total change in the animation property.
     *
     * @param d Specifies the duration of the motion.
     *
     * @return The value of the interpolated property at the specified time.
     *
     * @includeExample examples/Regular.easeInOut.1.as -noswf
     *
     * @playerversion Flash 9.0
     * @playerversion AIR 1.0
     * @productversion Flash CS3
     * @langversion 3.0
     * @keyword Ease, Transition
     * @see fl.transitions.TransitionManager
     */
    public static function easeInOut(t:Number, b:Number,
                                     c:Number, d:Number):Number {
        if ((t /= d / 2) < 1)
            return c / 2 * t * t + b;

        return -c / 2 * ((--t) * (t - 2) - 1) + b;
    }
}

}
