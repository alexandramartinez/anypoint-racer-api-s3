%dw 2.0
@StreamCapable()
input payload application/json
output application/json indent = false
import indexWhere from dw::core::Arrays
---
payload reduce ((item, acc=[]) -> do {
    @Lazy
    var idx = acc indexWhere $.station == item.station
    @Lazy
    var newItem = {
        (item),
        temperaturesSize: 1,
        temperaturesSum: item.temperature
    }
    ---
    if (idx >= 0) acc update {
        case [idx] -> do {
            @Lazy
            var newCount = $.temperaturesSize + 1
            @Lazy
            var newSum = $.temperaturesSum + item.temperature
            ---
            {
                station: $.station,
                temperature: (newSum / newCount), //as String {format: "##.#####"} as Number,
                temperaturesSize: newCount,
                temperaturesSum: newSum
            }
        }
    }
    else acc + newItem
    // do {
        // @Lazy
        // var spl = acc splitWhere $.station >= item.station
        // ---
        // spl.l + newItem ++ spl.r
    // }
})
