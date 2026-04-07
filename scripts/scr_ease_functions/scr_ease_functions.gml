function ease_out(progress,start,final)
{
	final = (final - start)
	progress /= 1;
	return -final * progress * (progress - 2) + start;
}

function ease_square(progress,start,final)
{
	return lerp(start, final , progress )
}

function ease_color(progress,start,final)
{
	return merge_color(start,final,progress)	
}

function ease_in_out_sine(progress, start, final)
{
	return (!(progress < 0.5) ? ease_out_sine : ease_in_sine)(progress, start, final)
}

function ease_out_sine(progress, start, final)
{
    return lerp(start, final, sin((progress * pi) / 2))
}

function ease_in_out(progress, start, final)
{
    var change = final - start;

    if (progress < 0.5)
    {
        return start + change * 2 * progress * progress;
    }
    else
    {
        return start + change * (1 - power(-2 * progress + 2, 2) / 2);
    }
}

function ease_in_sine(progress,start,final)
{
	return final * (1 - cos(progress* (pi / 2))) + start
}
function ease_in_back(progress,start,final)
{
	var outputmax = final - start
	var _s = 1.70158;
	return outputmax * progress * progress * ((_s + 1) * progress - _s) + start;
}

function ease_out_back(progress, start, final,strenght = 1.70158) 
{
    var t = progress - 1; 
    var change = final - start;
    return change * (t * t * ((strenght + 1) * t + strenght) + 1) + start;
}
function ease_in_out_back(progress,start,final)
{
	var outputmax = final - start
	progress *= 2
	var _s = 1.70158;
	if (progress < 1)
	{
	    _s *= 1.525;
	    return outputmax * 0.5 * (progress * progress * ((_s + 1) * progress - _s)) + start;
	}
	progress -= 2;
	_s *= 1.525
	return outputmax * 0.5 * (progress * progress * ((_s + 1) * progress + _s) + 2) + start;
}

function ease_in_out_elastic(progress,start,final)
{
	var outputmax = final - start
	var _s = 1.70158;
	var _p = 0;
	var _a = outputmax;
	if (progress == 0 || _a == 0)
	{
	    return start
	}
	progress /= 0.5
	if (progress == 2)
	{
	    return start+outputmax; 
	}
	if (_p == 0)
	{
	    _p = 1 * (0.3 * 1.5);
	}
	if (_a < abs(outputmax)) 
	{ 
	    _a = outputmax; 
	    _s = _p * 0.25; 
	}
	else
	{
	    _s = _p / (2 * pi) * arcsin (outputmax / _a);
	}
	if (progress < 1)
	{
	    return -0.5 * (_a * power(2, 10 * (--progress)) * sin((progress * 1 - _s) * (2 * pi) / _p)) + start;
	}
	return _a * power(2, -10 * (--progress)) * sin((progress * 1 - _s) * (2 * pi) / _p) * 0.5 + outputmax + start;
}

function ease_in_elastic(progress, start, final) 
{
    var outputmax = final - start;
    if (progress == 0) return start;
    if (progress == 1) return start + outputmax;
    
    var p = 0.3; 
    var s = p / (2 * pi) * arcsin(1); 
    
    return -(outputmax * power(2, 10 * (progress - 1)) 
        * sin((progress - 1 - s) * (2 * pi) / p)) + start;
}

function ease_out_elastic(progress, start, final) 
{
    var outputmax = final - start;
    if (progress == 0) return start;
    if (progress == 1) return start + outputmax;
    
    var p = 0.3;
    var s = p / (2 * pi) * arcsin(1);
    
    return outputmax * power(2, -10 * progress) 
        * sin((progress - s) * (2 * pi) / p) + outputmax + start;
}

function ease_out_bounce(progress,start,final)
{
	var outputmax = final - start;
	if (progress < 1/2.75)
	{
	    return outputmax * 7.5625 * progress * progress + start;
	}
	else
	if (progress < 2/2.75)
	{
	    progress -= 1.5/2.75;
	    return outputmax * (7.5625 * progress * progress + 0.75) + start;
	}
	else
	if (progress < 2.5/2.75)
	{
	    progress -= 2.25/2.75;
	    return outputmax * (7.5625 * progress * progress + 0.9375) + start;
	}
	else
	{
	    progress -= 2.625/2.75;
	    return outputmax * (7.5625 * progress * progress + 0.984375) + start;
	}
}