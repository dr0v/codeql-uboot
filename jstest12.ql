import javascript

from Expr dollarArg,CallExpr dollarCall
where dollarCall.getCalleeName().regexpMatch("get(.*)") and
    dollarCall.getReceiver().toString() = "wx" and
    dollarArg = dollarCall.getArgument(0)
select dollarCall,dollarArg
