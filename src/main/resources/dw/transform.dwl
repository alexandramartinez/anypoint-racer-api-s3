%dw 2.0
output application/json indent = false
var stations = (payload.station distinctBy $ orderBy $)
---
{
    racerId: Mule::p('racerId'),
    averages: stations map ((station) -> {
        station: station,
        temperature: avg((payload filter ($.station == station)).temperature) as String {format: "##.#####"} as Number
    })
}