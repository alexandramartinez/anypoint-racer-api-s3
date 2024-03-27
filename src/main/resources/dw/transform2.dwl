%dw 2.0
output application/json indent = false
---
{
    racerId: Mule::p('racerId'),
    averages: payload orderBy $.station map {
        station: $.station,
        temperature: $.temperature as String {format: "##.#####"} as Number
    }
}