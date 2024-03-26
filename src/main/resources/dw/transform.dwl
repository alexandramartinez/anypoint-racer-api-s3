%dw 2.0
output application/json indent = false
---
{
    racerId: Mule::p('racerId'),
    averages: payload groupBy $.station orderBy $$
        pluck {
            station: $$,
            temperature: avg($.temperature) as String {format: "##.#####"} as Number
        }
}