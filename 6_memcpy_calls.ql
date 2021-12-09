import cpp
// from Function f, FunctionCall fc
// where f.getName()="memcpy" and fc.getTarget() = f
// select fc

from FunctionCall fc
where fc.getTarget().getName()="memcpy"
select fc, "is calling memcpy"