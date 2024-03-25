%dw 2.0
output application/json indent = false
---
{
    racerId: Mule::p('racerId'),
    averages: (payload groupBy $.station) 
        mapObject (($$): avg($.temperature)) 
        pluck ({
            station: $$,
            temperature: $ as String {format: "##.#####"} as Number
        })
        orderBy $.station
}