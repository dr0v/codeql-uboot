import javascript
import semmle.javascript.dataflow.TaintTracking
import DataFlow::PathGraph

class Config extends TaintTracking::Configuration {
    Config() { this = "wx.api" }
    
    // override predicate isSource(DataFlow::Node source) {
    //     source instanceof NetworkByteSwap
    // }
    override predicate isSource(DataFlow::Node source) {
        exists(CallExpr dollarCall |
            source.asExpr() instanceof CallExpr and
            dollarCall.getCalleeName().regexpMatch("get(.*)") and
            dollarCall.getReceiver().toString() = "wx" and
            source.asExpr() = dollarCall
         ) 
       }
    
    override predicate isSink(DataFlow::Node sink) {
        // sink = DataFlow::globalVarRef("console").getAMethodCall("log").getArgument(1)
        exists(CallExpr dollarCall |
            dollarCall.getCalleeName() = "console" and
            dollarCall.getReceiver().toString() = "log" and
            sink.asExpr() = dollarCall.getArgument(0)
          )
    }
}

from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source,sink)
select source,sink,"console.log print out "