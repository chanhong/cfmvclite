/*!
 * Copyright 2018 Telerik AD
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

(function(f){
    if (typeof define === 'function' && define.amd) {
        define(["kendo.core"], f);
    } else {
        f();
    }
}(function(){
(function( window, undefined ) {
    kendo.cultures["da-GL"] = {
        name: "da-GL",
        numberFormat: {
            pattern: ["-n"],
            decimals: 2,
            ",": ".",
            ".": ",",
            groupSize: [3],
            percent: {
                pattern: ["-n %","n %"],
                decimals: 2,
                ",": ".",
                ".": ",",
                groupSize: [3],
                symbol: "%"
            },
            currency: {
                name: "Danish Krone",
                abbr: "DKK",
                pattern: ["-n $","n $"],
                decimals: 2,
                ",": ".",
                ".": ",",
                groupSize: [3],
                symbol: "kr."
            }
        },
        calendars: {
            standard: {
                days: {
                    names: ["søndag","mandag","tirsdag","onsdag","torsdag","fredag","lørdag"],
                    namesAbbr: ["søn.","man.","tir.","ons.","tor.","fre.","lør."],
                    namesShort: ["sø","ma","ti","on","to","fr","lø"]
                },
                months: {
                    names: ["januar","februar","marts","april","maj","juni","juli","august","september","oktober","november","december"],
                    namesAbbr: ["jan","feb","mar","apr","maj","jun","jul","aug","sep","okt","nov","dec"]
                },
                AM: ["AM","am","AM"],
                PM: ["PM","pm","PM"],
                patterns: {
                    d: "dd/MM/yyyy",
                    D: "dddd 'den' d. MMMM yyyy",
                    F: "dddd 'den' d. MMMM yyyy h.mm.ss tt",
                    g: "dd/MM/yyyy h.mm tt",
                    G: "dd/MM/yyyy h.mm.ss tt",
                    m: "d. MMMM",
                    M: "d. MMMM",
                    s: "yyyy'-'MM'-'dd'T'HH':'mm':'ss",
                    t: "h.mm tt",
                    T: "h.mm.ss tt",
                    u: "yyyy'-'MM'-'dd HH':'mm':'ss'Z'",
                    y: "MMMM yyyy",
                    Y: "MMMM yyyy"
                },
                "/": "/",
                ":": ".",
                firstDay: 1
            }
        }
    }
})(this);
}));