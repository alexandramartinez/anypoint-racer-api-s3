%dw 2.0
output application/json 
//indent = false
// var stations = (payload.station distinctBy $ orderBy $)
fun tailrec(arr, result={}) =
    if (isEmpty(arr)) result
    else tailrec(
        arr[1 to -1],
        result update {
            case x at ."$(arr[0].station)"! -> (x default []) + arr[0].temperature
        }
    )
var obj = tailrec(payload)
---
{
    // racerId: Mule::p('racerId'),
    averages: (keysOf(obj) orderBy $) map ((station) -> {
        station: station,
        temperature: avg(obj[station]) as String {format: "##.#####"} as Number
    })
}